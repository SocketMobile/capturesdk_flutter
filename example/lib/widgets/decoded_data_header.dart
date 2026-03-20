import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:flutter/material.dart';

class DecodedDataHeader extends StatelessWidget {
  const DecodedDataHeader({super.key, required this.scans});

  final List<DecodedData> scans;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1C1C1E),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Decoded Data',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          if (scans.isEmpty)
            const Text(
              'No scans yet',
              style: TextStyle(color: Colors.grey),
            )
          else ...<Widget>[
            Text(
              scans.last.dataAsString(),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              scans.last.name,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}
