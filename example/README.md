# Flutter CaptureSDK - Example App

This example application demonstrates how to integrate the [Socket Mobile CaptureSDK](https://pub.dev/packages/capturesdk_flutter) into a Flutter app using the `CaptureHelper` high-level API. It covers the full integration flow: SDK initialization, Bluetooth LE device discovery, barcode scanning with physical scanners, and camera-based scanning with SocketCam.

## Prerequisites

- A [Socket Mobile developer account](https://www.socketmobile.com/developers/portal) with registered app credentials
- For physical scanners: a Socket Mobile scanner (S720, D720, S820, S721, etc.)
- For SocketCam: no extra hardware — uses the device's built-in camera

> See the [main README](../README.md) for platform-specific setup (Podfile, Info.plist, AndroidManifest, network config).

## Quick Start

### 1. Register your app credentials

Generate your `AppInfo` from the [developer portal](https://www.socketmobile.dev/application-details/appkey-registration). You need separate keys for iOS and Android:

```dart
const AppInfo appInfo = AppInfo(
  appIdAndroid: 'android:com.example.myapp',
  appKeyAndroid: 'MC4CFQ...your_android_key...',
  appIdIos: 'ios:com.example.myapp',
  appKeyIos: 'MC0CFA...your_ios_key...',
  developerId: 'your-developer-id',
);
```

### 2. Initialize the SDK with CaptureHelper

`CaptureHelper` manages device handles, event routing, and Bluetooth LE lifecycle automatically. On Android, the Capture service must be started before opening the helper:

```dart
final CaptureHelper helper = CaptureHelper();

@override
void initState() {
  super.initState();
  if (Platform.isAndroid) {
    CapturePlugin.startCaptureService().then((_) => _openHelper());
  } else {
    _openHelper();
  }
}

Future<void> _openHelper() async {
  try {
    await helper.open(
      appInfo,
      onDeviceArrival: (CaptureHelperDevice device) {
        // A scanner connected — update your UI
      },
      onDeviceRemoval: (CaptureHelperDevice device) {
        // A scanner disconnected
      },
      onDecodedData: (DecodedData data, CaptureHelperDevice device) {
        // Barcode scanned — data.name is the symbology, data.data is the payload
      },
      onError: (CaptureException e) {
        // SDK error
      },
    );
  } on CaptureException catch (e) {
    debugPrint('Open failed: ${e.code} ${e.message}');
  }
}

@override
void dispose() {
  helper.close();
  super.dispose();
}
```

### 3. Access connected devices

```dart
List<CaptureHelperDevice> devices = helper.getDevices();

for (final device in devices) {
  final name = await device.getFriendlyName();
  final battery = await device.getBatteryLevel();
}
```

## Bluetooth LE Discovery (S721 and other Bluetooth LE scanners)

The S721 and other Bluetooth Low Energy scanners require an explicit discovery + connect flow, unlike classic Bluetooth scanners that pair at the OS level.

### Discovery flow

```text
addBluetoothDevice(mode: Bluetooth LE)
        │
        ▼
  SDK scans for nearby Bluetooth LE devices
        │
        ├──▶ onDiscoveredDevice(DiscoveredDeviceInfo)  ← called for each device found
        │
        ▼
  onDiscoveryEnd(result)  ← scan complete
        │
        ▼
connectDiscoveredDevice(device)
        │
        ▼
  onDeviceArrival(CaptureHelperDevice)  ← device is now connected and ready
```

### Register Bluetooth LE callbacks

Add the `onDiscoveredDevice` and `onDiscoveryEnd` callbacks when opening the helper:

```dart
await helper.open(
  appInfo,
  onDeviceArrival: (device) { /* ... */ },
  onDecodedData: (data, device) { /* ... */ },
  onDiscoveredDevice: (DiscoveredDeviceInfo info) {
    // A Bluetooth LE device was found during discovery
    // info.name — device name (e.g. "S721-XXXX")
    // info.identifierUuid — unique Bluetooth LE identifier
  },
  onDiscoveryEnd: (int result) {
    // Bluetooth LE scan finished
  },
);
```

### Start Bluetooth LE discovery

```dart
// Start scanning for Bluetooth LE devices
await helper.addBluetoothDevice(mode: BluetoothDiscoveryMode.bluetoothLowEnergy);

// Or for classic Bluetooth devices
await helper.addBluetoothDevice(mode: BluetoothDiscoveryMode.bluetoothClassic);
```

### Connect to a discovered device

When the user selects a discovered device from your UI:

```dart
await helper.connectDiscoveredDevice(device: discoveredDeviceInfo);
// Wait for onDeviceArrival callback — the device is then in helper.getDevices()
```

### Disconnect / remove a Bluetooth LE device

```dart
// Disconnect a specific discovered device
await helper.disconnectFromDiscoveredDevice(device: discoveredDeviceInfo);

// Remove a connected Bluetooth LE device
await helper.removeBleDevice(device: connectedDevice);
```

## SocketCam (camera-based scanning)

SocketCam turns the device's built-in camera into a barcode scanner. Two variants are available:

- **C820** — basic camera scanning
- **C860** — enhanced scanning (requires [Socket Mobile Companion](https://apps.apple.com/app/socket-mobile-companion/id1175638950) on iOS)

### Enable SocketCam

SocketCam devices appear automatically in `onDeviceArrival` once enabled:

```dart
await helper.setSocketCamEnabled(enabled: SocketCam.enable);
```

On iOS, SocketCam is enabled by default so the device arrival is automatic.

### Full-screen mode (default)

The simplest integration. The SDK handles the entire camera UI:

```dart
final socketCam = helper.getSocketCamDevice();
if (socketCam != null) {
  await socketCam.setTrigger(Trigger.start);
  if (Platform.isIOS) {
    await SocketCamView.presentFullScreen();
  }
  // On Android, the SDK opens its own camera Activity automatically
}
```

The scanned barcode arrives in the `onDecodedData` callback.

### Custom view mode

Embed the camera preview inside your own Flutter layout using the `SocketCamView` widget:

```dart
// In your widget tree (minimum 400x400 pixels recommended). Here the example app shows a SocketCam in the right bottom part of the screen
Positioned(
  right: 16,
  bottom: 16,
  width: MediaQuery.of(context).size.width * 0.6,
  height: MediaQuery.of(context).size.height / 2,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: SocketCamView(device: socketCamDevice),
  ),
)
```

Then trigger the scan:

```dart
await socketCamDevice.setTrigger(Trigger.start);
```

**Platform differences:**

| | iOS | Android |
| --- | --- | --- |
| Full-screen | Works out of the box | Works out of the box |
| Custom view | Works out of the box | Requires native changes (see below) |
| Runtime switching | Yes | No (locked at first `build()`) |

**Android custom view setup:** In `android/.../CaptureModule.java`, uncomment the `CustomViewListener` code in `buildAndStartExtension()`. The `CaptureExtension` is a singleton — the first `build()` call locks the mode for the process lifetime.

## Example App Structure

```text
example/lib/
├── main.dart                          # AppInfo credentials, app entry point
├── screens/
│   ├── home_screen.dart               # SDK init, device list, Bluetooth LE discovery
│   ├── features_screen.dart           # Device feature menu
│   ├── trigger_screen.dart            # Trigger + SocketCam (both modes)
│   ├── friendly_name_screen.dart      # Get/set device name
│   ├── symbologies_screen.dart        # Enable/disable barcode symbologies
│   ├── battery_screen.dart            # Battery level
│   ├── power_timers_screen.dart       # Auto power-off timers
│   └── firmware_screen.dart           # Firmware version
└── widgets/
    ├── decoded_data_header.dart        # Scan results display
    └── device_list_item.dart           # Device row in list
```

## Build & Run

```bash
cd example
flutter pub get
```

### iOS

```bash
cd ios && pod install --repo-update && cd ..
flutter run
```

### Android

```bash
flutter run
```

Or open the project in Android Studio / VS Code and use the debugger.
