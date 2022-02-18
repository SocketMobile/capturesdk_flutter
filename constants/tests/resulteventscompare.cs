/**
  This is an event IDs template file for the events definition

  2017 © Socket Mobile, Inc. all rights reserved
*/


			/// <summary>
			/// defines the event value type. Events can have value of different
			/// type or no value at all.
			/// </summary>
			public class DataTypes {
				/// <summary>
				/// For capture events that don't have any value.
				/// </summary>
				public const int kNone = 0;

				/// <summary>
				/// The event has a byte value.
				/// </summary>
				public const int kByte = 1;

				/// <summary>
				/// The event has a unsigned long value.
				/// </summary>
				public const int kUlong = 2;

				/// <summary>
				/// The event has a byte array value.
				/// </summary>
				public const int kArray = 3;

				/// <summary>
				/// The event has a string value.
				/// </summary>
				public const int kString = 4;

				/// <summary>
				/// The event has a decoded data structure as value.
				/// </summary>
				public const int kDecodedData = 5;

				/// <summary>
				/// The event has a device info structure as value (read only).
				/// </summary>
				public const int kDeviceInfo = 6;

				/// <summary>
				/// The event type should not be equal or higher that kLastID otherwise
				/// it means the SDK is not in sync with the actual version of Socket
				/// Mobile Companion running on the host.
				/// </summary>
				public const int kLastID = 7;

			};



			/// <summary>
			/// defines the event IDs used in Capture
			/// </summary>
			public class Id
			{
				/// <summary>
				/// Capture has not been correctly initialized after its first open.
				/// </summary>
				public const int kNotInitialized = 0;		// Type: kNone

				/// <summary>
				/// Event when a device has connected or is present.
				/// </summary>
				public const int kDeviceArrival = 1;		// Type: kDeviceInfo

				/// <summary>
				/// Event when a device is no longer present.
				/// </summary>
				public const int kDeviceRemoval = 2;		// Type: kDeviceInfo

				/// <summary>
				/// Event when Capture is terminated.
				/// </summary>
				public const int kTerminate = 3;		// Type: kUlong

				/// <summary>
				/// Event when Capture had an error.
				/// </summary>
				public const int kError = 4;		// Type: kUlong

				/// <summary>
				/// Event when Capture has some decoded data available.
				/// </summary>
				public const int kDecodedData = 5;		// Type: kDecodedData

				/// <summary>
				/// Event when a device sends a power change notification.
				/// </summary>
				public const int kPower = 6;		// Type: kUlong

				/// <summary>
				/// Event when the device button status has changed.
				/// </summary>
				public const int kButtons = 7;		// Type: kUlong

				/// <summary>
				/// Event when the battery Level has changed.
				/// </summary>
				public const int kBatteryLevel = 8;		// Type: kUlong

				/// <summary>
				/// Event when the communication listener thread has started.
				/// </summary>
				public const int kListenerStarted = 9;		// Type: kUlong

				/// <summary>
				/// Event when a device ownership has changed.
				/// </summary>
				public const int kDeviceOwnership = 10;		// Type: kString

				/// <summary>
				/// Event when the Device Manager (BLE) is present.
				/// </summary>
				public const int kDeviceManagerArrival = 11;		// Type: kDeviceInfo

				/// <summary>
				/// Event when the Device Manager (BLE) is gone.
				/// </summary>
				public const int kDeviceManagerRemoval = 12;		// Type: kDeviceInfo

				/// <summary>
				/// A device has been discovered.
				/// </summary>
				public const int kDeviceDiscovered = 13;		// Type: kDeviceInfo

				/// <summary>
				/// The device discovery has ended.
				/// </summary>
				public const int kDiscoveryEnd = 14;		// Type: kNone

				/// <summary>
				/// Event when a PC/SC device in coupler mode is present.
				/// </summary>
				public const int kPcscCouplerArrival = 15;		// Type: kDeviceInfo

				/// <summary>
				/// Event when a PC/SC device in coupler mode is gone.
				/// </summary>
				public const int kPcscCouplerRemoval = 16;		// Type: kDeviceInfo

				/// <summary>
				/// Event when a Tag is present in PC/SC mode.
				/// </summary>
				public const int kPcscTagArrival = 17;		// Type: kDeviceInfo

				/// <summary>
				/// Event when a Tag is gone in PC/SC mode.
				/// </summary>
				public const int kPcscTagRemoval = 18;		// Type: kDeviceInfo

				/// <summary>
				/// Event when a Tag Transmit response is received.
				/// </summary>
				public const int kPcscTagTransmitResponse = 19;		// Type: kArray

				/// <summary>
				/// Event when a PC/SC Device Control Response is received.
				/// </summary>
				public const int kPcscDeviceControlResponse = 20;		// Type: kArray

				/// <summary>
				/// The Last Event should always be the last ID in the list of possible events.
				/// </summary>
				public const int kLastID = 21;		// Type: kNone

			};


