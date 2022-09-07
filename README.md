# Flutter CaptureSDK
This is the Flutter CatureSDK for Socket Mobile's Capture library. 

## Getting Started
Before installing the package, you will need to adjust a few properties in your Flutter app.

# Flutter
As of now the only platforms that are supported are Android and iOS. Since we have a Capture web SDK it wasn't as much of a priority for the initial release but will be addressed later in a future release.

# iOS
You will need to change three things in your app in order for it to work with iOS. First will need to update the podfile in the `ios` directory of your app in order to be compatible with the version used in our SDK. 
```
project_root/ios/Podfile
# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'
```

Uncomment out the second line and change the version from `'9.0'` to `'10.1'`.

Second, go to `ios/Runner/Info.plist` and at the bottom, just above `</dict>`, include the below code.

```dart
<key>NSBluetoothAlwaysUsageDescription</key>
  <string>Bluetooth is needed to connect to a Socket Mobile device</string>
  <key>UISupportedExternalAccessoryProtocols</key>
  <array>
    <string>com.socketmobile.chs</string>
  </array>
```

If you do not do this, you will encounter an error saying `This app has crashed because it attempted to access privacy-sensitive data without a usage description.  The app's Info.plist must contain an NSBluetoothAlwaysUsageDescription key with a string value explaining to the user how the app uses this data.`. This is a bluetooth security measure, and to permit bluetooth access you will need to add the above entry in your `Info.plist` file. 

Third, open the project's iOS directory in xcode. Once you've done that, select the Runner and navigate to the build settings. In the search bar, type in 'module' and then look for the portion that says "Allow Non-modular includes in Framework Modules". Once that property is location, select "Yes". See the image below for what it should look like.

![Build Settings](https://raw.githubusercontent.com/SocketMobile/capturesdk_flutter_snapshot/main/runnerimg.png)

# Android
You will need to update the network configuration to enable the Android Capture client. You can find out more about network configuration [here](https://docs.socketmobile.com/capture/java/en/latest/android/getting-started.html).

In order to pass the internet permissions, you need to have the below line in your Android manifest. 

```dart
<uses-permission android:name="android.permission.INTERNET" />
```

## Installation
 
Install the flutter package using `flutter pub get capturesdk`. It will add the below line to your `pubspec.yaml` file.

```dart
dependencies:
  flutter:
    capturesdk: 1.3.0   
```

In the `main.dart`, you can import the capture flutter sdk by adding this line to the top of your file. 

```dart
import 'package:capturesdk/capturesdk.dart';
```

Create a `Capture` instance with the line `Capture capture = Capture(logger);`. `logger` is an optional argument that is passed to `Capture` and can be helpful with tracing values and requests throughout the app, particularly in `Capture` and `HttpTransport` where the bulk of the Capture logic and requests are handled. 

Open the connection wth the Capture library by using the `open` method on the `Capture` instance. See below.

```dart
int? response = await capture.openClient(appInfo, _onCaptureEvent);
stat = 'handle: $response';
mess = 'capture open success';
```

`appInfo` is an instance of the `AppInfo` class and consists of the same parameters found in other Capture SDKs. See an example of `appInfo` below.

```dart
final appInfo = AppInfo(
        'android:com.example.example',
        'MC4CFQDNCtjazxILEh8oyT6w/wlaVKqS1gIVAKTz2W6TB9EgmjS1buy0A+3j7nX4',
        'ios:com.example.example',
        'MC0CFA1nzK67TLNmSw/QKFUIiedulUUcAhUAzT6EOvRwiZT+h4qyjEZo9oc0ONM=',
        'bb57d8e1-f911-47ba-b510-693be162686a');
```

To generate app info, head to the [docs](https://www.socketmobile.com/developers/portal/application-details/appkey-registration) and follow the prompts to register your app and generate your `appInfo` credentials. See the important section at the end of the README for more information specific to Flutter.

Next, `_onCaptureEvent` is the callback passed to `open` that can handle the event notifications from the Capture SDK. Below are three important events to consider, which are accessible in the `CaptureEventIds` class. 

`deviceArrival` is the event that is triggered when the scanner connects to your device. 

`deviceRemoval` is the event that is triggered when the scanner is disconnected from the device.

`decodedData` is the event that is triggered when you scan something with the connected scanner.

See an example of event handling below in `_onCaptureEvent`.

```dart
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
          /// storing scanned data in state for future use
          _currentScan = e;
        });
        _updateVals('Decoded Data', "Successful scan!");
        break;
    }
  }
```

The data the user will need to anticipate will be a `CaptureEvent` which might contain an instance of `DecodedData`, `CaptureException`, a client or device handle, etc. When you first connect to the service, the response will be a client handle (an integer) or a `CaptureException` instance will be thrown.

It's important to create another `Capture` instance when you have successfully connected the scanner to your device (see `var newCapture = Capture(logger);`). This capture instance is tied to your device and will allow the root capture instance to remain open, regardless of what happens with your device. The new instance allows you to create a capture connection to the device to handle various actions specific to the connected device, such as `getProperty` and `setProperty`. 

`getProperty` enables you to retrieve specific values for the connected device, such as `friendlyNameDevice` which is the property corresponding to the scanners given name (as opposed to id/guid). Create a property instance with the provided values corresponding to the property id and type, as well an empty object. You can retrieve the friendly name of a device with the following request. 

```dart
Future<void> _handleGetNameProperty() async {
    CaptureProperty property = CaptureProperty(
        CapturePropertyIds.friendlyNameDevice,
        CapturePropertyTypes.none,
        {});

    try {
      CaptureProperty propertyResponse =
          await _deviceCapture!.getProperty(property);
     print('Successfully Retrieved "name" property for device: ${propertyResponse.value}';);
      //can incorporate UI logic to update device in device list
    } on CaptureException catch (e) {
     print(e.code);
    }
  }
```

`setProperty` allows you to update the value of a specific property. The `CaptureProperty` instance you provide is similar to the one in `getProperty` but instead of an empty object for the value, you will send the value you want assigned to the property. You will also send the data type for the property as well instead of `CapturePropertyTypes().none`. In the case of `friendlyNameDevice`, you would send a string value with the type `CapturePropertyTypes().string`. See below.

```dart
Future<void> _handleSetNameProperty() async {
    CaptureProperty property = CaptureProperty(
        CapturePropertyIds.friendlyNameDevice,
        CapturePropertyTypes.string,
        _newName);

    try {
      CaptureProperty propertyResponse =
          await _deviceCapture!.setProperty(property);
     print('Successfully set "name" property to "$_newName".');
      //can incorporate UI logic to update device in device list
    } on CaptureException catch (e) {
     print(e.code);
    }
  }
```

The response in `setProperty` does not contain a `value` property. You can access the updated value by calling the `getProperty` request after a successful `setProperty` call or you can use the locally stored value that you're using for assignment. 

## Important
To register your app for Flutter, you can select the Flutter language first, and then you can pick one of two platform options; Android and iOS. Below is an example of credentials generated during iOS registration.

![iOS app registration](https://raw.githubusercontent.com/SocketMobile/capturesdk_flutter_snapshot/main/readme.png)

If you want to add support for both platforms you will need to generate an app key for one platform first and then the other separately. Once these two keys are generated, all you need to do is inlcude the iOS and Android appKey and appId, respectively, to the same `AppInfo` instance.

```dart
final appInfo = AppInfo(
        'android:com.example.example',
        'MC4CFQDNCtjazxILEh8oyT6w/wlaVKqS1gIVAKTz2W6TB9EgmjS1buy0A+3j7nX4',
        'ios:com.example.example',
        'MC0CFA1nzK67TLNmSw/QKFUIiedulUUcAhUAzT6EOvRwiZT+h4qyjEZo9oc0ONM=',
        'bb57d8e1-f911-47ba-b510-693be162686a');
```

In order for it to work, you will need to add five argments to `AppInfo` in the following order:

  1. Android appId
  2. AppKey after Android registration
  3. iOS appId
  4. AppKey after iOS registration
  5. Developer ID

  For more information about the Flutter CaptureSDK, please visit the [documentation](https://docs.socketmobile.com/captureflutter/en/latest).

  For a full demonstration, check out [this video](https://vimeo.com/694611104).