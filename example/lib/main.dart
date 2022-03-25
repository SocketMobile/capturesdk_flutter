import 'package:flutter/material.dart';
import 'package:capturesdk/capturesdk.dart';

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
  String _newName = '';
  Capture? _capture;
  Capture? _deviceCapture;
  CaptureEvent? _currentScan;
  final _nameController = TextEditingController();

  var logger = Logger((message, arg) => {
        if (message != null && message.isNotEmpty)
          {print(message + " " + arg + '\n\n')}
        else
          {print(arg + '\n\n')}
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
    _nameController.addListener(_handleNameChange);

    _openCapture();

    super.initState();
  }

  Future _openCapture() async {
    setState(() {
      _capture = null;
    });

    Capture capture = Capture(logger);

    setState(() {
      _capture = capture;
    });

    final AppInfo appInfo = AppInfo(
        'android:com.example.example',
        'MC4CFQDNCtjazxILEh8oyT6w/wlaVKqS1gIVAKTz2W6TB9EgmjS1buy0A+3j7nX4',
        'ios:com.example.example',
        'MC0CFA1nzK67TLNmSw/QKFUIiedulUUcAhUAzT6EOvRwiZT+h4qyjEZo9oc0ONM=',
        'bb57d8e1-f911-47ba-b510-693be162686a');
    String stat = _status;
    String mess = _message;
    String? method;
    String? details;
    try {
      int? response = await capture.openClient(appInfo, _onCaptureEvent);
      stat = 'handle: $response';
      mess = 'capture open success';
    } on CaptureException catch (exception) {
      stat = exception.code.toString();
      mess = exception.message;
      method = exception.method;
      details = exception.details;
    }
    _updateVals(stat, mess, method, details);
  }

  Future<void> _handleGetNameProperty() async {
    /// example using friendly name
    /// to use another property, change id and type
    /// to correspond to desired property CapturePropertyIds

    CaptureProperty property = CaptureProperty(
        CapturePropertyIds.friendlyNameDevice, CapturePropertyTypes.none, {});

    String stat = _status;
    String mess = _message;
    String? method;
    String? details;

    try {
      CaptureProperty propertyResponse =
          await _deviceCapture!.getProperty(property);
      /// propertyResponse.value
      stat = 'Get Property';
      mess =
          'Successfully Retrieved "name" property for device: ${propertyResponse.value}';
    } on CaptureException catch (exception) {
      stat = exception.code.toString();
      mess = exception.code == -32602 ? 'JSON parse error' : exception.message;
      method = exception.method;
      details = exception.details;
    }
    _updateVals(stat, mess, method, details);
  }

  Future<void> _handleSetNameProperty() async {
    CaptureProperty property = CaptureProperty(
        CapturePropertyIds.friendlyNameDevice,
        CapturePropertyTypes.string,
        _newName);

    String stat = _status;
    String mess = _message;
    String? method;
    String? details;

    try {
      CaptureProperty propertyResponse =
          await _deviceCapture!.setProperty(property);
      stat = 'Set Property';
      mess = 'Successfully set "name" property to "$_newName".';
      //can incorporate UI logic to update device in device list
    } on CaptureException catch (e) {
      stat = '${e.code}';
      mess = e.code == -32602 ? 'JSON parse error' : e.message;
      method = e.method;
      details = e.details;
    }

    setState(() {
      _newName = '';
    });

    _nameController.text = '';

    _updateVals(stat, mess, method, details);
  }

  void _handleNameChange() {
    setState(() {
      _newName = _nameController.text;
    });
  }

  Future _openDeviceHelper(Capture deviceCapture, CaptureEvent e, bool isManager) async {
    // deviceArrival checks that a device is available
    // openDevice allows the device to be used (for decodedData)
    List<DeviceInfo> arr = _devices;

    String guid = e.value.guid;
    String name = e.value.name;

    logger.log('Device ${isManager ? 'Manager' : ''} Arrival =>', name + ' ($guid)');

    try {
      dynamic res = await deviceCapture.openDevice(guid, _capture);
      // res is 0 if no error, if not zero there is error in catch
      if (res == 0 && !arr.contains(e.value)) {
        arr.add(e.value);
        setState(() {
          _devices = arr;
        });
      }
      _updateVals('Device ${isManager ? 'Manager' : ''} Opened', 'Successfully added "$name"');
    } on CaptureException catch (exception) {
      _updateVals(exception.code.toString(), exception.message,
          exception.method, exception.details);
    }
  }

  Future<void> _closeDeviceHelper(e, handle, bool isManager) async {
    String guid = e.value.guid;
    String name = e.value.name;
    logger.log('Device ${isManager ? 'Manager' : ''} Removal =>', name + ' ($guid)');
    try {
      dynamic res = await _deviceCapture!.close();
      if (res == 0) {
        List<DeviceInfo> arr = _devices;
        arr.removeWhere((element) => element.guid == guid);
        setState(() {
          _devices = arr;
          _currentScan = null;
          _deviceCapture = null;
        });
      }
      _updateVals('Device ${isManager ? 'Manager' : ''} Closed', 'Successfully removed "$name"');
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

        setState(() {
          _deviceCapture = deviceCapture;
        });

        _openDeviceHelper(deviceCapture, e, false);
        break;
      case CaptureEventIds.deviceRemoval:
        _closeDeviceHelper(e, handle, false);
        break;

      case CaptureEventIds.decodedData:
        setState(() {
          _currentScan = e;
        });
        _updateVals('Decoded Data', "Successful scan!");
        break;
      case CaptureEventIds.deviceManagerArrival:
        Capture deviceCapture = Capture(logger);

        setState(() {
          _deviceCapture = deviceCapture;
        });

        _openDeviceHelper(deviceCapture, e, true);
        break;
      case CaptureEventIds.deviceManagerRemoval:
        _closeDeviceHelper(e, handle, true);
        break;
    }
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
              Row(children: <Widget>[
                const Text(
                  'Status: ',
                ),
                Text(
                  _status,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ]),
              Row(children: <Widget>[
                const Text(
                  'Message: ',
                ),
                Flexible(
                  child: Text(
                    _message,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ]),
              Row(children: [
                Text(_deviceCapture != null
                    ? 'Get Friendly Name'
                    : 'Please connect device to get friendly name.'),
                IconButton(
                  icon: const Icon(Icons.add_box),
                  onPressed:
                      _deviceCapture != null ? _handleGetNameProperty : null,
                ),
              ]),
              Row(children: [
                SizedBox(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                      top: 20,
                      right: 40,
                      bottom: 20,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.add_box),
                          onPressed: _newName.isNotEmpty
                              ? _handleSetNameProperty
                              : null,
                        ),
                        labelText: 'Edit Device Name',
                        border: const OutlineInputBorder(),
                      ),
                      controller: _nameController,
                    ),
                  ),
                ),
              ]),
              Row(children: const <Widget>[
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
              Row(children: <Widget>[
                Flexible(
                  child: Text('Scanned Data: ',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
                Flexible(
                    child: Text(_currentScan != null
                        ? 'Scan from ${_currentScan!.value.name}: ' +
                            _currentScan!.value.data.toString()
                        : 'No Data'))
              ]),
            ],
          ),
        ));
  }
}
