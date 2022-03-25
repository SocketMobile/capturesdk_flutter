.. |br| raw:: html

   <br />

Getting Started with Flutter Capture SDK
=============================================

Requirements
------------
The Socket Mobile Capture SDK uses Bluetooth Classic for the barcode scanner products and Bluetooth Low Energy (BLE) for the Contactless Reader/Writer products (Socket Mobile D600, S550).

Even though the Flutter Capture SDK allows to develop an app to run on iOS and Android the underlying Capture architecture on these 2 platforms is different.

On Android there is a service embedded in the Socket Mobile Companion app that is required in order to connect the Socket Mobile device to the Android host.

On iOS the communication with the Socket Mobile devices are embedded in Flutter pigeon middleware, therefore adding more configuration to be taken care of in the application itself.

**Requirements for iOS platform**

For applications that need to work with barcode scanners, make sure the following requirements are met:

#.	Your iOS application needs to be registered in our Apple MFI Approved Application list before submitting your application to the Apple Store. It will not pass the Apple Store review if this is not done.

#.	Your application must have the string ``com.socketmobile.chs`` in the Supported External Protocol setting. |br|
	|ExternalAccessory|

  .. |ExternalAccessory| image:: images/ExternalAccessoryInfo.png


#.  Your application must add some security descriptions for the Bluetooth permissions as shown here. |br|
    |BluetoothPrivacy|

  .. |BluetoothPrivacy| image:: images/Bluetooth-Privacy-Strings.png


**Requirements for both iOS and Android platforms**

#.	**Your application will need a SocketMobile AppKey.** Follow the link to `create an AppKey <https://www.socketmobile.com/appkey>`_. AppKeys can be generated online and at no additional cost beyond the nominal one time registration fee.  The AppKey is validated by the SDK library on the device, no internet connection is required. Note: You don’t need to create your own AppKey to compile and run the sample apps.


#.	**The scanner needs to be paired with your devices in Application Mode.** This can be done using Socket Mobile Companion app which can be downloaded from the `App Store <https://itunes.apple.com/us/app/socket-mobile-companion/id1175638950>`_ .

#.  Try our Flutter sample app: `Flutter Capture SDK <https://github.com/SocketMobile/capture_flutter_sdk_sample>`_.



SDK Installation
----------------
The Flutter Capture SDK is released as a pub.dev package.

**Adding to pubspec.yaml**

.. code-block::

  dependencies:
    flutter:
      sdk: flutter
      capture_flutter_sdk: ^1.1.9

  Then run flutter pub get

**Using pub get**

.. code-block::

    flutter pub add capture_flutter_sdk
    

Using Capture SDK
-----------------
First, once the NPM package has been installed CaptureSDK can be imported as shown below:

.. code-block:: javascript

  import 'package:capturesdk/capturesdk.dart';


Here are the usual steps to follow:

#. Open Capture with the App credentials and provide event handler function
#. Handle device arrival and open the device in the event handler function
#. Handle device removal and close the device in the event handler function
#. Handle decoded data in the event handler function

**Opening Capture with App credentials**

The Flutter SDK is an extension of the Capture SDK

.. code-block:: javascript

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

      try {
        int? response = await capture.openClient(appInfo, _onCaptureEvent);
        print('capture open successful.')
      } on CaptureException catch (exception) {
        print('capture open failed: ' exception.code.toString();)
      }

**Handle device arrival and open the device**

When the application receives a **Device Arrival** notification, it can create a new **Capture** instance that represents the new device.

The application opens the device by passing **GUID** and the main **Capture** reference as arguments of the device open function.

Opening the device allows to receive the decoded data from this device.

.. note:: the device **GUID** changes everytime the device connects. It identifies a connection session with a device.

.. note:: If a Socket Mobile device is already connected to the host prior to the app opening Capture SDK, the device arrival notificaiton will still be sent to make the application aware that the device is connected.

.. note:: The second argument of the **_onCaptureEvent**, handle, is optional. It could be used to identify which Capture object is the source of the notification.

In the **_onCaptureEvent** callback passed when opening Capture you could have code similar to this handling the device arrival notification:

.. code-block:: javascript

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

          _openDeviceHelper(deviceCapture, e);
          break;
        case CaptureEventIds.deviceRemoval:
          _closeDeviceHelper(e, handle);
          break;

        case CaptureEventIds.decodedData:
          setState(() {
            //storing scanned data in state for future use
            _currentScan = e;
          });
          _updateVals('Decoded Data', "Successful scan!");
          break;
      }
    }

**Handle device removal and close the device**

The device removal occurs when the Socket Mobile device is no longer connected to the host. It is recommended to close it.

In the **_onCaptureEvent** callback passed when opening Capture you could have code that executes a helper (seen above) to close the device:

.. code-block:: javascript

    Future<void> _closeDeviceHelper(e, handle) async {
      String guid = e.value.guid;
      String name = e.value.name;
      logger.log('Device Removal =>', name + ' ($guid)');
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
        _updateVals('Device Closed', 'Successfully removed "$name"');
      } on CaptureException catch (exception) {
        _updateVals('${exception.code}', 'Unable to remove "$name"',
            exception.method, exception.details);
      }
    }

**Handle decoded data in the event handler function**

Each time a Socket Mobile device is successful at reading a barcode or an NFC tag, the decoded data notification is sent and can be handled as shown here:

.. note:: 
    Capture does not interpret the decoded data, only the application knows how to interpret it. For demonstration purpose the decoded data can be displayed with the help of a function like this:
    
    .. code-block:: javascript 

      // **********************************
      // Decoded Data
      //   receive the decoded data from
      //   a specific device
      //  e = {
      //    id: CaptureEventIds.DecodedData,
      //    type: CaptureEventTypes.DecodedData,
      //    value: {
      //      data: [55, 97, 100, 57, 53, 100, 97, 98, 48, 102, 102, 99, 52, 53, 57, 48, 97, 52, 57, 54, 49, 97, 51, 49, 57, 50, 99, 49, 102, 51, 53, 55],
      //      id: CaptureDataSourceID.SymbologyQRCode,
      //      name: "QR Code"
      //    }
      //  }
      // **********************************
        case CaptureEventIds.decodedData:
          setState(() {
            //storing scanned data in state for future use
            _currentScan = e;
          });
          _updateVals('Decoded Data', "Successful scan!");
          break;

      // In the Widget build(...)
      Text(_currentScan != null
                        ? 'Scan from ${_currentScan!.value.name}: ' +
                            _currentScan!.value.data.toString()
                        : 'No Data')) 

