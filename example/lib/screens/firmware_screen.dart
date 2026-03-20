import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:flutter/material.dart';

class FirmwareScreen extends StatefulWidget {
  const FirmwareScreen({super.key, required this.device});

  final CaptureHelperDevice device;

  @override
  State<FirmwareScreen> createState() => _FirmwareScreenState();
}

class _FirmwareScreenState extends State<FirmwareScreen> {
  String? _version;
  bool _loading = false;
  String? _error;

  Future<void> _getFirmwareVersion() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final Version version = await widget.device.getFirmwareVersion();
      final String display = '${version.major}.${version.middle}.${version.minor}';
      setState(() {
        _version = display;
        _loading = false;
      });
    } on CaptureException catch (e) {
      setState(() {
        _error = 'Error: ${e.code} ${e.message}';
        _loading = false;
      });
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
          'Firmware Version',
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
              onPressed: _loading ? null : _getFirmwareVersion,
              child: _loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Get Firmware Version'),
            ),
            if (_version != null) ...<Widget>[
              const SizedBox(height: 16),
              Text(
                _version!,
                style: const TextStyle(color: Colors.white, fontSize: 18),
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
