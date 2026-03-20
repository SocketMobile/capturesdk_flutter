import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:flutter/material.dart';

class DeviceListItem extends StatelessWidget {
  const DeviceListItem({
    super.key,
    required this.device,
    required this.onTap,
    this.onDisconnect,
  });

  final CaptureHelperDevice device;
  final VoidCallback onTap;
  final VoidCallback? onDisconnect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    device.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (onDisconnect != null)
              TextButton(
                onPressed: onDisconnect,
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Disconnect'),
              )
          ],
        ),
      ),
    );
  }
}
