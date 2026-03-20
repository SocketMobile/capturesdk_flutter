import 'package:capturesdk_flutter/capturesdk.dart';
import 'package:flutter/material.dart';

class FriendlyNameScreen extends StatefulWidget {
  const FriendlyNameScreen({super.key, required this.device});

  final CaptureHelperDevice device;

  @override
  State<FriendlyNameScreen> createState() => _FriendlyNameScreenState();
}

class _FriendlyNameScreenState extends State<FriendlyNameScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _currentName;
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadName() async {
    setState(() => _loading = true);
    try {
      final String name = await widget.device.getFriendlyName();
      setState(() {
        _currentName = name;
        _controller.text = name;
        _loading = false;
      });
    } on CaptureException catch (e) {
      setState(() {
        _error = 'Error: ${e.code} ${e.message}';
        _loading = false;
      });
    }
  }

  Future<void> _setName() async {
    setState(() {
      _error = null;
      _loading = true;
    });
    try {
      await widget.device.setFriendlyName(_controller.text);
      await _loadName();
    } on CaptureException catch (e) {
      setState(() {
        _error = 'Error: ${e.code} ${e.message}';
        _loading = false;
      });
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
          'Friendly Name',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.device.name,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 24),
            if (_currentName != null)
              Text(
                'Current: $_currentName',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Friendly Name',
                hintStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF0A84FF)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A84FF),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: _loading ? null : _setName,
              child: _loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Set Friendly Name'),
            ),
            if (_error != null) ...<Widget>[
              const SizedBox(height: 16),
              Text(
                _error!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
