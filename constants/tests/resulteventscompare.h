/**
  This is an events template file for the events definition

  2017 © Socket Mobile, Inc. all rights reserved
*/

#ifndef __events_definition
#define __events_definition

// Event Types
enum ESktEventDataType {
	/// For capture events that don't have any value.
	kSktCaptureEventDataTypeNone = 0,
	/// The event has a byte value.
	kSktCaptureEventDataTypeByte = 1,
	/// The event has a unsigned long value.
	kSktCaptureEventDataTypeUlong = 2,
	/// The event has a byte array value.
	kSktCaptureEventDataTypeArray = 3,
	/// The event has a string value.
	kSktCaptureEventDataTypeString = 4,
	/// The event has a decoded data structure as value.
	kSktCaptureEventDataTypeDecodedData = 5,
	/// The event has a device info structure as value (read only).
	kSktCaptureEventDataTypeDeviceInfo = 6,
	/// The event type should not be equal or higher that kLastID otherwise
	/// it means the SDK is not in sync with the actual version of Socket
	/// Mobile Companion running on the host.
	kSktCaptureEventDataTypeLastID = 7,
};


// Events
enum ESktCaptureEventID {
	/// Capture has not been correctly initialized after its first open.
	kSktCaptureEventIdNotInitialized = 0, // Type: kNone
	/// Event when a device has connected or is present.
	kSktCaptureEventIdDeviceArrival = 1, // Type: kDeviceInfo
	/// Event when a device is no longer present.
	kSktCaptureEventIdDeviceRemoval = 2, // Type: kDeviceInfo
	/// Event when Capture is terminated.
	kSktCaptureEventIdTerminate = 3, // Type: kUlong
	/// Event when Capture had an error.
	kSktCaptureEventIdError = 4, // Type: kUlong
	/// Event when Capture has some decoded data available.
	kSktCaptureEventIdDecodedData = 5, // Type: kDecodedData
	/// Event when a device sends a power change notification.
	kSktCaptureEventIdPower = 6, // Type: kUlong
	/// Event when the device button status has changed.
	kSktCaptureEventIdButtons = 7, // Type: kUlong
	/// Event when the battery Level has changed.
	kSktCaptureEventIdBatteryLevel = 8, // Type: kUlong
	/// Event when the communication listener thread has started.
	kSktCaptureEventIdListenerStarted = 9, // Type: kUlong
	/// Event when a device ownership has changed.
	kSktCaptureEventIdDeviceOwnership = 10, // Type: kString
	/// Event when the Device Manager (BLE) is present.
	kSktCaptureEventIdDeviceManagerArrival = 11, // Type: kDeviceInfo
	/// Event when the Device Manager (BLE) is gone.
	kSktCaptureEventIdDeviceManagerRemoval = 12, // Type: kDeviceInfo
	/// A device has been discovered.
	kSktCaptureEventIdDeviceDiscovered = 13, // Type: kDeviceInfo
	/// The device discovery has ended.
	kSktCaptureEventIdDiscoveryEnd = 14, // Type: kNone
	/// Event when a PC/SC device in coupler mode is present.
	kSktCaptureEventIdPcscCouplerArrival = 15, // Type: kDeviceInfo
	/// Event when a PC/SC device in coupler mode is gone.
	kSktCaptureEventIdPcscCouplerRemoval = 16, // Type: kDeviceInfo
	/// Event when a Tag is present in PC/SC mode.
	kSktCaptureEventIdPcscTagArrival = 17, // Type: kDeviceInfo
	/// Event when a Tag is gone in PC/SC mode.
	kSktCaptureEventIdPcscTagRemoval = 18, // Type: kDeviceInfo
	/// Event when a Tag Transmit response is received.
	kSktCaptureEventIdPcscTagTransmitResponse = 19, // Type: kArray
	/// Event when a PC/SC Device Control Response is received.
	kSktCaptureEventIdPcscDeviceControlResponse = 20, // Type: kArray
	/// The Last Event should always be the last ID in the list of possible events.
	kSktCaptureEventIdLastID = 21, // Type: kNone
};


#endif
