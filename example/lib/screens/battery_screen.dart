import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:flutter/material.dart';

class BatteryScreen extends StatefulWidget {
  const BatteryScreen({super.key, required this.device});

  final CaptureHelperDevice device;

  @override
  State<BatteryScreen> createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen> {
  String? _batteryLevel;
  String? _powerState;
  String? _error;

  Future<void> _getBatteryLevel() async {
    setState(() => _error = null);
    try {
      final int percent = await widget.device.getBatteryLevel();
      setState(() => _batteryLevel = '$percent%');
    } on CaptureException catch (e) {
      setState(() => _error = 'Error: ${e.code} ${e.message}');
    }
  }

  Future<void> _getPowerState() async {
    setState(() => _error = null);
    try {
      final int state = await widget.device.getPowerState();
      setState(() => _powerState = '$state');
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
          'Battery Level',
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A84FF),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: _getBatteryLevel,
              child: const Text('Get Battery Level'),
            ),
            if (_batteryLevel != null) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                'Battery: $_batteryLevel',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A84FF),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: _getPowerState,
              child: const Text('Get Power State'),
            ),
            if (_powerState != null) ...<Widget>[
              const SizedBox(height: 8),
              Text(
                'Power State: $_powerState',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
            if (_error != null) ...<Widget>[
              const SizedBox(height: 16),
              Text(
                _error!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
