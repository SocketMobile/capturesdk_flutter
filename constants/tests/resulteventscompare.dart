/**
  This is an event IDs template file for the events definition

  2022 © Socket Mobile, Inc. all rights reserved
*/


/// Ids assigned to each capture event.
class CaptureEventIds {
  
	/// Capture has not been correctly initialized after its first open.
	/// Type: kNone
	static const int notInitialized = 0;

	/// Event when a device has connected or is present.
	/// Type: kDeviceInfo
	static const int deviceArrival = 1;

	/// Event when a device is no longer present.
	/// Type: kDeviceInfo
	static const int deviceRemoval = 2;

	/// Event when Capture is terminated.
	/// Type: kUlong
	static const int terminate = 3;

	/// Event when Capture had an error.
	/// Type: kUlong
	static const int error = 4;

	/// Event when Capture has some decoded data available.
	/// Type: kDecodedData
	static const int decodedData = 5;

	/// Event when a device sends a power change notification.
	/// Type: kUlong
	static const int power = 6;

	/// Event when the device button status has changed.
	/// Type: kUlong
	static const int buttons = 7;

	/// Event when the battery Level has changed.
	/// Type: kUlong
	static const int batteryLevel = 8;

	/// Event when the communication listener thread has started.
	/// Type: kUlong
	static const int listenerStarted = 9;

	/// Event when a device ownership has changed.
	/// Type: kString
	static const int deviceOwnership = 10;

	/// Event when the Device Manager (BLE) is present.
	/// Type: kDeviceInfo
	static const int deviceManagerArrival = 11;

	/// Event when the Device Manager (BLE) is gone.
	/// Type: kDeviceInfo
	static const int deviceManagerRemoval = 12;

	/// A device has been discovered.
	/// Type: kDeviceInfo
	static const int deviceDiscovered = 13;

	/// The device discovery has ended.
	/// Type: kNone
	static const int discoveryEnd = 14;

	/// Event when a PC/SC device in coupler mode is present.
	/// Type: kDeviceInfo
	static const int pcscCouplerArrival = 15;

	/// Event when a PC/SC device in coupler mode is gone.
	/// Type: kDeviceInfo
	static const int pcscCouplerRemoval = 16;

	/// Event when a Tag is present in PC/SC mode.
	/// Type: kDeviceInfo
	static const int pcscTagArrival = 17;

	/// Event when a Tag is gone in PC/SC mode.
	/// Type: kDeviceInfo
	static const int pcscTagRemoval = 18;

	/// Event when a Tag Transmit response is received.
	/// Type: kArray
	static const int pcscTagTransmitResponse = 19;

	/// Event when a PC/SC Device Control Response is received.
	/// Type: kArray
	static const int pcscDeviceControlResponse = 20;

	/// The Last Event should always be the last ID in the list of possible events.
	/// Type: kNone
	static const int lastID = 21;

}

/// Types of Capture Events a user might encounter.
class CaptureEventTypes { 

	/// For capture events that don't have any value.
	static const int none = 0;

	/// The event has a byte value.
	static const int byte = 1;

	/// The event has a unsigned long value.
	static const int ulong = 2;

	/// The event has a byte array value.
	static const int array = 3;

	/// The event has a string value.
	static const int string = 4;

	/// The event has a decoded data structure as value.
	static const int decodedData = 5;

	/// The event has a device info structure as value (read only).
	static const int deviceInfo = 6;

	/// The event type should not be equal or higher that kLastID otherwise
	/// it means the SDK is not in sync with the actual version of Socket
	/// Mobile Companion running on the host.
	static const int lastID = 7;

}
