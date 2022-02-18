/**
  This is an event IDs template file for the event definition

  2017 © Socket Mobile, Inc. all rights reserved
*/

export enum Event {
	// Capture has not been correctly initialized after its first open.
	// Type: kNone
	NotInitialized = 0,

	// Event when a device has connected or is present.
	// Type: kDeviceInfo
	DeviceArrival = 1,

	// Event when a device is no longer present.
	// Type: kDeviceInfo
	DeviceRemoval = 2,

	// Event when Capture is terminated.
	// Type: kUlong
	Terminate = 3,

	// Event when Capture had an error.
	// Type: kUlong
	Error = 4,

	// Event when Capture has some decoded data available.
	// Type: kDecodedData
	DecodedData = 5,

	// Event when a device sends a power change notification.
	// Type: kUlong
	Power = 6,

	// Event when the device button status has changed.
	// Type: kUlong
	Buttons = 7,

	// Event when the battery Level has changed.
	// Type: kUlong
	BatteryLevel = 8,

	// Event when the communication listener thread has started.
	// Type: kUlong
	ListenerStarted = 9,

	// Event when a device ownership has changed.
	// Type: kString
	DeviceOwnership = 10,

	// Event when the Device Manager (BLE) is present.
	// Type: kDeviceInfo
	DeviceManagerArrival = 11,

	// Event when the Device Manager (BLE) is gone.
	// Type: kDeviceInfo
	DeviceManagerRemoval = 12,

	// A device has been discovered.
	// Type: kDeviceInfo
	DeviceDiscovered = 13,

	// The device discovery has ended.
	// Type: kNone
	DiscoveryEnd = 14,

	// Event when a PC/SC device in coupler mode is present.
	// Type: kDeviceInfo
	PcscCouplerArrival = 15,

	// Event when a PC/SC device in coupler mode is gone.
	// Type: kDeviceInfo
	PcscCouplerRemoval = 16,

	// Event when a Tag is present in PC/SC mode.
	// Type: kDeviceInfo
	PcscTagArrival = 17,

	// Event when a Tag is gone in PC/SC mode.
	// Type: kDeviceInfo
	PcscTagRemoval = 18,

	// Event when a Tag Transmit response is received.
	// Type: kArray
	PcscTagTransmitResponse = 19,

	// Event when a PC/SC Device Control Response is received.
	// Type: kArray
	PcscDeviceControlResponse = 20,

	// The Last Event should always be the last ID in the list of possible events.
	// Type: kNone
	LastID = 21,

};

export enum Types {
	// For capture events that don't have any value.
	None = 0,

	// The event has a byte value.
	Byte = 1,

	// The event has a unsigned long value.
	Ulong = 2,

	// The event has a byte array value.
	Array = 3,

	// The event has a string value.
	String = 4,

	// The event has a decoded data structure as value.
	DecodedData = 5,

	// The event has a device info structure as value (read only).
	DeviceInfo = 6,

	// The event type should not be equal or higher that kLastID otherwise
	// it means the SDK is not in sync with the actual version of Socket
	// Mobile Companion running on the host.
	LastID = 7,

};

