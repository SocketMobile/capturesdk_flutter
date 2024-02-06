# Flutter CaptureSDK 1.4.44

This is the Flutter CatureSDK for Socket Mobile's Capture library. The accompanying package can be found on [pub.dev](https://pub.dev/packages/capturesdk_flutter).

# Devices compatibility and CaptureSDK versions

|                    Devices                     | <= 1.2 | 1.3 |   1.4   |
| :--------------------------------------------: | :----: | :-: | :-----: |
|               **SocketCam C860**               |   ❌   | ❌  | ✅ [^1] |
|               **SocketCam C820**               |   ❌   | ❌  |   ✅    |
|               **S720/D720/S820**               |   ❌   | ✅  |   ✅    |
| **D600, S550, and all other barcode scanners** |   ✅   | ✅  |   ✅    |
|                    **S370**                    |   ❌   | ❌  |   ✅    |

[^1]: _SocketCam C860 is currently supported on the latest version of Android only. More on SocketCam can be found [here](https://www.socketmobile.com/readers-accessories/product-families/socketcam)._

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

Uncomment out the second line and change the version from `'9.0'` to `'12.0'`.

Second, go to `ios/Runner/Info.plist` and at the bottom, just above `</dict>`, include the below code.

```dart
<key>NSBluetoothAlwaysUsageDescription</key>
  <string>Bluetooth is needed to connect to a Socket Mobile device</string>
  <key>UISupportedExternalAccessoryProtocols</key>
  <array>
    <string>com.socketmobile.chs</string>
  </array>
  <key>NSCameraUsageDescription</key>
		<string>Need to enable camera access for SocketCam products such as C820</string>
```

If you do not do this, you will encounter an error saying `This app has crashed because it attempted to access privacy-sensitive data without a usage description.  The app's Info.plist must contain an NSBluetoothAlwaysUsageDescription key with a string value explaining to the user how the app uses this data.`. This is a bluetooth security measure, and to permit bluetooth access you will need to add the above entry in your `Info.plist` file. The other item related to `NSCameraUsageDescription` is to permit camera access in order to use SocketCam C820.

Third, open the project's iOS directory in xcode. Once you've done that, select the Runner and navigate to the build settings. In the search bar, type in 'module' and then look for the portion that says "Allow Non-modular includes in Framework Modules". Once that property is location, select "Yes". See the image below for what it should look like.

![Build Settings](https://raw.githubusercontent.com/SocketMobile/capturesdk_flutter/main/runnerimg.png)

# Android

You will need to update the network configuration to enable the Android Capture client. You can find out more about network configuration [here](https://docs.socketmobile.com/capture/java/en/latest/android/getting-started.html).

In order to pass the internet permissions, you need to have the below line in your Android manifest.

```dart
<uses-permission android:name="android.permission.INTERNET" />
```

In order to use SocketCam C820, you will need to add the below to your Android manifest.

```
<activity android:name="com.facebook.react.devsupport.DevSettingsActivity" />
    <meta-data android:name="com.socketmobile.capture.APP_KEY" android:value="{YOUR_APP_KEY}"/>
    <meta-data android:name="com.socketmobile.capture.DEVELOPER_ID" android:value="{YOUR_DEVELOPER_ID}"/>
```

Where it says `YOUR_APP_KEY`, you need to include the android app key that you got for your app when you registered it. Where it says `YOUR_DEVELOPER_ID` is the developer ID you use for your socket mobile developer portal.

ALSO: The package name in `AndroidManifest.xml`, it needs to be both all lowercase and must match your Bundle ID that you have in your app's registration information in your dev portal.

```
<manifest xmlns:android="http://schemas.android.com/apk/res/android" package="com.yourpackagename">
```

## Enable Start Capture Service on Android

You might also have to add the file `network_security_config.xml` file to `android/app/src/main/res/xml` in order to avoid a `clearText` permissions error. See the code below for the file.

```
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <base-config cleartextTrafficPermitted="false" />
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="false">localhost</domain>
        <domain includeSubdomains="false">127.0.0.1</domain>
    </domain-config>
</network-security-config>
```

Then, in their app's `AndroidManifest.xml` file, the developer will need to add the below property into the `<application>` tag.

```
android:networkSecurityConfig="@xml/network_security_config"
```

Finally, add the below line into just before the `AndroidManifest.xml` file's closing `</manifest>` tag.

```
<queries>
    <package android:name="com.socketmobile.companion"/>
  </queries>
```

For more on the network security configuration for Android, please check out the cleartext section in [the Android docs](https://docs.socketmobile.com/capture/java/en/latest/android/getting-started.html#enable-cleartext-traffic).

## Installation

Install the flutter package using `flutter pub get capturesdk_flutter`. It will add the below line to your `pubspec.yaml` file.

```dart
dependencies:
  flutter:
    capturesdk_flutter: 1.4.44
```

In the `main.dart`, you can import the capture flutter sdk by adding this line to the top of your file.

```dart
import 'package:capturesdk_flutter/capturesdk.dart';
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

![iOS app registration](https://raw.githubusercontent.com/SocketMobile/capturesdk_flutter/main/readme.png)

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

## DEPRECATION NOTICE

- The previous package name, `capturesdk`, is now _deprecated_.
- The new package `capturesdk_flutter` is the _replacement_.
- _Please use `capturesdk_flutter` moving forward._
- Correct package can be found [here](https://pub.dev/packages/capturesdk_flutter).

## Environment Information

NOTE: My Xcode is in a different location than yours might be hence why it says I still need to install it. I have it installed and it runs fine just shows up as incomplete when I run `flutter doctor -v`.

[✓] Flutter (Channel master, 2.10.0-1.0.pre.655, on macOS 13.5.1 22G90 darwin-x64, locale en-US)
• Flutter version 2.10.0-1.0.pre.655 on channel master at /Users/mattc/Development/flutter
• Upstream repository https://github.com/flutter/flutter.git
• Framework revision 85d4b28065 (1 year, 6 months ago), 2022-02-23 19:49:14 +0300
• Engine revision ddaa87c114
• Dart version 3.0.0 (build 3.0.0-417.0.dev)
• DevTools version 2.23.1

[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.0)
• Android SDK at /Users/mattc/Library/Android/sdk
• Platform android-33, build-tools 33.0.0
• ANDROID_HOME = /Users/mattc/Library/Android/sdk
• ANDROID_SDK_ROOT = /Users/mattc/Library/Android/sdk
• Java binary at: /Applications/Android Studio.app/Contents/jbr/Contents/Home/bin/java
• Java version OpenJDK Runtime Environment (build 17.0.6+0-17.0.6b802.4-9586694)
• All Android licenses accepted.

[!] Xcode - develop for iOS and macOS
• Xcode Version 14.3
✗ Xcode installation is incomplete; a full installation is necessary for iOS and macOS development.
Download at: https://developer.apple.com/xcode/download/
Or install Xcode via the App Store.
Once installed, run:
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
• CocoaPods version 1.12.0

[✓] Chrome - develop for the web
• Chrome at /Applications/Google Chrome.app/Contents/MacOS/Google Chrome

[✓] Android Studio (version 2022.2)
• Android Studio at /Applications/Android Studio.app/Contents
• Flutter plugin can be installed from:
🔨 https://plugins.jetbrains.com/plugin/9212-flutter
• Dart plugin can be installed from:
🔨 https://plugins.jetbrains.com/plugin/6351-dart
• Java version OpenJDK Runtime Environment (build 17.0.6+0-17.0.6b802.4-9586694)

[✓] VS Code (version 1.81.1)
• VS Code at /Applications/Visual Studio Code 2.app/Contents
• Flutter extension version 3.70.0

[✓] Connected device (3 available)
• SM T290 (mobile) • R9WR508TAGJ • android-arm64 • Android 11 (API 30)
• macOS (desktop) • macos • darwin-x64 • macOS 13.5.1 22G90 darwin-x64
• Chrome (web) • chrome • web-javascript • Google Chrome 116.0.5845.110

[✓] Network resources
• All expected network resources are available.

## Run Instructions

1. Run `flutter pub get` in `example`.
2. Open `example/android` in Android Studio to run on connected Android Device.
3. Open `example/ios` in Xcode to run on connected iOS device.

If you run into any issues, here are a few things you can try to fix it.

### Both Platforms

1. In `example`, run `flutter clean` from the command line.
2. Then run `flutter pub get`.

### Android

1. In Android Studio, go to the top of the window and click on `Build > Clean Project`. Then click the Run button.
2. If that doesn't work, try deleting `example/android/.gradle`.
3. In Android Studio, click on the elephant icon that is to the right of the Run and Debug buttons. This button is used for Gradle Sync and should sync up your gradle project.

### iOS

1. In Xcode, go to the top of the window and click on `Product > Clean Build Folder`. Then click the Run button.
2. If that doesn't work, try deleting `example/ios/Pods` and `Podfile.lock`.
3. In your terminal, run `pod install`. Then go to Xcode and try to run again.
4. If those don't work, you can try using `pod deintegrate`, and then `pod install` again before re-running in Xcode.
