# Capture SDK Flutter

This is the Flutter SDK for Socket Mobile's Capture library. 

## Getting Started

Install the flutter package using `flutter pub get socket_flutter_sdk`. It will add the below line to your pubspec.yml file.

```
dependencies:
  flutter:
    capture_flutter_beta: ^1.0.0
```

In the `main.dart`, you can import the capture flutter sdk by adding this line to the top of your file. 

```
import 'package:capture_flutter_beta/capture_flutter_beta.dart';
```

Create a `Capture` instance with the line `Capture capture = Capture(logger);`. `logger` is an optional argument that is passed to `Capture` and can be helpful with tracing values and requests throughout the app, particularly in `Capture` and `HttpTransport` where the bulk of the Capture logic and requests are handled. 

Open the connection wth the Capture library by using the `open` method on the `Capture` instance. See below.

```
capture.open(appInfo, _onCaptureEvent)
    .then((result){
        //access result here
    })
```

`appInfo` is an instance of the `AppInfo` class and consists of the same parameters found in other Capture SDKs. See an example of `appInfo` below.

```
final appInfo = AppInfo(
    'web:com.socketmobile.reactjs.native.example.example',
    'bb57d8e1-f911-47ba-b510-693be162686a',
    'MC0CFQC85w0MsxDng4wHBICX7+iCOiSqfAIUdSerA4/MJ2kYBGAGgIG/YHemNr8='
);
```

To generate app info, head to the [docs](https://www.socketmobile.com/developers/portal/application-details/appkey-registration) and follow the prompts to register your app and generate your `appInfo` credentials.

`_onCaptureEvent` is the callback passed to `open` that can handle the event notifications from the Capture SDK. Below are three important events to consider, which are accessible in the `CaptureEventIds` class. 

`deviceArrival` is the event that is triggered when the scanner connects to your device. 

`deviceRemoval` is the event that is triggered when the scanner is disconnected from the device.

`decodedData` is the event that is triggered when you scan something with the connected scanner.

See an example of event handling below in `_onCaptureEvent`.

```
switch (e['id']) {
      case CaptureEventIds.deviceArrival:
        {
          var newCapture = Capture(logger);

          setState(() {
            _newCapture = newCapture;
          });

          var arr = _devices;

          if (!arr.contains(e['value'])){
            arr.add(e['value']);
            setState(() {
              _devices = arr;
            });
          } 
          
          var guid = e['value']['guid'];
          var name = e['value']['name'];
          logger.log('Device Arrival =>', name + ' ($guid)');
         
          newCapture.openDevice(guid, _capture).then((res){
            if (res.runtimeType != int){
              _updateVals("${res['error']['code']}", res['error']['message'] );
            } else {
              _handleGetNameProperty();
              _updateVals('Device Arrival', 'Successfully added "$name"');
            }
          });

        }
        break;

      case CaptureEventIds.deviceRemoval:
        {
          var guid = e['value']['guid'];
          var name = e['value']['name'];
          var arr = _devices;
          arr.removeWhere((element) => element['guid'] == guid);
          setState(() {
            _devices = arr;
            _currentScan = null;
          });
          logger.log('Device Removal =>', name + ' ($guid)');
          _updateVals('Device Closed', 'Successfully removed "$name"');
        }
        break;

      case CaptureEventIds.decodedData:
        {
          setState(() {
            _currentScan = json.encode(e);
          });
          _updateVals('Scanned Data', "See 'Current Scan' for data." );
        }
        break;
    }
}
```

The data comes in as json and needs to be access used brackets and keys like so: `response['key']`.

It's important to create another `Capture` instance when you have successfully connected the scanner to your device (see `var newCapture = Capture(logger);`). This capture instance is tied to your device and will allow the root capture instance to remain open, regardless of what happens with your device. The new instance allows you to create a capture connection to the device to handle various actions specific to the connected device, such as `getProperty` and `setProperty`. 

`getProperty` enables you to retrieve specific values for the connected device, such as `friendlyNameDevice` which is the property corresponding to the scanners given name (as opposed to id/guid). Create a property instance with the provided values corresponding to the property id and type, as well an empty object. You can retrieve the friendly name of a device with the following request. 

```
void _handleGetNameProperty(){
   
    var property = CaptureProperty(
        CapturePropertyIds().friendlyNameDevice, 
        CapturePropertyTypes().none,
        {}
    );

    _newCapture.getProperty(property).then((response){
        if (response['error'] != null){
            print(response['error']['code']);
        } else {
            print('response['value']);
        }
    });
}
```

`setProperty` allows you to update the value of a specific property. The `CaptureProperty` instance you provide is similar to the one in `getProperty` but instead of an empty object for the value, you will send the value you want assigned to the property. You will also send the data type for the property as well instead of `CapturePropertyTypes().none`. In the case of `friendlyNameDevice`, you would send a string value with the type `CapturePropertyTypes().string`. See below.

```
void _handleSetNameProperty(){

    var property = CaptureProperty(
        CapturePropertyIds().friendlyNameDevice, 
        CapturePropertyTypes().string, 
        _newName
    );

    _newCapture.setProperty(property).then((res){
       
        if (res['error'] != null){
            print(response['error']['code']);
        } else {
            print('successfully updated device friendly name!')
        }
        
    });
}
```

The response in `setProperty` does not contain a `value` property. You can access the updated value by calling the `getProperty` request after a successful `setProperty` call or you can use the locally stored value that you're using for assignment. 