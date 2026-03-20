import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:flutter/material.dart';

import 'battery_screen.dart';
import 'firmware_screen.dart';
import 'friendly_name_screen.dart';
import 'power_timers_screen.dart';
import 'symbologies_screen.dart';
import 'trigger_screen.dart';

class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({
    super.key,
    required this.device,
    required this.decodedDataNotifier,
    required this.helper,
  });

  final CaptureHelperDevice device;
  final ValueNotifier<int> decodedDataNotifier;
  final CaptureHelper helper;

  bool get _isSocketCam => SocketCamTypes.contains(device.type);

  @override
  Widget build(BuildContext context) {
    final List<Widget> tiles = <Widget>[
      _FeatureTile(
        title: 'Set Trigger',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => TriggerScreen(
              device: device,
              decodedDataNotifier: decodedDataNotifier,
              helper: helper,
            ),
          ),
        ),
      ),
      _FeatureTile(
        title: 'Friendly Name',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => FriendlyNameScreen(device: device),
          ),
        ),
      ),
      _FeatureTile(
        title: 'Symbologies',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (_) => SymbologiesScreen(device: device),
          ),
        ),
      ),
      if (!_isSocketCam) ...<Widget>[
        _FeatureTile(
          title: 'Battery Level',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => BatteryScreen(device: device),
            ),
          ),
        ),
        _FeatureTile(
          title: 'Power Off Timers',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => PowerTimersScreen(device: device),
            ),
          ),
        ),
        _FeatureTile(
          title: 'Firmware Version',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => FirmwareScreen(device: device),
            ),
          ),
        ),
      ],
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(device.name, style: const TextStyle(color: Colors.white)),
      ),
      body: ListView.separated(
        itemCount: tiles.length,
        separatorBuilder: (_, __) => const Divider(color: Colors.grey, height: 0.5),
        itemBuilder: (_, int index) => tiles[index],
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}
