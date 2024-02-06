// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';

import 'package:example/widgets/footer.dart';
import 'package:example/widgets/mainview.dart';
import 'package:example/widgets/socketcam.dart';
import 'package:flutter/material.dart';
import 'package:capturesdk_flutter/capturesdk.dart';

const AppInfo appInfo = AppInfo(
    appIdAndroid: 'android:com.example.example',
    appKeyAndroid:
        'MC4CFQDNCtjazxILEh8oyT6w/wlaVKqS1gIVAKTz2W6TB9EgmjS1buy0A+3j7nX4',
    appIdIos: 'ios:com.example.example',
    appKeyIos:
        'MC0CFA1nzK67TLNmSw/QKFUIiedulUUcAhUAzT6EOvRwiZT+h4qyjEZo9oc0ONM=',
    developerId: 'bb57d8e1-f911-47ba-b510-693be162686a');

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Capture SDK Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Capture SDK Demo Homepage'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _status = 'starting';
  String _message = '--';
  List<DeviceInfo> _devices = [];
  List<DecodedData> _decodedDataList = [];
  Capture? _capture;
  Capture? _deviceCapture;
  Capture? _bleDeviceManagerCapture;
  Capture? _socketcamDevice;
  bool _useSocketCam = false;
  bool _isOpen = false;

  Logger logger = Logger((message, arg) {
    if (message.isNotEmpty) {
      // ignore: avoid_print
      print('CAPTURE FLUTTER: $message $arg\n\n');
    } else {
      // ignore: avoid_print
      print('CAPTURE FLUTTER: $arg\n\n');
    }
  });

  void _updateVals(String stat, String mess,
      [String? method, String? details]) {
    setState(() {
      _status = stat;
      String tempMsg = mess;
      if (method != null) {
        tempMsg += '\n Method: ' + method + '\n';
      }
      if (details != null) {
        tempMsg += '\n Details: ' + details + '\n';
      }
      _message = tempMsg;
    });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      // Need to start service if you do not want to manually open Socket Mobile Companion
      // start capture service for companion before using Socket Cam on Android
      _initializeCaptureService();
    } else {
      _openCapture();
    }
  }

  Future<void> _initializeCaptureService() async {
    try {
      // Wait for the completion of startCaptureService
      await CapturePlugin.startCaptureService();
      // Once startCaptureService completes, call _openCapture
      _openCapture();
    } catch (error) {
      // Handle errors here
      _updateVals('Error initializing Capture Service', error.toString());
    }
  }

  Future _openCapture() async {
    Capture capture = Capture(logger);

    setState(() {
      _capture = capture;
    });

    String stat = _status;
    String mess = _message;
    String? method;
    String? details;

    try {
      int? response = await capture.openClient(appInfo, _onCaptureEvent);
      stat = 'handle: $response';
      mess = 'capture open success';
      setState(() {
        _isOpen = true;
      });
    } on CaptureException catch (exception) {
      stat = exception.code.toString();
      mess = exception.message;
      method = exception.method;
      details = exception.details;
      if (Platform.isAndroid) {
        if (details != null) {
          details = details + " Is Socket Mobile Companion app installed?";
        } else {
          details = "Is Socket Mobile Companion app installed?";
        }
      }
    }
    _updateVals(stat, mess, method, details);
  }

  Future _openDeviceHelper(
      Capture deviceCapture, CaptureEvent e, bool isManager, int handle) async {
    // deviceArrival checks that a device is available
    // openDevice allows the device to be used (for decodedData)
    List<DeviceInfo> arr = _devices;

    DeviceInfo _deviceInfo = e.deviceInfo;

    logger.log('Device ${isManager ? 'Manager' : ''} Arrival =>',
        '${_deviceInfo.name} (${_deviceInfo.guid})');

    try {
      await deviceCapture.openDevice(_deviceInfo.guid, _capture);
      if (!isManager) {
        if (!arr.contains(_deviceInfo)) {
          if (SocketCamTypes.contains(_deviceInfo.type)) {
            setState(() {
              _socketcamDevice = deviceCapture;
            });
          } else {
            setState(() {
              _deviceCapture = deviceCapture;
            });
          }
          arr.add(_deviceInfo);
          setState(() {
            _devices = arr;
          });
        }
      } else {
        setState(() {
          _bleDeviceManagerCapture = deviceCapture;
        });
        _getFavorite(deviceCapture);
      }
      _updateVals('Device${isManager ? ' Manager' : ''} Opened',
          'Successfully added "${_deviceInfo.name}"');
    } on CaptureException catch (exception) {
      _updateVals(exception.code.toString(), exception.message,
          exception.method, exception.details);
    }
  }

  Future<void> _closeDeviceHelper(e, handle, bool isManager) async {
    String guid = e.value["guid"];
    String name = e.value["name"];
    logger.log(
        'Device ${isManager ? 'Manager' : ''} Removal =>', name + ' ($guid)');

    try {
      dynamic res = await _deviceCapture!.close();
      if (res == 0) {
        List<DeviceInfo> arr = _devices;
        arr.removeWhere((element) => element.guid == guid);
        setState(() {
          _devices = arr;
          _deviceCapture = null;
        });
        if (_bleDeviceManagerCapture != null &&
            guid == _bleDeviceManagerCapture!.guid) {
          setState(() {
            _bleDeviceManagerCapture = null;
          });
          (null);
        } else {
          setState(() {
            _deviceCapture = null;
          });
        }
      }
      _updateVals('Device ${isManager ? 'Manager' : ''} Closed',
          'Successfully removed "$name"');
    } on CaptureException catch (exception) {
      _updateVals('${exception.code}', 'Unable to remove "$name"',
          exception.method, exception.details);
    }
  }

  _onCaptureEvent(e, handle) {
    if (e == null) {
      return;
    } else if (e.runtimeType == CaptureException) {
      _updateVals("${e.code}", e.message, e.method, e.details);
      return;
    }

    logger.log('onCaptureEvent from: ', '$handle');

    switch (e.id) {
      case CaptureEventIds.deviceArrival:
        Capture deviceCapture = Capture(logger);
        _openDeviceHelper(deviceCapture, e, false, handle);
        break;
      case CaptureEventIds.deviceRemoval:
        if (_deviceCapture != null) {
          _closeDeviceHelper(e, handle, false);
        }
        break;

      case CaptureEventIds.decodedData:
        setStatus('Decoded Data', 'Successfully decoded data!');
        List<DecodedData> _myList = [..._decodedDataList];
        Map<String, dynamic> jsonMap = e.value as Map<String, dynamic>;
        DecodedData decoded = DecodedData.fromJson(jsonMap);
        _myList.add(decoded);
        setState(() {
          _decodedDataList = _myList;
        });
        break;
      case CaptureEventIds.deviceManagerArrival:
        Capture bleDeviceManagerCapture = Capture(logger);
        _openDeviceHelper(bleDeviceManagerCapture, e, true, handle);
        break;
      case CaptureEventIds.deviceManagerRemoval:
        if (_deviceCapture != null) {
          _closeDeviceHelper(e, handle, true);
        }
        break;
    }
  }

  Future<void> _closeCapture() async {
    try {
      final res = await _capture!.close();
      setStatus("Success in closing Capture: $res");
      setState(() {
        _isOpen = false;
        _devices = [];
        _useSocketCam = false;
      });
    } on CaptureException catch (exception) {
      int code = exception.code;
      String messge = exception.message;
      setStatus("failed to close capture: $code: $messge");
    }
  }

  void setStatus(String stat, [String? msg]) {
    setState(() {
      _status = stat;
      _message = msg ?? _message;
    });
  }

  void _setUseSocketCam(bool val) {
    setState(() {
      _useSocketCam = val;
    });
  }

  void _clearAllScans() {
    setState(() {
      _decodedDataList = [];
    });
  }

  Future<void> _getFavorite(Capture dev) async {
    CaptureProperty property = const CaptureProperty(
      id: CapturePropertyIds.favorite,
      type: CapturePropertyTypes.none,
      value: {},
    );

    String stat = "retrieving BLE Device Manager favorite...";
    setStatus(stat);
    try {
      var favorite = await dev.getProperty(property);
      logger.log(favorite.value, 'GET Favorite');
      if (favorite.value.length == 0) {
        setFavorite(dev);
      } else {
        stat = "Favorite found! Try using an NFC Reader.";
      }
    } on CaptureException catch (exception) {
      var code = exception.code.toString();
      var message = exception.message;
      logger.log(code, message);
      stat = 'failed to get favorite: $code : $message';
    }
    setStatus(stat);
  }

  Future<void> setFavorite(Capture dev) async {
    CaptureProperty property = const CaptureProperty(
      id: CapturePropertyIds.favorite,
      type: CapturePropertyTypes.string,
      value: '*',
    );

    String stat = 'successfully set favorite for BLE Device Manager';

    try {
      var data = await dev.setProperty(property);
      logger.log(data.value.toString(), 'SET Favorite');
    } on CaptureException catch (exception) {
      var code = exception.code.toString();
      var message = exception.message;
      logger.log(code, message);
      stat = 'failed to set favorite: $code : $message';
    }
    setStatus(stat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // TestWidget(),
              Row(children: <Widget>[
                const Text(
                  'Status: ',
                ),
                Text(
                  _status,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ]),
              Row(children: <Widget>[
                const Text(
                  'Message: ',
                ),
                Flexible(
                  child: Text(
                    _message,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ]),
              !_useSocketCam
                  ? MainView(
                      deviceCapture: _deviceCapture, setStatus: setStatus)
                  : SocketCamWidget(
                      clientOrDeviceHandle: _capture!.clientOrDeviceHandle,
                      socketCamCapture: _capture,
                      socketCamDevice: _socketcamDevice,
                      logger: logger,
                      setStatus: setStatus),
              const Row(children: <Widget>[
                Text(
                  'Devices',
                ),
              ]),
              _devices.isEmpty
                  ? const Center(child: Text('No Devices Available'))
                  : ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      itemCount: _devices.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text('${index + 1}. ' +
                            _devices[index].name +
                            ': ' +
                            _devices[index].guid);
                      },
                    ),
              FooterWidget(
                  clearAllScans: _clearAllScans,
                  decodedDataList: _decodedDataList,
                  isOpen: _isOpen,
                  closeCapture: _closeCapture,
                  openCapture: _openCapture,
                  useSocketCam: _useSocketCam,
                  setUseSocketCam: _setUseSocketCam)
            ],
          ),
        ));
  }
}
