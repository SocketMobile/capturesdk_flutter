/**
  This is an property IDs template file for the properties definition

  2017 © Socket Mobile, Inc. all rights reserved
*/

export enum Property {
	// Set to notify Capture that the client is shutting down gracefully.
	// Capture will send device removal events followed by a terminate
	// event. Once you receive the terminate event, it is safe to shut
	// down Capture.
	// Device: False	Get Type: NotApplicable 	Set Type: None
	Abort = -2146435072,

	// Gets the Capture service version.
	// Device: False	Get Type: None 	Set Type: NotApplicable
	Version = -2147418111,

	// Gets the version of the firmware interface that Capture service
	// supports. This can be useful for determining if the Capture service
	// supports a particular hardware feature.
	// Device: False	Get Type: None 	Set Type: NotApplicable
	InterfaceVersion = -2147418112,

	// property to set or get the Capture configuration
	// Device: False	Get Type: String 	Set Type: String
	Configuration = -2141913085,

	// Gets or sets the data confirmation mode. The data confirmation mode
	// determines who acknowledges whether the data received was good or
	// bad.
	// Device: False	Get Type: None 	Set Type: Byte
	DataConfirmationMode = -2147352572,

	// Gets or sets the data confirmation action. Data confirmation action
	// determines how good or bad data is acknowledged.
	// Device: False	Get Type: None 	Set Type: Ulong
	DataConfirmationAction = -2147287035,

	// Gets or sets the log level of various Capture service components
	// (Only works on debug builds of the service).
	// Device: False	Get Type: Byte 	Set Type: Array
	MonitorMode = -2145124346,

	// property to get or set the SocketCam status
	// (iOS only)
	// Device: False	Get Type: None 	Set Type: Byte
	SocketCamStatus = -2147352569,

	// Gets the firmware version of the device
	// Device: True	Get Type: None 	Set Type: NotApplicable
	VersionDevice = 65536,

	// Gets the model of the device
	// Device: True	Get Type: None 	Set Type: NotApplicable
	DeviceType = 65538,

	// Sends an arbitrary get or set command to the device
	// Device: True	Get Type: Array 	Set Type: Array
	DeviceSpecific = 4456451,

	// property to get or set the data source status / information
	// Device: True	Get Type: DataSource 	Set Type: DataSource
	DataSourceDevice = 7798788,

	// Sets the trigger of the device - can start or stop a read and
	// enable or disable the physical trigger button on the device.
	// Device: True	Get Type: NotApplicable 	Set Type: Byte
	TriggerDevice = 1179653,

	// property to apply a config to a Capture Device (not yet enabled)
	// Device: True	Get Type: NotApplicable 	Set Type: None
	ApplyConfigDevice = 1048582,

	// Gets or sets a preamble for data decoded by the device. When set,
	// the preamble is added in front of the decoded data.
	// Device: True	Get Type: None 	Set Type: String
	PreambleDevice = 327687,

	// Gets or sets a postamble for data decoded by the device. When set,
	// the postamble is added to the end of the decoded data.
	// Device: True	Get Type: None 	Set Type: String
	PostambleDevice = 327688,

	// property to get the Capture Device capabilities
	// Device: True	Get Type: Byte 	Set Type: NotApplicable
	CapabilitiesDevice = 2162697,

	// Gets the change id of the device. The change id is a checksum of
	// all the engine settings - e.g. symbology settings, preamble,
	// postamble, etc - and can be used to determine if the device
	// configuration has been altered by another application or using a
	// command barcode.
	// Device: True	Get Type: None 	Set Type: NotApplicable
	ChangeIdDevice = 65546,

	// property to get or set the Decoded Data Format of a Capture Device
	// Device: True	Get Type: None 	Set Type: Byte
	DataFormatDevice = 131083,

	// Gets or sets the friendly name of the device. The friendly name is
	// the name that appears in Bluetooth settings.
	// Device: True	Get Type: None 	Set Type: String
	FriendlyNameDevice = 327936,

	// property to get or set the Capture Device Security Mode
	// Device: True	Get Type: None 	Set Type: Byte
	SecurityModeDevice = 131329,

	// property to get or set the Capture Device PIN code
	// Device: True	Get Type: NotApplicable 	Set Type: String
	PinCodeDevice = 1376514,

	// Set deletes pairing and bonding information off the device. Useful
	// when preparing to pair the Capture device to a different host.
	// Device: True	Get Type: NotApplicable 	Set Type: Byte
	DeletePairingBondingDevice = 1179907,

	// Set resets all the settings on the device to their default values.
	// Device: True	Get Type: NotApplicable 	Set Type: None
	RestoreFactoryDefaultsDevice = 1048836,

	// Set turns the device off
	// Device: True	Get Type: NotApplicable 	Set Type: None
	SetPowerOffDevice = 1048837,

	// Gets the current state of each button on the device. Consider using
	// kNotificationsDevice to subscribe to button events instead.
	// Device: True	Get Type: None 	Set Type: NotApplicable
	ButtonsStatusDevice = 65798,

	// Gets or sets the sound configuration of the device. There are
	// separate sound configurations for when a good scan is acknowledged
	// locally (by the Capture device) and when it is acknowledged by the
	// host. The same applies to the bad scan sound configuration.
	// Device: True	Get Type: Byte 	Set Type: Array
	SoundConfigDevice = 2359559,

	// Gets or sets the trigger lock and auto-off timers. The trigger lock
	// determines how long the trigger remains locked after decoding data
	// without receiving confirmation. There are two auto-off timers, one
	// for when the device is connected to a host and one for when it is
	// not.
	// Device: True	Get Type: None 	Set Type: Array
	TimersDevice = 262408,

	// Gets or sets local device acknowledgement. When enabled, the device
	// acknowledges decoded data as soon as it is decoded. When disabled,
	// the device waits for the host to acknowledge decoded data and the
	// trigger will be locked until acknowledgement is received or the
	// trigger lock timeout has elapsed.
	// Device: True	Get Type: None 	Set Type: Byte
	LocalAcknowledgmentDevice = 131337,

	// Sends an acknowledgement to the device. Acknowledgement can either
	// be positive or negative - a.k.a. good scan or bad scan.
	// Device: True	Get Type: NotApplicable 	Set Type: Ulong
	DataConfirmationDevice = 1245450,

	// Gets the current battery level of the device. Consider using 
	// kNotificationsDevice to subscribe to battery level change events
	// instead.
	// Device: True	Get Type: None 	Set Type: NotApplicable
	BatteryLevelDevice = 65803,

	// Gets or sets the local decode action of the device. Determines how
	// decoded data is acknowledged - i.e. with a beep, rumble, flash or
	// some combination of all three.
	// Device: True	Get Type: None 	Set Type: Byte
	LocalDecodeActionDevice = 131340,

	// Gets the Bluetooth address of the device
	// Device: True	Get Type: None 	Set Type: NotApplicable
	BluetoothAddressDevice = 65805,

	// Gets the statistics counters of the device. Counters record the
	// absolute number of times a particular event has occurred.
	// Device: True	Get Type: None 	Set Type: NotApplicable
	StatisticCountersDevice = 65806,

	// Gets or sets the rumble configuration of the device. There are
	// separate rumble configurations for when a good scan is acknowledged
	// locally (by the Capture device) and when it is acknowledged by the
	// host. The same applies to the bad scan rumble configuration.
	// Device: True	Get Type: Byte 	Set Type: Array
	RumbleConfigDevice = 2359567,

	// property to get or set the Capture Device Profile Configuration
	// Device: True	Get Type: None 	Set Type: Array
	ProfileConfigDevice = 262416,

	// Instructs the device to drop its connection. Note: After sending
	// this command, the host will be unable to send any subsequent
	// commands to this device.
	// Device: True	Get Type: NotApplicable 	Set Type: Byte
	DisconnectDevice = 1179921,

	// Gets or sets arbitrary bytes to store on the device. The device has
	// 16 storage locations which can hold up to 64 bytes each.
	// Device: True	Get Type: Array 	Set Type: Array
	DataStoreDevice = 4456722,

	// Gets or sets subscriptions to various events from the device.
	// Events that can be subscribed to include, trigger press/release,
	// power button press/release, power state and battery level change.
	// Device: True	Get Type: None 	Set Type: Ulong
	NotificationsDevice = 196883,

	// property to get the Capture Device Connect reason
	// Device: True	Get Type: None 	Set Type: NotApplicable
	ConnectReasonDevice = 65812,

	// Gets the current power state of the device. Consider using
	// kNotificationsDevice to subscribe to power state events instead.
	// Device: True	Get Type: None 	Set Type: NotApplicable
	PowerStateDevice = 65813,

	// Gets or sets the reconnect behavior of the device when it is
	// powered on in application mode. By default, the device will attempt
	// to reconnect to the last host, but this feature can be turned off
	// using this property.
	// Device: True	Get Type: None 	Set Type: Byte
	StartUpRoleSPPDevice = 131350,

	// property to get or set the Capture Device Connection Beep
	// Configuration.
	// Device: True	Get Type: None 	Set Type: Byte
	ConnectionBeepConfigDevice = 131351,

	// Gets or sets the status of the flash on the SocketCam device.
	// Device: True	Get Type: None 	Set Type: Byte
	FlashDevice = 131352,

	// property to get or set the Capture Device Overlay View (SocketCam
	// only)
	// Device: True	Get Type: None 	Set Type: Object
	OverlayViewDevice = 590105,

	// property to get or set the Capture Device Stand Configuration
	// Device: True	Get Type: None 	Set Type: Ulong
	StandConfigDevice = 196890,

	// property to start a BLE discovery from a Device Manager
	// Device: True	Get Type: NotApplicable 	Set Type: Ulong
	StartDiscovery = 1245696,

	// property to set or get the BLE favorites for a Device Manager
	// Device: True	Get Type: None 	Set Type: String
	Favorite = 328193,

	// property to get the BLE Unique Device Identifier that can be used to set favorite with
	// Device: True	Get Type: String 	Set Type: NotApplicable
	UniqueDeviceIdentifier = 5308930,

	// property to transmit through PC/SC an array of bytes often called APDU
	// Device: True	Get Type: Array 	Set Type: Array
	PcScTagTransmit = 4456731,

	// property to control the PC/SC coupler device by passing an array of bytes often called APDU
	// Device: True	Get Type: Array 	Set Type: Array
	PcScCouplerControl = 4456732,


};

export enum Types {
	// for capture properties that don't have any value
	None = 0,

	// for capture properties that don't have a value for
	// either a get operation or a set operation or neither of
	// them.
	NotApplicable = 1,

	// the property has a byte value
	Byte = 2,

	// the property has a unsigned long value
	Ulong = 3,

	// the property has a byte array value
	Array = 4,

	// the property has a string value
	String = 5,

	// the property has a version structure as value (read only)
	Version = 6,

	// the property has a data source structure as value
	DataSource = 7,

	// the property has an enum value
	Enum = 8,

	// the property has an object as value
	Object = 9,

	// the property type should not be equal or higher that kLast otherwise
	// it means the SDK is not in sync with the actual version of Socket
	// Mobile Companion running on the host
	LastType = 10,


}

// Data Confirmation Mode indicates what is 
// expected to the send the Data ACK back to the scanner
export enum DataConfirmationMode {

	// use the device configuration (Local Confirmation or App)
	ModeOff = 0,
	// the device confirms the decoded data locally
	ModeDevice = 1,
	// Capture confirms the decoded data as it receives them and there is one app
	ModeCapture = 2,
	// the Application confirms the decoded data as it receives them
	ModeApp = 3
};

// Device Data Acknowledgment mode
export enum DeviceDataAcknowledgment {

	// the device won't locally acknowledge decoded data
	Off = 0,
	// the device will locally acknowledge decoded data
	On = 1
};

// Security Mode
export enum SecurityMode {

	// No security
	None = 0,
	// communication protected by authentication
	Authentication = 1,
	// communication protected by authentication and encrytion
	AuthenticationEncryption = 2
};

// trigger parameter
export enum Trigger {

	// start a read
	Start = 1,
	// stop a read
	Stop = 2,
	// enable the trigger
	Enable = 3,
	// disable the trigger
	Disable = 4,
	// start a read in continuous
	ContinuousScan = 5
};

// Delete the pairing of the device
export enum DeletePairing {

	// delete the current pairing
	Current = 0,
	// delete all the pairing of the device
	All = 1
};

// sound configuration for the a type of action
export enum SoundActionType {

	// sound configuration for a good read action
	GoodRead = 0,
	// sound configuration for a good read local action
	GoodReadLocal = 1,
	// sound configuration for a bad read action
	BadRead = 2,
	// sound configuration for a bad read local action
	BadReadLocal = 3
};

// Sound frequency configuration
export enum SoundFrequency {

	// no frequency
	None = 0,
	// Low pitch frequency
	Low = 1,
	// Medium pitch frequency
	Medium = 2,
	// High pitch frequency
	High = 3
};

// Rumble configuration for the a type of action
export enum RumbleActionType {

	// Rumble configuration for a good read action
	GoodRead = 0,
	// Rumble configuration for a good read local action
	GoodReadLocal = 1,
	// Rumble configuration for a bad read action
	BadRead = 2,
	// Rumble configuration for a bad read local action
	BadReadLocal = 3
};

// Define the action for a local decode
export enum LocalDecodeAction {

	// no action
	None = 0,
	// Beep when a local decode occurs
	Beep = 1,
	// Flash the LED when a local decode occurs
	Flash = 2,
	// Rumble when a local decode occurs
	Rumble = 4
};

// Define the LED for data confirmation
export enum DataConfirmationLed {

	// no LED
	None = 0,
	// make the LED flash in green
	Green = 1,
	// make the LED flash in red
	Red = 2
};

// Define the sound for data confirmation
export enum DataConfirmationBeep {

	// no sound
	None = 0,
	// short beep for success
	Good = 1,
	// long beep for failure
	Bad = 2
};

// Define the rumble for data confirmation
export enum DataConfirmationRumble {

	// no sound
	None = 0,
	// short rumble for success
	Good = 1,
	// long rumble for failure
	Bad = 2
};

// Define the flash setting
export enum Flash {

	// turn off the flash
	Off = 0,
	// turn on the flash
	On = 1
};

// Define the SocketCam experience (iOS-iPadOs only)
export enum SocketCam {

	// Enable SocketCam
	Enable = 0,
	// Disable SocketCam
	Disable = 1,
	// SocketCam is not supported, and cannot be enabled
	NotSupported = 2,
	// SocketCam is supported and can be enabled
	Supported = 2
};

// Define the possible power states
export enum PowerState {

	// The power state is unknown
	Unknown = 0,
	// The power state is on battery
	OnBattery = 1,
	// The power state is on cradle
	OnCradle = 2,
	// The power state in on AC
	OnAc = 4
};

// Define the monitor feature (DEBUG build only)
export enum MonitorDbg {

	// define the level for the debug traces
	Level = 1,
	// define the output channel for the debug traces
	Channel = 2,
	// define the number of lines in the file
	FileLineLevel = 3
};

// identifiers for the statistic counters
export enum Counter {

	// use for convenience only to skip a counter
	Skip = -1,
	// unknow counter
	Unknown = 0,
	// number of connections
	Connect = 1,
	// number of disconnections
	Disconnect = 2,
	// number of unbound operation
	Unbound = 3,
	// number of reset to factory default
	FactoryReset = 4,
	// number of reads (scans)
	Reads = 5,
	// number of trigger button released
	TriggerButtonUp = 6,
	// number of trigger button pressed
	TriggerButtonDown = 7,
	// number of power button released
	PowerButtonUp = 8,
	// number of power button pressed
	PowerButtonDown = 9,
	// number of minutes in AC power
	OnAcTimeInMinutes = 10,
	// number of minutes on battery
	OnBatTimeInMinutes = 11,
	// number of RFCOMM sent (SSI only)
	RfcommSend = 12,
	// number of RFCOMM received (SSI only)
	RfcommReceive = 13,
	// number of RFCOMM discarded (SSI only)
	RfcommReceiveDiscarded = 14,
	// number of UART sent (SSI only)
	UartSend = 15,
	// number of UART received (SSI only)
	UartReceive = 16,
	// number of UART discarded (SSI only)
	UartReceiveDiscarded = 17,
	// number of left button press (CRS only)
	ButtonLeftPress = 18,
	// number of left button release (CRS only)
	ButtonLeftRelease = 19,
	// number of right button press (CRS only)
	ButtonRightPress = 20,
	// number of right button release (CRS only)
	ButtonRightRelease = 21,
	// number of ring unit detach (CRS only)
	RingUnitDetach = 22,
	// number of ring unit attach (CRS only)
	RingUnitAttach = 23,
	// number of decoded bytes (7x only ISCI)
	DecodedBytes = 24,
	// number of abnormal shutdowns (7x only ISCI)
	AbnormalShutdowns = 25,
	// number of battery charge cycles (7x only ISCI)
	BatteryChargeCycles = 26,
	// number of battery charge count (7x only ISCI)
	BatteryChargeCount = 27,
	// number of power on (only 8Ci)
	PowerOn = 28,
	// number of power off (only 8Ci)
	PowerOff = 29,
	// number of stand mode change (only 7X/Q 7630 and higher)
	StandModeChange = 30
};

// Disconnect parameters to instruct the device what to do after disconnection
export enum Disconnect {

	// disconnect and then start the current profile
	StartProfile = 0,
	// Disconnect and disable radio (low power)
	DisableRadio = 1
};

// Select a profile for the device (None, SPP, HID)
export enum ProfileSelect {

	// The device is in acceptor mode, not trying to connect to any host
	None = 0,
	// The device is in App mode
	Spp = 1,
	// The device is in Basic mode, sometimes referred as Keyboard emulation
	Hid = 2
};

// Configure a profile for the device (None, Acceptor, Initiator)
export enum ProfileConfig {

	// The device is in either acceptor or initiator mode, meaning not even discoverable
	None = 0,
	// The device is discoverable and will accept any connection
	Acceptor = 1,
	// The device initiates a connection to the Bluetooth address specified in the Profile Configuration
	Initiator = 2
};

// Configuration masks for selecting the notifications the device should send to the host
export enum Notifications {

	// The device sends a notification when the trigger button is pressed
	TriggerButtonPress = 1,
	// The device sends a notification when the trigger button is released
	TriggerButtonRelease = 2,
	// The device sends a notification when the power button is pressed
	PowerButtonPress = 4,
	// The device sends a notification when the power button is released
	PowerButtonRelease = 8,
	// The device sends a notification when the power state changes (battery to AC or vice-versa) (not supported on all device)
	PowerState = 16,
	// The device sends a notification when the battery level changed (not supported on all device)
	BatteryLevelChange = 32
};

// Identifies the timers used in the device, (trigger lock, disconnected, connected)
export enum Timer {

	// The trigger button stays ineffective for the specified amount of time 
	// or until the device receives a data confirmation command.
	AutoLock = 1,
	// This timer specifies the amount of time the device stays on while it is not connected to any host.
	PowerOffDisconnected = 2,
	// This timer specifies the amount of time the device stays on while it is connected to a host.
	PowerOffConnected = 4
};

// Identifies the data format the device should send the data to the host
export enum DataFormat {

	// The device sends the data without any protocol overhead
	Raw = 0,
	// The device sends the data embedded in a protocol packet (default)
	Packet = 1,
	// The device sends only the RFID tag ID, (valid only for D600 NFC devices)
	IdOnly = 2,
	// The device sends the tag type and RFID tag ID, (valid only for D600 NFC devices)
	TagTypeAndId = 10,
	// The device sends only the tag data, (valid only for D600 NFC devices)
	DataOnly = 4,
	// The device sends the tag type and the tag data, (valid only for D600 NFC devices)
	TagTypeAndData = 12
};

// defines the operational mode of the device
export enum TriggerMode {

	// The device triggers a read only by pressing the trigger button
	LocalOnly = 1,
	// The device triggers a read by pressing the trigger button or by receiving the trigger command
	RemoteAndLocal = 2,
	// the device waits for the host to unlock the trigger
	AutoLock = 3,
	// the device locks and unlocks the trigger locally (default)
	NormalLock = 4,
	// The device triggers a read automatically without user intervention
	Presentation = 5
};

// defines the reason as of how the device connects to the host
export enum ConnectReason {

	// The device connects to the host from unknown reason
	Unknown = 0,
	// The device connects to the host just after power on
	PowerOn = 1,
	// The device connects to the host by reading the host address from a barcode
	Barcode = 2,
	// The device connects to the host by user action (usually a press on the trigger button)
	UserAction = 3,
	// The device connects to the host from a change of the host address in the profile configuration
	HostChange = 4,
	// The device connects to the host after a retry (device coming back to the radio range)
	Retry = 5
};

// The start up role SPP defines the start up role when using the SPP profile.
export enum StartUpRoleSpp {

	// The device returns to acceptor mode, not initiating a connection to a host.
	Acceptor = 0,
	// The device uses the last role configuration upon startup.
	LastRole = 1
};

// The connect beep configuration allows to turn off or on the connection beep when the scanner connects
export enum ConnectBeepConfig {

	// The device won't beep upon connection to a host.
	NoBeep = 0,
	// The device beeps when connecting to the host.
	Beep = 1
};

// The stand configuration defines the operational mode of the device when used with a stand.
export enum StandConfig {

	// Mobile mode Works like today existing firmware Engine is always in 
	//  trigger mode Engine hibernate enabled
	MobileMode = 0,
	// Stand mode Engine always in presentation mode Engine hibernate 
	// disabled Scanner turns on immediately Power timers disabled Connection 
	// retries forever
	StandMode = 1,
	// Detect mode On stand engine in presentation mode On stand engine 
	// hibernate disabled On stand charging led state not show On stand 
	// scanner turns on immediately On stand power timers disabled On stand 
	// connection retries forever Off stand engine in level mode Off stand 
	// battery led state reported Off stand engine hibernate enabled Off stand 
	// power off timers running Off stand connection retries halt after max 
	// count
	DetectMode = 2,
	// Auto mode On stand engine in presentation mode On stand engine hibernate 
	// disabled On stand charging led state not show On stand scanner turns on 
	// immediately On stand power timers disabled On stand connection retries 
	// forever Off stand does nothing, engine remains in presentation mode Off 
	// stand trigger press causes engine to enter level mode Engine in level 
	// mode battery led state reported Engine in level mode hibernate enabled 
	// Engine in level mode power off timers running Engine in level mode 
	// connection retries halt after max count
	AutoMode = 3
};

// The mask to apply for each button that is pressed
export enum ButtonPressMask {

	// The left button is pressed.
	Left = 1,
	// The right button is pressed.
	Right = 2,
	// The middle button is pressed.
	Middle = 4,
	// The power button is pressed.
	Power = 8,
	// The Ring is detached from the wrist unit.
	RingDetach = 16
};


