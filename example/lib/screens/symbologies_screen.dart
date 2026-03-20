import 'dart:developer' as developer;

import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:flutter/material.dart';

class SymbologiesScreen extends StatefulWidget {
  const SymbologiesScreen({super.key, required this.device});

  final CaptureHelperDevice device;

  @override
  State<SymbologiesScreen> createState() => _SymbologiesScreenState();
}

bool _isBarcodeReader(int deviceType) {
  if (SocketCamTypes.contains(deviceType)) {
    developer.log('isBarcodeReader: true (SocketCam type 0x${deviceType.toRadixString(16)})');
    return true;
  }
  final int function = (deviceType >> 8) & 0xFF;
  final bool result = function == CaptureDeviceTypeFunction.legacy ||
      (function & CaptureDeviceTypeFunction.scanner) != 0;
  developer.log('isBarcodeReader: $result (type=0x${deviceType.toRadixString(16)}, function=0x${function.toRadixString(16)})');
  return result;
}

bool _isNfcReader(int deviceType) {
  final int function = (deviceType >> 8) & 0xFF;
  final bool result = (function & CaptureDeviceTypeFunction.nFCReader) != 0 ||
      (function & CaptureDeviceTypeFunction.nFCWriter) != 0;
  developer.log('isNfcReader: $result (type=0x${deviceType.toRadixString(16)}, function=0x${function.toRadixString(16)})');
  return result;
}

class _SymbologiesScreenState extends State<SymbologiesScreen> {
  List<DataSource> _dataSources = <DataSource>[];
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadDataSources();
  }

  Future<void> _loadDataSources() async {
    setState(() {
      _loading = true;
      _error = null;
      _dataSources = <DataSource>[];
    });

    final List<DataSource> results = <DataSource>[];

    developer.log('=== Loading DataSources for device "${widget.device.name}" ===');
    developer.log('Device type: ${widget.device.type} (0x${widget.device.type.toRadixString(16)})');

    if (_isBarcodeReader(widget.device.type)) {
      developer.log('Querying barcode symbologies: 0..${CaptureDataSourceID.lastSymbologyID}');
      await _queryRange(0, CaptureDataSourceID.lastSymbologyID, results);
    }
    if (_isNfcReader(widget.device.type)) {
      developer.log('Querying NFC tag types: ${CaptureDataSourceID.tagTypeISO14443TypeA}..${CaptureDataSourceID.tagTypeLastTagType + 1}');
      await _queryRange(
        CaptureDataSourceID.tagTypeISO14443TypeA,
        CaptureDataSourceID.tagTypeLastTagType + 1,
        results,
      );
    }

    developer.log('Total data sources found: ${results.length}');

    if (mounted) {
      setState(() {
        _dataSources = results;
        _loading = false;
      });
    }
  }

  Future<void> _queryRange(int start, int end, List<DataSource> results) async {
    for (int id = start; id < end; id++) {
      try {
        final DataSource result = await widget.device.getDataSource(
          DataSource(
            id: id,
            name: '',
            status: CaptureDataSourceStatus.defaultStatus,
            flags: CaptureDataSourceFlags.status,
          ),
        );
        developer.log('DataSource id=$id -> name="${result.name}", status=${result.status}, flags=${result.flags}');
        if (result.status != CaptureDataSourceStatus.notSupported) {
          results.add(result);
          if (mounted) {
            setState(() {
              _dataSources = List<DataSource>.from(results);
            });
          }
        }
      } on CaptureException catch (e) {
        developer.log('DataSource id=$id -> CaptureException: ${e.code} ${e.message}');
      }
    }
  }

  Future<void> _toggleDataSource(DataSource ds) async {
    final int newStatus = ds.status == CaptureDataSourceStatus.enable
        ? CaptureDataSourceStatus.disable
        : CaptureDataSourceStatus.enable;
    try {
      await widget.device.setDataSource(
        DataSource(
          id: ds.id,
          name: ds.name,
          status: newStatus,
          flags: CaptureDataSourceFlags.status,
        ),
      );
      setState(() {
        _dataSources = _dataSources.map((DataSource d) {
          if (d.id == ds.id) {
            return DataSource(
              id: d.id,
              name: d.name,
              status: newStatus,
              flags: d.flags,
            );
          }
          return d;
        }).toList();
      });
    } on CaptureException catch (e) {
      setState(() => _error = 'Error: ${e.code} ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Symbologies',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              widget.device.name,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _error!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),
          if (_loading)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                itemCount: _dataSources.length,
                separatorBuilder: (_, __) =>
                    const Divider(color: Colors.grey, height: 0.5),
                itemBuilder: (BuildContext context, int index) {
                  final DataSource ds = _dataSources[index];
                  final bool enabled =
                      ds.status == CaptureDataSourceStatus.enable;
                  return SwitchListTile(
                    title: Text(
                      ds.name.isNotEmpty ? ds.name : 'ID ${ds.id}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    value: enabled,
                    onChanged: (_) => _toggleDataSource(ds),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
