import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:flutter/material.dart';

class DecodedDataHeader extends StatelessWidget {
  const DecodedDataHeader({super.key, required this.scans});

  final List<DecodedData> scans;

  static const double _dataFontSize = 18;
  static const double _dataLineHeight = 1.2;
  static const int _maxVisibleLines = 10;

  @override
  Widget build(BuildContext context) {
    final double maxDataHeight = MediaQuery.textScalerOf(context).scale(_dataFontSize) *
        _dataLineHeight *
        _maxVisibleLines;

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
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxDataHeight),
              child: SingleChildScrollView(
                child: Text(
                  scans.last.dataAsString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: _dataFontSize,
                    height: _dataLineHeight,
                  ),
                ),
              ),
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
