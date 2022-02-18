// This is an event IDs template file for the events definition
// 2022 © Socket Mobile, Inc. all rights reserved


class CaptureEventIds {

	// Capture has not been correctly initialized after its first open.
	// Type: kNone
	int notInitialized = 0;

	// Event when a device has connected or is present.
	// Type: kDeviceInfo
	int deviceArrival = 1;

	// Event when a device is no longer present.
	// Type: kDeviceInfo
	int deviceRemoval = 2;

	// Event when Capture is terminated.
	// Type: kUlong
	int terminate = 3;

	// Event when Capture had an error.
	// Type: kUlong
	int error = 4;

	// Event when Capture has some decoded data available.
	// Type: kDecodedData
	int decodedData = 5;

	// Event when a device sends a power change notification.
	// Type: kUlong
	int power = 6;

	// Event when the device button status has changed.
	// Type: kUlong
	int buttons = 7;

	// Event when the battery Level has changed.
	// Type: kUlong
	int batteryLevel = 8;

	// Event when the communication listener thread has started.
	// Type: kUlong
	int listenerStarted = 9;

	// Event when a device ownership has changed.
	// Type: kString
	int deviceOwnership = 10;

	// Event when the Device Manager (BLE) is present.
	// Type: kDeviceInfo
	int deviceManagerArrival = 11;

	// Event when the Device Manager (BLE) is gone.
	// Type: kDeviceInfo
	int deviceManagerRemoval = 12;

	// A device has been discovered.
	// Type: kDeviceInfo
	int deviceDiscovered = 13;

	// The device discovery has ended.
	// Type: kNone
	int discoveryEnd = 14;

	// The Last Event should always be the last ID in the list of possible events.
	// Type: kNone
	int lastID = 21;

	CaptureEventIds();

}

class CaptureEventTypes { 

	// For capture events that don't have any value.
	int none = 0;

	// The event has a byte value.
	int byte = 1;

	// The event has a unsigned long value.
	int ulong = 2;

	// The event has a byte array value.
	int array = 3;

	// The event has a string value.
	int string = 4;

	// The event has a decoded data structure as value.
	int decodedData = 5;

	// The event has a device info structure as value (read only).
	int deviceInfo = 6;

	// The event type should not be equal or higher that kLastID otherwise
	// it means the SDK is not in sync with the actual version of Socket
	// Mobile Companion running on the host.
	int lastID = 7;

	CaptureEventTypes();

}


