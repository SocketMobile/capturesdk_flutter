import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../capture_helper_device.dart';

const String _kSocketCamViewType = 'com.socketmobile.capturesdk/socket_cam_view';
const MethodChannel _kSocketCamChannel = MethodChannel('com.socketmobile.capturesdk/socket_cam');

class SocketCamView extends StatelessWidget {
  const SocketCamView({super.key, required this.device});

  final CaptureHelperDevice device;

  /// Presents the native SocketCam view controller as a full-screen modal (iOS only).
  ///
  /// Call [CaptureHelperDevice.setTrigger] with [Trigger.start] before invoking
  /// this method so the SDK has created the SocketCam view controller.
  ///
  /// The SocketCam view controller is automatically dismissed by the SDK when
  /// a barcode is decoded.
  static Future<void> presentFullScreen() async {
    if (!Platform.isIOS) {
      return;
    }
    await _kSocketCamChannel.invokeMethod<void>('presentSocketCamFullScreen');
  }

  static Future<void> dismiss() async {
    if (!Platform.isIOS) {
      return;
    }
    await _kSocketCamChannel.invokeMethod<void>('dismissSocketCam');
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return UiKitView(
        viewType: _kSocketCamViewType,
        layoutDirection: TextDirection.ltr,
        creationParams: <String, dynamic>{'handle': device.handle},
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else {
      return AndroidView(
        viewType: _kSocketCamViewType,
        layoutDirection: TextDirection.ltr,
        creationParams: <String, dynamic>{'handle': device.handle},
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
  }
}
