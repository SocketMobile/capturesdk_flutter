// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:capturesdk_flutter/capturesdk.dart';

class MainView extends StatefulWidget {
  final Capture? deviceCapture;
  final Function setStatus;

  const MainView(
      {Key? key, required this.deviceCapture, required this.setStatus})
      : super(key: key);

  // Add any required constructor parameters if needed
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  String _newName = "";
  String _batteryLevel = "0%";
  final _nameController = TextEditingController();

  Future<void> _getFriendlyName() async {
    CaptureProperty property = const CaptureProperty(
        id: CapturePropertyIds.friendlyNameDevice,
        type: CapturePropertyTypes.none,
        value: {});

    try {
      CaptureProperty propertyResponse =
          await widget.deviceCapture!.getProperty(property);
      widget.setStatus(
          "successfully retrieved friendly name: ${propertyResponse.value}");
    } on CaptureException catch (exception) {
      String code = exception.code.toString();
      String message = exception.message;
      widget.setStatus("failed to get friendly name: $code: $message");
    }
  }

  Future<void> _getBatteryLevel() async {
    CaptureProperty property = const CaptureProperty(
        id: CapturePropertyIds.batteryLevelDevice,
        type: CapturePropertyTypes.none,
        value: {});

    try {
      CaptureProperty propertyResponse =
          await widget.deviceCapture!.getProperty(property);
      dynamic val = _handleBatteryConversion(propertyResponse);
      widget.setStatus("successfully retrieved friendly name: $val");
      setState(() {
        _batteryLevel = val;
      });
    } on CaptureException catch (exception) {
      String code = exception.code.toString();
      String message = exception.message;
      widget.setStatus("failed to get battery level: $code: $message");
    }
  }

  String _handleBatteryConversion(dynamic data) {
    int x = (data.value & 0xff00) >> 8;
    return "$x%";
  }

  Future<void> _handleSetNameProperty() async {
    CaptureProperty property = CaptureProperty(
        id: CapturePropertyIds.friendlyNameDevice,
        type: CapturePropertyTypes.string,
        value: _newName);

    try {
      await widget.deviceCapture!.setProperty(property);
      widget.setStatus("Successfully set 'name' property to $_newName");
    } on CaptureException catch (exception) {
      String code = exception.code.toString();
      String message = exception.message;
      widget.setStatus("failed to get battery level: $code: $message");
    }

    setState(() {
      _newName = '';
    });

    _nameController.text = '';
  }

  void _handleNameChange(val) {
    setState(() {
      _newName = val;
    });
  }

  // Implement the UI and widget tree
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(children: [
          Text(widget.deviceCapture != null
              ? 'Get Friendly Name: '
              : 'Please connect device to get friendly name.'),
          IconButton(
            icon: const Icon(Icons.add_box),
            onPressed: widget.deviceCapture != null ? _getFriendlyName : null,
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
                    onPressed:
                        _newName.isNotEmpty ? _handleSetNameProperty : null,
                  ),
                  labelText: 'Edit Device Name',
                  border: const OutlineInputBorder(),
                ),
                controller: _nameController,
                onChanged: (value) => _handleNameChange(value),
              ),
            ),
          ),
        ]),
        Row(children: <Widget>[
          Flexible(
            child: Text('Get Battery Level',
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          IconButton(
            icon: const Icon(Icons.add_box),
            onPressed: widget.deviceCapture != null ? _getBatteryLevel : null,
          ),
          Flexible(
            child: Text(_batteryLevel,
                style: Theme.of(context).textTheme.bodyLarge),
          ),
        ]),
      ]),
    );
  }
}
