import 'dart:typed_data';

import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:flutter/material.dart';

class PowerTimersScreen extends StatefulWidget {
  const PowerTimersScreen({super.key, required this.device});

  final CaptureHelperDevice device;

  @override
  State<PowerTimersScreen> createState() => _PowerTimersScreenState();
}

class _PowerTimersScreenState extends State<PowerTimersScreen> {
  String? _timers;
  String? _error;

  ({int triggerLock, int connected, int disconnected})? _parseTimerBytes(dynamic raw) {
    List<int> bytes;
    if (raw is Uint8List) {
      bytes = raw;
    } else if (raw is List<int>) {
      bytes = raw;
    } else {
      return null;
    }
    if (bytes.length < 6) {
      return null;
    }
    final ByteData bd = Uint8List.fromList(bytes).buffer.asByteData();
    return (
      triggerLock: bd.getUint16(0, Endian.little),
      connected: bd.getUint16(2, Endian.little),
      disconnected: bd.getUint16(4, Endian.little),
    );
  }

  Future<void> _getTimers() async {
    setState(() => _error = null);
    try {
      final dynamic raw = await widget.device.getTimers();
      final ({int connected, int disconnected, int triggerLock})? parsed = _parseTimerBytes(raw);
      if (parsed != null) {
        setState(() {
          _timers = 'Power Off Timers:\n'
              'Trigger Lock: ${parsed.triggerLock}s\n'
              'Connected: ${parsed.connected}s\n'
              'Disconnected: ${parsed.disconnected}s';
        });
      } else {
        setState(() => _timers = 'Raw: $raw');
      }
    } on CaptureException catch (e) {
      setState(() => _error = 'Error: ${e.code} ${e.message}');
    }
  }

  Future<void> _setTimers() async {
    setState(() => _error = null);
    try {
      // Encode as 3 UInt16 little-endian values: triggerLock, connected, disconnected
      final ByteData bd = ByteData(6);
      bd.setUint16(0, 5, Endian.little); // trigger lock: 5s
      bd.setUint16(2, 5, Endian.little); // connected: 5s
      bd.setUint16(4, 5, Endian.little); // disconnected: 5s
      await widget.device.setTimers(bd.buffer.asUint8List());
      setState(() {
        _timers = 'Timers set:\n'
            'Trigger Lock: 5s\n'
            'Connected: 5s\n'
            'Disconnected: 5s';
      });
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
          'Power Off Timers',
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
              onPressed: _getTimers,
              child: const Text('Get Timers'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A84FF),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: _setTimers,
              child: const Text('Set Timers (5s each)'),
            ),
            if (_timers != null) ...<Widget>[
              const SizedBox(height: 16),
              Text(
                _timers!,
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
