import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:flutter/material.dart';

class DataConfirmationScreen extends StatefulWidget {
  const DataConfirmationScreen({
    super.key,
    required this.device,
    required this.helper,
  });

  final CaptureHelperDevice device;
  final CaptureHelper helper;

  @override
  State<DataConfirmationScreen> createState() => _DataConfirmationScreenState();
}

class _DataConfirmationScreenState extends State<DataConfirmationScreen> {
  // Mode and action are write-only Capture properties (Get Type: None), so the
  // screen keeps its own local state rather than reading the current value back.
  int _mode = DataConfirmationMode.modeApp;
  int _led = DataConfirmationLed.none;
  int _beep = DataConfirmationBeep.none;
  int _rumble = DataConfirmationRumble.none;

  String? _result;
  String? _error;

  int get _action => CaptureHelper.composeDataConfirmationAction(
        led: _led,
        beep: _beep,
        rumble: _rumble,
      );

  Future<void> _apply() async {
    setState(() {
      _result = null;
      _error = null;
    });
    try {
      await widget.helper.setDataConfirmationMode(_mode);
      await widget.helper.setDataConfirmationAction(_action);
      setState(() => _result = 'Applied');
    } on CaptureException catch (e) {
      setState(() => _error = 'Error: ${e.code} ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Data Confirmation',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.device.name,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 24),
            _Dropdown(
              label: 'Mode',
              value: _mode,
              items: const <_Option>[
                _Option('Off', DataConfirmationMode.modeOff),
                _Option('Device', DataConfirmationMode.modeDevice),
                _Option('Capture', DataConfirmationMode.modeCapture),
                _Option('App', DataConfirmationMode.modeApp),
              ],
              onChanged: (int v) => setState(() => _mode = v),
            ),
            const SizedBox(height: 16),
            _Dropdown(
              label: 'LED',
              value: _led,
              items: const <_Option>[
                _Option('None', DataConfirmationLed.none),
                _Option('Green', DataConfirmationLed.green),
                _Option('Red', DataConfirmationLed.red),
              ],
              onChanged: (int v) => setState(() => _led = v),
            ),
            const SizedBox(height: 16),
            _Dropdown(
              label: 'Beep',
              value: _beep,
              items: const <_Option>[
                _Option('None', DataConfirmationBeep.none),
                _Option('Good', DataConfirmationBeep.good),
                _Option('Bad', DataConfirmationBeep.bad),
              ],
              onChanged: (int v) => setState(() => _beep = v),
            ),
            const SizedBox(height: 16),
            _Dropdown(
              label: 'Rumble',
              value: _rumble,
              items: const <_Option>[
                _Option('None', DataConfirmationRumble.none),
                _Option('Good', DataConfirmationRumble.good),
                _Option('Bad', DataConfirmationRumble.bad),
              ],
              onChanged: (int v) => setState(() => _rumble = v),
            ),
            const SizedBox(height: 16),
            Text(
              'Action: 0x${_action.toRadixString(16).padLeft(8, '0')}',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A84FF),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: _apply,
              child: const Text('Apply'),
            ),
            const SizedBox(height: 16),
            const Text(
              'The action is applied by the scanner only in Capture mode. '
              'In App mode, the application confirms each scan via '
              'device.setDataConfirmation(...).',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            if (_result != null) ...<Widget>[
              const SizedBox(height: 16),
              Text(
                _result!,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
            if (_error != null) ...<Widget>[
              const SizedBox(height: 16),
              Text(
                _error!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Option {
  const _Option(this.label, this.value);

  final String label;
  final int value;
}

class _Dropdown extends StatelessWidget {
  const _Dropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final int value;
  final List<_Option> items;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Expanded(
          child: DropdownButton<int>(
            value: value,
            isExpanded: true,
            dropdownColor: const Color(0xFF1C1C1E),
            style: const TextStyle(color: Colors.white, fontSize: 16),
            onChanged: (int? v) {
              if (v != null) {
                onChanged(v);
              }
            },
            items: items
                .map(
                  (_Option o) => DropdownMenuItem<int>(
                    value: o.value,
                    child: Text(o.label),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
