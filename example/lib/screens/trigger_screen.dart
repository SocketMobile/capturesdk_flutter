import 'dart:io';

import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:flutter/material.dart';

enum _SocketCamMode { fullScreen, customView }

class TriggerScreen extends StatefulWidget {
  const TriggerScreen({
    super.key,
    required this.device,
    required this.decodedDataNotifier,
    required this.helper,
  });

  final CaptureHelperDevice device;
  final ValueNotifier<int> decodedDataNotifier;
  final CaptureHelper helper;

  @override
  State<TriggerScreen> createState() => _TriggerScreenState();
}

class _TriggerScreenState extends State<TriggerScreen> {
  String? _result;
  String? _error;
  _SocketCamMode? _socketCamMode;

  bool get _isSocketCam => SocketCamTypes.contains(widget.device.type);

  @override
  void initState() {
    super.initState();
    widget.decodedDataNotifier.addListener(_onDecodedData);
  }

  @override
  void dispose() {
    widget.decodedDataNotifier.removeListener(_onDecodedData);
    super.dispose();
  }

  void _onDecodedData() {
    if (_socketCamMode != null) {
      _dismissSocketCam();
    }
  }

  Future<void> _setTrigger(int action, String label) async {
    setState(() {
      _result = null;
      _error = null;
    });
    try {
      await widget.device.setTrigger(action);
      setState(() => _result = label);
    } on CaptureException catch (e) {
      setState(() => _error = 'Error: ${e.code} ${e.message}');
    }
  }

  /// Triggers the SocketCam scanner.
  ///
  /// **iOS** supports both full-screen and custom view modes natively.
  /// Full-screen presents the SDK's view controller modally.
  /// Custom view mounts a [SocketCamView] widget in the tree.
  ///
  /// **Android** uses the SDK's built-in full-screen Activity.
  /// The CaptureExtension is started WITHOUT a CustomViewListener, so
  /// [setTrigger(Trigger.start)] opens the camera Activity automatically.
  ///
  /// **Android custom view mode** is possible but requires changes to the
  /// native CaptureModule.java — see the commented code in that file.
  /// CaptureExtension is a **singleton**: the first build() call locks in
  /// the config (with or without CustomViewListener) for the process
  /// lifetime. You cannot switch between modes at runtime on Android.
  Future<void> _triggerSocketCam(_SocketCamMode mode) async {
    setState(() {
      _result = null;
      _error = null;
    });
    try {
      if (Platform.isAndroid) {
        // Android: full-screen only. The SDK opens its own camera Activity.
        await widget.device.setTrigger(Trigger.start);
        //
        // --- Android custom view mode ---
        // To embed the camera inside your layout instead of full-screen:
        // 1. In CaptureModule.java, uncomment the CustomViewListener code
        //    (see the class Javadoc and commented sections).
        // 2. Mount a SocketCamView widget (min 400x400) in your layout.
        // 3. Call setTrigger(Trigger.start) on the device.
        //
        // Example Dart layout:
        //   Positioned(
        //     right: 16, bottom: 16,
        //     width: MediaQuery.of(context).size.width * 0.6,
        //     height: MediaQuery.of(context).size.height / 2,
        //     child: SocketCamView(device: device),
        //   )
      } else {
        // iOS: supports both full-screen and custom view modes.
        await widget.device.setTrigger(Trigger.start);
        if (mode == _SocketCamMode.fullScreen) {
          await SocketCamView.presentFullScreen();
        } else {
          setState(() => _socketCamMode = mode);
        }
      }
    } on CaptureException catch (e) {
      setState(() {
        _error = 'Error: ${e.code} ${e.message}';
        _socketCamMode = null;
      });
    }
  }

  void _dismissSocketCam() {
    setState(() {
      _socketCamMode = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            if (_socketCamMode != null) {
              _dismissSocketCam();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text('Set Trigger',
            style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.device.name,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 24),
                if (_isSocketCam) ...<Widget>[
                  if (Platform.isAndroid) ...<Widget>[
                    // Android: single button — SDK handles full-screen display
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A84FF),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      onPressed: () =>
                          _triggerSocketCam(_SocketCamMode.fullScreen),
                      child: const Text('Trigger SocketCam'),
                    ),
                  ] else ...<Widget>[
                    // iOS: both full-screen and custom view are available
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A84FF),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      onPressed: () =>
                          _triggerSocketCam(_SocketCamMode.fullScreen),
                      child:
                          const Text('Set Trigger SocketCam full screen'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A84FF),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      onPressed: () =>
                          _triggerSocketCam(_SocketCamMode.customView),
                      child:
                          const Text('Set Trigger SocketCam custom view'),
                    ),
                  ],
                ] else ...<Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A84FF),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    onPressed: () =>
                        _setTrigger(Trigger.start, 'Trigger started'),
                    child: const Text('Start'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A84FF),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    onPressed: () =>
                        _setTrigger(Trigger.stop, 'Trigger stopped'),
                    child: const Text('Stop'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A84FF),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    onPressed: () =>
                        _setTrigger(Trigger.continuousScan, 'Continuous scan'),
                    child: const Text('Continuous'),
                  ),
                ],
                if (_result != null) ...<Widget>[
                  const SizedBox(height: 16),
                  Text(
                    _result!,
                    style:
                        const TextStyle(color: Colors.white, fontSize: 16),
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
          // iOS custom view overlay (Android custom view is not active in this example)
          if (_socketCamMode == _SocketCamMode.customView)
            Positioned(
              right: 16,
              bottom: 16,
              // Minimum 400x400 to properly display the preview and avoid issues with the camera stream.
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SocketCamView(device: widget.device),
              ),
            ),
        ],
      ),
    );
  }
}
