/**
  @file SktCaptureEvents.h

  This is an events template file for the events definition
  @author Eric Glaenzer
  @date 7/7/2017
  @copyright © 2022 Socket Mobile, Inc. all rights reserved
*/

/**
  define the events used by Capture.
*/
typedef NS_ENUM(NSInteger, SKTCaptureEventDataType) {
	/**
	For capture events that don't have any value.
	*/
	SKTCaptureEventDataTypeNone = 0,

	/**
	The event has a byte value.
	*/
	SKTCaptureEventDataTypeByte = 1,

	/**
	The event has a unsigned long value.
	*/
	SKTCaptureEventDataTypeUlong = 2,

	/**
	The event has a byte array value.
	*/
	SKTCaptureEventDataTypeArray = 3,

	/**
	The event has a string value.
	*/
	SKTCaptureEventDataTypeString = 4,

	/**
	The event has a decoded data structure as value.
	*/
	SKTCaptureEventDataTypeDecodedData = 5,

	/**
	The event has a device info structure as value (read only).
	*/
	SKTCaptureEventDataTypeDeviceInfo = 6,

	/**
	The event type should not be equal or higher that kLastID otherwise
	it means the SDK is not in sync with the actual version of Socket
	Mobile Companion running on the host.
	*/
	SKTCaptureEventDataTypeLastID = 7,

};

typedef NS_ENUM(NSInteger, SKTCaptureEventID) {
	/**
	Capture has not been correctly initialized after its first open.

	Type: kNone
	*/
	SKTCaptureEventIDNotInitialized = 0,

	/**
	Event when a device has connected or is present.

	Type: kDeviceInfo
	*/
	SKTCaptureEventIDDeviceArrival = 1,

	/**
	Event when a device is no longer present.

	Type: kDeviceInfo
	*/
	SKTCaptureEventIDDeviceRemoval = 2,

	/**
	Event when Capture is terminated.

	Type: kUlong
	*/
	SKTCaptureEventIDTerminate = 3,

	/**
	Event when Capture had an error.

	Type: kUlong
	*/
	SKTCaptureEventIDError = 4,

	/**
	Event when Capture has some decoded data available.

	Type: kDecodedData
	*/
	SKTCaptureEventIDDecodedData = 5,

	/**
	Event when a device sends a power change notification.

	Type: kUlong
	*/
	SKTCaptureEventIDPower = 6,

	/**
	Event when the device button status has changed.

	Type: kUlong
	*/
	SKTCaptureEventIDButtons = 7,

	/**
	Event when the battery Level has changed.

	Type: kUlong
	*/
	SKTCaptureEventIDBatteryLevel = 8,

	/**
	Event when the communication listener thread has started.

	Type: kUlong
	*/
	SKTCaptureEventIDListenerStarted = 9,

	/**
	Event when a device ownership has changed.

	Type: kString
	*/
	SKTCaptureEventIDDeviceOwnership = 10,

	/**
	Event when the Device Manager (BLE) is present.

	Type: kDeviceInfo
	*/
	SKTCaptureEventIDDeviceManagerArrival = 11,

	/**
	Event when the Device Manager (BLE) is gone.

	Type: kDeviceInfo
	*/
	SKTCaptureEventIDDeviceManagerRemoval = 12,

	/**
	A device has been discovered.

	Type: kDeviceInfo
	*/
	SKTCaptureEventIDDeviceDiscovered = 13,

	/**
	The device discovery has ended.

	Type: kNone
	*/
	SKTCaptureEventIDDiscoveryEnd = 14,

	/**
	Event when a PC/SC device in coupler mode is present.

	Type: kDeviceInfo
	*/
	SKTCaptureEventIDPcscCouplerArrival = 15,

	/**
	Event when a PC/SC device in coupler mode is gone.

	Type: kDeviceInfo
	*/
	SKTCaptureEventIDPcscCouplerRemoval = 16,

	/**
	Event when a Tag is present in PC/SC mode.

	Type: kDeviceInfo
	*/
	SKTCaptureEventIDPcscTagArrival = 17,

	/**
	Event when a Tag is gone in PC/SC mode.

	Type: kDeviceInfo
	*/
	SKTCaptureEventIDPcscTagRemoval = 18,

	/**
	Event when a Tag Transmit response is received.

	Type: kArray
	*/
	SKTCaptureEventIDPcscTagTransmitResponse = 19,

	/**
	Event when a PC/SC Device Control Response is received.

	Type: kArray
	*/
	SKTCaptureEventIDPcscDeviceControlResponse = 20,

	/**
	The Last Event should always be the last ID in the list of possible events.

	Type: kNone
	*/
	SKTCaptureEventIDLastID = 21,

};


