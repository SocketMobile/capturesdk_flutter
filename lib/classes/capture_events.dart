/// The different types of IDs used to differentiate different types of capture events.
class CaptureEventIds {
  static const int notInitialized = 0; // this id should never be received
  static const int deviceArrival = 1;
  static const int deviceRemoval = 2;
  static const int terminate = 3;
  static const int error = 4;
  static const int decodedData = 5;
  static const int power = 6;
  static const int buttons = 7;
  static const int batteryLevel = 8; // Battery Level has changed
  static const int listenerStarted =
      9; // the communucation port listener has started
  static const int deviceOwnership =
      10; // Notification when a device ownership changes
  static const int deviceManagerArrival = 11; // Device Manager Arrival (BLE)
  static const int deviceManagerRemoval = 12; // Device Manager Removal (BLE)
  static const int deviceDiscovered =
      13; // Notification when a device has been discovered (BLE)
  static const int discoveryEnd =
      14; // Notification when a discovery has ended (BLE)
  static const int ccidStatus =
      15; // CCID Status notification (for PC/SC interface)
  static const int lastID = 16; // just for marking the end of this enum
}

// Data types of capture events
class CaptureEventTypes {
  static const int none = 0;
  static const int byte = 1;
  static const int ulong = 2;
  static const int array = 3;
  static const int string = 4;
  static const int decodedData = 5;
  static const int deviceInfo = 6; // contains the device guid; type; and name
  static const int lastID = 7; // just for marking the end of this enum
}
