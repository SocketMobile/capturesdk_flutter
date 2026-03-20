import 'dart:io';

import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/decoded_data_header.dart';
import '../widgets/device_list_item.dart';
import 'features_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CaptureHelper _helper = CaptureHelper();
  List<CaptureHelperDevice> _devices = <CaptureHelperDevice>[];
  List<DecodedData> _scans = <DecodedData>[];
  List<DiscoveredDeviceInfo> _discoveredDevices = <DiscoveredDeviceInfo>[];
  String? _statusMessage;
  final GlobalKey<NavigatorState> _innerNavKey = GlobalKey<NavigatorState>();
  final ValueNotifier<int> _decodedDataNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      CapturePlugin.startCaptureService().then((_) async {
        await _openHelper();
        // Here you can enable SocketCam camera scanning by default if desired. If you want to leave it disabled by default, you can remove the following line.
        // _helper.setSocketCamEnabled(enabled: SocketCam.enable);
      });
    } else {
      _openHelper();
    }
  }

  Future<void> _openHelper() async {
    try {
      await _helper.open(
        appInfo,
        onDeviceArrival: (CaptureHelperDevice device) {
          setState(() {
            _devices = _helper.getDevices();
            _discoveredDevices = _discoveredDevices
                .where((DiscoveredDeviceInfo d) => d.identifierUuid != device.guid)
                .toList();
          });
        },
        onDeviceRemoval: (CaptureHelperDevice device) {
          setState(() {
            _devices = _helper.getDevices();
          });
        },
        onDecodedData: (DecodedData data, CaptureHelperDevice device) {
          setState(() => _scans = <DecodedData>[..._scans, data]);
          _decodedDataNotifier.value++;
        },
        onError: (CaptureException e) {
          setState(() => _statusMessage = 'Error: ${e.code} ${e.message}');
        },
        onBatteryLevel: (int level, CaptureHelperDevice device) {
          final int percent = (level >> 8) & 0xFF;
          setState(() => _statusMessage = '${device.name} battery: $percent%');
        },
        onPowerState: (int state, CaptureHelperDevice device) {
          setState(() => _statusMessage = '${device.name} power state: $state');
        },
        onButtons: (int state, CaptureHelperDevice device) {
          setState(() => _statusMessage = '${device.name} buttons: $state');
        },
        onDiscoveredDevice: (DiscoveredDeviceInfo info) {
          setState(() {
            _discoveredDevices = <DiscoveredDeviceInfo>[..._discoveredDevices, info];
          });
        },
        onDiscoveryEnd: (int result) {
          setState(() => _statusMessage = 'Discovery ended: $result');
        },
        onSocketCamCanceled: (CaptureHelperDevice device) {
          setState(() => _statusMessage = 'SocketCam canceled');
          _decodedDataNotifier.value++;
        },
        onLogTrace: (String trace) {
          debugPrint('SDK trace: $trace');
        },
      );
    } on CaptureException catch (e) {
      setState(() => _statusMessage = 'Open failed: ${e.code} ${e.message}');
    }
  }

  @override
  void dispose() {
    _decodedDataNotifier.dispose();
    _helper.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SafeArea(
            bottom: false,
            child: DecodedDataHeader(scans: _scans),
          ),
          Expanded(
            child: PopScope(
              canPop: false,
              onPopInvokedWithResult: (bool didPop, Object? _) {
                if (!didPop) {
                  _innerNavKey.currentState?.maybePop();
                }
              },
              child: Navigator(
                key: _innerNavKey,
                onGenerateRoute: _onGenerateRoute,
              ),
            ),
          ),
          if (_statusMessage != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: 8,
                right: 8,
                top: 8,
                bottom: MediaQuery.of(context).padding.bottom + 8,
              ),
              child: Text(
                _statusMessage!,
                style: const TextStyle(color: Colors.amber),
              ),
            ),
        ],
      ),
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'features':
        final CaptureHelperDevice device =
            settings.arguments! as CaptureHelperDevice;
        return MaterialPageRoute<void>(
          builder: (_) => FeaturesScreen(
            device: device,
            decodedDataNotifier: _decodedDataNotifier,
            helper: _helper,
          ),
        );
      default:
        return MaterialPageRoute<void>(builder: (_) => _buildMainPage());
    }
  }

  Widget _buildMainPage() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0A84FF),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 48),
          ),
          onPressed: () {
            setState(() => _discoveredDevices = <DiscoveredDeviceInfo>[]);
            _helper.addBluetoothDevice(mode: BluetoothDiscoveryMode.bluetoothLowEnergy);
          },
          child: const Text('Add BLE Device'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0A84FF),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 48),
          ),
          onPressed: () {
            setState(() => _discoveredDevices = <DiscoveredDeviceInfo>[]);
            _helper.addBluetoothDevice(mode: BluetoothDiscoveryMode.bluetoothClassic);
          },
          child: const Text('Add Classic Device'),
        ),
        const SizedBox(height: 16),
        const Text(
          'Connected Devices',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        if (_devices.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'No devices connected',
              style: TextStyle(color: Colors.grey),
            ),
          )
        else
          ..._devices.map(
            (CaptureHelperDevice device) => DeviceListItem(
              device: device,
              onTap: () => _innerNavKey.currentState
                  ?.pushNamed('features', arguments: device),
              onDisconnect: SocketCamTypes.contains(device.type)
                  ? null
                  : () => _helper.removeBleDevice(device: device),
            ),
          ),
        if (_discoveredDevices.isNotEmpty) ...<Widget>[
          const SizedBox(height: 16),
          const Text(
            'Discovered Devices',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          ..._discoveredDevices.map(
            (DiscoveredDeviceInfo info) => ListTile(
              title: Text(
                info.name,
                style: const TextStyle(color: Colors.white),
              ),
              trailing: ElevatedButton(
                onPressed: () async {
                  await _helper.connectDiscoveredDevice(device: info);
                  setState(() {
                    _discoveredDevices = _discoveredDevices
                        .where((DiscoveredDeviceInfo d) => d != info)
                        .toList();
                  });
                },
                child: const Text('Connect'),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
