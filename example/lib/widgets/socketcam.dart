// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:capturesdk_flutter/capturesdk.dart';
import 'dart:io';
import 'radiobuttons.dart';

abstract class OptInterface {
  String get message;
  String get buttonText;
  int get value;
}

final List<Map<String, dynamic>> triggerOptions = [
  {'label': 'Start', 'value': Trigger.start},
  {'label': 'Stop', 'value': Trigger.stop},
  {'label': 'Continuous Scan', 'value': Trigger.continuousScan},
];

Map<int, Map<String, dynamic>> androidSupportOpts = {
  1: {'message': 'NOT_SUPPORTED', 'buttonText': 'Enable Support', 'value': 1},
  2: {'message': 'SUPPORTED', 'buttonText': 'Disable Support', 'value': 2},
  3: {'message': 'ENABLE', 'buttonText': 'Enable', 'value': 3},
  4: {'message': 'Disable', 'buttonText': 'Disable', 'value': 4},
};

Map<int, Map<String, dynamic>> iosSupportOpts = {
  0: {'message': 'ENABLED', 'buttonText': 'Enable', 'value': 0},
  1: {'message': 'Disable', 'buttonText': 'Disable', 'value': 1},
};

Map<int, int> androidInverse = {
  3: 4,
  4: 3,
};

Map<int, int> iosInverse = {
  0: 1,
  1: 0,
};

class SocketCamWidget extends StatefulWidget {
  final int? clientOrDeviceHandle;
  final Capture? socketCamCapture;
  final Capture? socketCamDevice;
  final Function setStatus;
  final Logger? logger;

  const SocketCamWidget(
      {Key? key,
      required this.clientOrDeviceHandle,
      required this.socketCamCapture,
      required this.socketCamDevice,
      this.logger,
      required this.setStatus})
      : super(key: key);

  // Add any required constructor parameters if needed
  @override
  _SocketCamState createState() => _SocketCamState();
}

class _SocketCamState extends State<SocketCamWidget> {
  late Function setStatus;

  int _socketCamEnabled = 0;
  int _triggerType = 1;
  String _socketCamExtensionStatus = 'Not Ready';
  Map<int, Map<String, dynamic>> _supportOpts = {};
  Map<int, int> _inverse = {};
  int _os = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      setStatus = widget.setStatus;
    });
    clientOrDeviceCheck();
  }

  @override
  void dispose() {
    // Clean up resources, if needed
    super.dispose();
  }

  void clientOrDeviceCheck() {
    if (widget.clientOrDeviceHandle != null) {
      if (Platform.isAndroid) {
        setState(() {
          _os = 1;
          _inverse = androidInverse;
          _supportOpts = androidSupportOpts;
        });
        _startSocketCamExtension(widget.clientOrDeviceHandle);
      } else {
        setState(() {
          _os = 0;
          _inverse = iosInverse;
          _supportOpts = iosSupportOpts;
        });
        getSocketCamStatus(true);
      }
    }
  }

  Future<void> getSocketCamStatus(bool fromCallback) async {
    CaptureProperty property = const CaptureProperty(
      id: CapturePropertyIds.socketCamStatus,
      type: CapturePropertyTypes.none,
      value: {},
    );

    try {
      var data = await widget.socketCamCapture!.getProperty(property);
      Map<String, dynamic> x = _supportOpts[data.value]!;
      setState(() {
        _socketCamEnabled = data.value;
      });
      if (!fromCallback) {
        setStatus('successfully retrieved SocketCamStatus: ${x['message']}');
      }
      if (widget.socketCamDevice != null) {
        _setOverlayView();
      }
    } on CaptureException catch (exception) {
      String code = exception.code.toString();
      String message = exception.message;
      setStatus('failed to get SocketCamStatus: $code : $message');
    }
  }

  Future<void> _setSocketCamStatus(int? arg) async {
    Logger? _myLogger = widget.logger;
    CaptureProperty property = CaptureProperty(
      id: CapturePropertyIds.socketCamStatus,
      type: CapturePropertyTypes.byte,
      value: arg,
    );

    try {
      await widget.socketCamCapture?.setProperty(property);
      _myLogger?.log('Socket Cam Status: ', _socketCamEnabled.toString());
      setStatus(
        'successfully changed socket cam status: ${_supportOpts[arg]?['message']}',
      );
      getSocketCamStatus(false);
    } on CaptureException catch (exception) {
      String code = exception.code.toString();
      String message = exception.message;
      _myLogger?.log('$code :', message);
      setStatus('failed to set socket cam status: $code :', message);
    }
  }

  int _socketCamValueHelper() {
    int defaultValue =
        0; // Provide a default value that makes sense for your use case
    if (_os == 1) {
      return _socketCamEnabled == 1
          ? 2
          : _inverse[_socketCamEnabled] ?? defaultValue;
    } else {
      return _inverse[_socketCamEnabled] ?? defaultValue;
    }
  }

  dynamic _startSocketCamExtensionCallback(eventData) {
    var message = eventData['message'], status = eventData['status'];

    setState(() {
      _socketCamExtensionStatus = message;
    });

    if (status == 2) {
      getSocketCamStatus(true);
    }
  }

  Future<void> _startSocketCamExtension(int? clientHandle) async {
    setState(() {
      _socketCamExtensionStatus = "Starting...";
    });

    CapturePlugin.startSocketCamExtension(clientHandle,
        _startSocketCamExtensionCallback); // Use the Flutter plugin
  }

  void _setOverlayView() async {
    CaptureProperty property = const CaptureProperty(
      id: CapturePropertyIds.overlayViewDevice,
      type: CapturePropertyTypes.object,
      value: {"SocketCamContext": 0x1234},
    );

    try {
      await widget.socketCamDevice!.setProperty(property);
      setStatus("successfully set OverlayView!");
    } on CaptureException catch (exception) {
      String code = exception.code.toString();
      String message = exception.message;
      setStatus("failed to set OverlayView: $code : $message");
    }
  }

  Future<void> _setSocketCamTrigger() async {
    CaptureProperty property = CaptureProperty(
      id: CapturePropertyIds
          .triggerDevice, // Replace with the correct id value for TriggerDevice
      type: CapturePropertyTypes
          .byte, // Replace with the correct type value for Byte
      value: _triggerType,
    );

    try {
      await widget.socketCamDevice?.setProperty(property);
      var triggerOpt =
          triggerOptions.firstWhere((x) => x["value"] == _triggerType);
      setStatus("successfully changed TriggerDevice: '${triggerOpt["label"]}'");
    } on CaptureException catch (exception) {
      String code = exception.code.toString();
      String message = exception.message; // Replace with your errorCheck method
      widget.logger?.log("$code :", message);
      setStatus("failed to set TriggerDevice: $code : $message");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Handle enabling/disabling SocketCam
              int stat = _socketCamValueHelper();
              _setSocketCamStatus(stat);
            },
            child: Text(_socketCamEnabled == 3 || _socketCamEnabled == 0
                ? 'Disable'
                : 'Enable'),
            style: _socketCamEnabled == 3 || _socketCamEnabled == 0
                ? ElevatedButton.styleFrom(backgroundColor: Colors.red)
                : ElevatedButton.styleFrom(backgroundColor: Colors.green),
          ),
          const Text('SOCKET CAM',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          _os == 1
              ? Text("SOCKET CAM EXTENSION STATUS: $_socketCamExtensionStatus")
              : const SizedBox(),
          Row(
            children: [
              Expanded(
                child: widget.socketCamCapture == null
                    ? const Text('Open Capture To Try Socket Cam!')
                    : Text(_socketCamEnabled == 4 || _socketCamEnabled == 1
                        ? 'Enable Socket Cam (top right) to get started!'
                        : ''),
              ),
              Expanded(
                child: widget.socketCamDevice == null
                    ? const Text('No Socket Cam Device Found.')
                    : _socketCamEnabled == 3 || _socketCamEnabled == 0
                        ? Column(
                            children: [
                              RadioButtons(
                                title: 'Scan Trigger Type',
                                data: triggerOptions,
                                setTriggerType: (value) {
                                  setState(() {
                                    _triggerType = value;
                                  });
                                },
                                value: _triggerType,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _setSocketCamTrigger();
                                },
                                child: const Text('Open Socket Cam!'),
                              ),
                            ],
                          )
                        : const SizedBox(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
