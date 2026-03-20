import 'package:flutter_test/flutter_test.dart';

// ignore: avoid_relative_lib_imports
import '../lib/main.dart';

void main() {
  test('MyApp can be instantiated', () {
    // The example app requires network services (WebSocket, native plugins)
    // that are unavailable in a test environment.
    const MyApp app = MyApp();
    expect(app, isNotNull);
  });
}
