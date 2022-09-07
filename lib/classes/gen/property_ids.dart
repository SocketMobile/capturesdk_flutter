// This is an property IDs template file for the properties definition
// 2022 © Socket Mobile, Inc. all rights reserved


/// Ids associated with different properties in capture events.
class CapturePropertyIds {

	/// Set to notify Capture that the client is shutting down gracefully.
	/// Capture will send device removal events followed by a terminate
	/// event. Once you receive the terminate event, it is safe to shut
	/// down Capture.
	/// Device: False	Get Type: NotApplicable 	Set Type: None
	static const int abort = -2146435072;

	/// Gets the Capture service version.
	/// Device: False	Get Type: None 	Set Type: NotApplicable
	static const int version = -2147418111;

	/// Gets the version of the firmware interface that Capture service
	/// supports. This can be useful for determining if the Capture service
	/// supports a particular hardware feature.
	/// Device: False	Get Type: None 	Set Type: NotApplicable
	static const int interfaceVersion = -2147418112;

	/// property to set or get the Capture configuration
	/// Device: False	Get Type: String 	Set Type: String
	static const int configuration = -2141913085;

	/// Gets or sets the data confirmation mode. The data confirmation mode
	/// determines who acknowledges whether the data received was good or
	/// bad.
	/// Device: False	Get Type: None 	Set Type: Byte
	static const int dataConfirmationMode = -2147352572;

	/// Gets or sets the data confirmation action. Data confirmation action
	/// determines how good or bad data is acknowledged.
	/// Device: False	Get Type: None 	Set Type: Ulong
	static const int dataConfirmationAction = -2147287035;

	/// Gets or sets the log level of various Capture service components
	/// (Only works on debug builds of the service).
	/// Device: False	Get Type: Byte 	Set Type: Array
	static const int monitorMode = -2145124346;

	/// property to get or set the SocketCam status
	/// (iOS only)
	/// Device: False	Get Type: None 	Set Type: Byte
	static const int socketCamStatus = -2147352569;

	/// Gets the firmware version of the device
	/// Device: True	Get Type: None 	Set Type: NotApplicable
	static const int versionDevice = 65536;

	/// Gets the model of the device
	/// Device: True	Get Type: None 	Set Type: NotApplicable
	static const int deviceType = 65538;

	/// Sends an arbitrary get or set command to the device
	/// Device: True	Get Type: Array 	Set Type: Array
	static const int deviceSpecific = 4456451;

	/// property to get or set the data source status / information
	/// Device: True	Get Type: DataSource 	Set Type: DataSource
	static const int dataSourceDevice = 7798788;

	/// Sets the trigger of the device - can start or stop a read and
	/// enable or disable the physical trigger button on the device.
	/// Device: True	Get Type: NotApplicable 	Set Type: Byte
	static const int triggerDevice = 1179653;

	/// property to apply a config to a Capture Device (not yet enabled)
	/// Device: True	Get Type: NotApplicable 	Set Type: None
	static const int applyConfigDevice = 1048582;

	/// Gets or sets a preamble for data decoded by the device. When set,
	/// the preamble is added in front of the decoded data.
	/// Device: True	Get Type: None 	Set Type: String
	static const int preambleDevice = 327687;

	/// Gets or sets a postamble for data decoded by the device. When set,
	/// the postamble is added to the end of the decoded data.
	/// Device: True	Get Type: None 	Set Type: String
	static const int postambleDevice = 327688;

	/// property to get the Capture Device capabilities
	/// Device: True	Get Type: Byte 	Set Type: NotApplicable
	static const int capabilitiesDevice = 2162697;

	/// Gets the change id of the device. The change id is a checksum of
	/// all the engine settings - e.g. symbology settings, preamble,
	/// postamble, etc - and can be used to determine if the device
	/// configuration has been altered by another application or using a
	/// command barcode.
	/// Device: True	Get Type: None 	Set Type: NotApplicable
	static const int changeIdDevice = 65546;

	/// property to get or set the Decoded Data Format of a Capture Device
	/// Device: True	Get Type: None 	Set Type: Byte
	static const int dataFormatDevice = 131083;

	/// Gets or sets the friendly name of the device. The friendly name is
	/// the name that appears in Bluetooth settings.
	/// Device: True	Get Type: None 	Set Type: String
	static const int friendlyNameDevice = 327936;

	/// property to get or set the Capture Device Security Mode
	/// Device: True	Get Type: None 	Set Type: Byte
	static const int securityModeDevice = 131329;

	/// property to get or set the Capture Device PIN code
	/// Device: True	Get Type: NotApplicable 	Set Type: String
	static const int pinCodeDevice = 1376514;

	/// Set deletes pairing and bonding information off the device. Useful
	/// when preparing to pair the Capture device to a different host.
	/// Device: True	Get Type: NotApplicable 	Set Type: Byte
	static const int deletePairingBondingDevice = 1179907;

	/// Set resets all the settings on the device to their default values.
	/// Device: True	Get Type: NotApplicable 	Set Type: None
	static const int restoreFactoryDefaultsDevice = 1048836;

	/// Set turns the device off
	/// Device: True	Get Type: NotApplicable 	Set Type: None
	static const int setPowerOffDevice = 1048837;

	/// Gets the current state of each button on the device. Consider using
	/// kNotificationsDevice to subscribe to button events instead.
	/// Device: True	Get Type: None 	Set Type: NotApplicable
	static const int buttonsStatusDevice = 65798;

	/// Gets or sets the sound configuration of the device. There are
	/// separate sound configurations for when a good scan is acknowledged
	/// locally (by the Capture device) and when it is acknowledged by the
	/// host. The same applies to the bad scan sound configuration.
	/// Device: True	Get Type: Byte 	Set Type: Array
	static const int soundConfigDevice = 2359559;

	/// Gets or sets the trigger lock and auto-off timers. The trigger lock
	/// determines how long the trigger remains locked after decoding data
	/// without receiving confirmation. There are two auto-off timers, one
	/// for when the device is connected to a host and one for when it is
	/// not.
	/// Device: True	Get Type: None 	Set Type: Array
	static const int timersDevice = 262408;

	/// Gets or sets local device acknowledgement. When enabled, the device
	/// acknowledges decoded data as soon as it is decoded. When disabled,
	/// the device waits for the host to acknowledge decoded data and the
	/// trigger will be locked until acknowledgement is received or the
	/// trigger lock timeout has elapsed.
	/// Device: True	Get Type: None 	Set Type: Byte
	static const int localAcknowledgmentDevice = 131337;

	/// Sends an acknowledgement to the device. Acknowledgement can either
	/// be positive or negative - a.k.a. good scan or bad scan.
	/// Device: True	Get Type: NotApplicable 	Set Type: Ulong
	static const int dataConfirmationDevice = 1245450;

	/// Gets the current battery level of the device. Consider using 
	/// kNotificationsDevice to subscribe to battery level change events
	/// instead.
	/// Device: True	Get Type: None 	Set Type: NotApplicable
	static const int batteryLevelDevice = 65803;

	/// Gets or sets the local decode action of the device. Determines how
	/// decoded data is acknowledged - i.e. with a beep, rumble, flash or
	/// some combination of all three.
	/// Device: True	Get Type: None 	Set Type: Byte
	static const int localDecodeActionDevice = 131340;

	/// Gets the Bluetooth address of the device
	/// Device: True	Get Type: None 	Set Type: NotApplicable
	static const int bluetoothAddressDevice = 65805;

	/// Gets the statistics counters of the device. Counters record the
	/// absolute number of times a particular event has occurred.
	/// Device: True	Get Type: None 	Set Type: NotApplicable
	static const int statisticCountersDevice = 65806;

	/// Gets or sets the rumble configuration of the device. There are
	/// separate rumble configurations for when a good scan is acknowledged
	/// locally (by the Capture device) and when it is acknowledged by the
	/// host. The same applies to the bad scan rumble configuration.
	/// Device: True	Get Type: Byte 	Set Type: Array
	static const int rumbleConfigDevice = 2359567;

	/// property to get or set the Capture Device Profile Configuration
	/// Device: True	Get Type: None 	Set Type: Array
	static const int profileConfigDevice = 262416;

	/// Instructs the device to drop its connection. Note: After sending
	/// this command, the host will be unable to send any subsequent
	/// commands to this device.
	/// Device: True	Get Type: NotApplicable 	Set Type: Byte
	static const int disconnectDevice = 1179921;

	/// Gets or sets arbitrary bytes to store on the device. The device has
	/// 16 storage locations which can hold up to 64 bytes each.
	/// Device: True	Get Type: Array 	Set Type: Array
	static const int dataStoreDevice = 4456722;

	/// Gets or sets subscriptions to various events from the device.
	/// Events that can be subscribed to include, trigger press/release,
	/// power button press/release, power state and battery level change.
	/// Device: True	Get Type: None 	Set Type: Ulong
	static const int notificationsDevice = 196883;

	/// property to get the Capture Device Connect reason
	/// Device: True	Get Type: None 	Set Type: NotApplicable
	static const int connectReasonDevice = 65812;

	/// Gets the current power state of the device. Consider using
	/// kNotificationsDevice to subscribe to power state events instead.
	/// Device: True	Get Type: None 	Set Type: NotApplicable
	static const int powerStateDevice = 65813;

	/// Gets or sets the reconnect behavior of the device when it is
	/// powered on in application mode. By default, the device will attempt
	/// to reconnect to the last host, but this feature can be turned off
	/// using this property.
	/// Device: True	Get Type: None 	Set Type: Byte
	static const int startUpRoleSPPDevice = 131350;

	/// property to get or set the Capture Device Connection Beep
	/// Configuration.
	/// Device: True	Get Type: None 	Set Type: Byte
	static const int connectionBeepConfigDevice = 131351;

	/// Gets or sets the status of the flash on the SocketCam device.
	/// Device: True	Get Type: None 	Set Type: Byte
	static const int flashDevice = 131352;

	/// property to get or set the Capture Device Overlay View (SocketCam
	/// only)
	/// Device: True	Get Type: None 	Set Type: Object
	static const int overlayViewDevice = 590105;

	/// property to get or set the Capture Device Stand Configuration
	/// Device: True	Get Type: None 	Set Type: Ulong
	static const int standConfigDevice = 196890;

	/// property to start a BLE discovery from a Device Manager
	/// Device: True	Get Type: NotApplicable 	Set Type: Ulong
	static const int startDiscovery = 1245696;

	/// property to set or get the BLE favorites for a Device Manager
	/// Device: True	Get Type: None 	Set Type: String
	static const int favorite = 328193;

	/// property to get the BLE Unique Device Identifier that can be used to set favorite with
	/// Device: True	Get Type: String 	Set Type: NotApplicable
	static const int uniqueDeviceIdentifier = 5308930;

	/// property to transmit through PC/SC an array of bytes often called APDU
	/// Device: True	Get Type: Array 	Set Type: Array
	static const int pcScTagTransmit = 4456731;

	/// property to control the PC/SC coupler device by passing an array of bytes often called APDU
	/// Device: True	Get Type: Array 	Set Type: Array
	static const int pcScCouplerControl = 4456732;

}

class CapturePropertyTypes { 

	/// for capture properties that don't have any value
	static const int none = 0;

	/// for capture properties that don't have a value for
	/// either a get operation or a set operation or neither of
	/// them.
	static const int notApplicable = 1;

	/// the property has a byte value
	static const int byte = 2;

	/// the property has a unsigned long value
	static const int ulong = 3;

	/// the property has a byte array value
	static const int array = 4;

	/// the property has a string value
	static const int string = 5;

	/// the property has a version structure as value (read only)
	static const int version = 6;

	/// the property has a data source structure as value
	static const int dataSource = 7;

	/// the property has an enum value
	static const int Enum = 8;

	/// the property has an object as value
	static const int object = 9;

	/// the property type should not be equal or higher that kLast otherwise
	/// it means the SDK is not in sync with the actual version of Socket
	/// Mobile Companion running on the host
	static const int lastType = 10;

}

/// Data Confirmation Mode indicates what is 
/// expected to the send the Data ACK back to the scanner
class DataConfirmationMode {

	/// use the device configuration (Local Confirmation or App)
	static const int modeOff = 0;
	/// the device confirms the decoded data locally
	static const int modeDevice = 1;
	/// Capture confirms the decoded data as it receives them and there is one app
	static const int modeCapture = 2;
	/// the Application confirms the decoded data as it receives them
	static const int modeApp = 3;

}

/// Device Data Acknowledgment mode
class DeviceDataAcknowledgment {

	/// the device won't locally acknowledge decoded data
	static const int off = 0;
	/// the device will locally acknowledge decoded data
	static const int on = 1;

}

/// Security Mode
class SecurityMode {

	/// No security
	static const int none = 0;
	/// communication protected by authentication
	static const int authentication = 1;
	/// communication protected by authentication and encrytion
	static const int authenticationEncryption = 2;

}

/// trigger parameter
class Trigger {

	/// start a read
	static const int start = 1;
	/// stop a read
	static const int stop = 2;
	/// enable the trigger
	static const int enable = 3;
	/// disable the trigger
	static const int disable = 4;
	/// start a read in continuous
	static const int continuousScan = 5;

}

/// Delete the pairing of the device
class DeletePairing {

	/// delete the current pairing
	static const int current = 0;
	/// delete all the pairing of the device
	static const int all = 1;

}

/// sound configuration for the a type of action
class SoundActionType {

	/// sound configuration for a good read action
	static const int goodRead = 0;
	/// sound configuration for a good read local action
	static const int goodReadLocal = 1;
	/// sound configuration for a bad read action
	static const int badRead = 2;
	/// sound configuration for a bad read local action
	static const int badReadLocal = 3;

}

/// Sound frequency configuration
class SoundFrequency {

	/// no frequency
	static const int none = 0;
	/// Low pitch frequency
	static const int low = 1;
	/// Medium pitch frequency
	static const int medium = 2;
	/// High pitch frequency
	static const int high = 3;

}

/// Rumble configuration for the a type of action
class RumbleActionType {

	/// Rumble configuration for a good read action
	static const int goodRead = 0;
	/// Rumble configuration for a good read local action
	static const int goodReadLocal = 1;
	/// Rumble configuration for a bad read action
	static const int badRead = 2;
	/// Rumble configuration for a bad read local action
	static const int badReadLocal = 3;

}

/// Define the action for a local decode
class LocalDecodeAction {

	/// no action
	static const int none = 0;
	/// Beep when a local decode occurs
	static const int beep = 1;
	/// Flash the LED when a local decode occurs
	static const int flash = 2;
	/// Rumble when a local decode occurs
	static const int rumble = 4;

}

/// Define the LED for data confirmation
class DataConfirmationLed {

	/// no LED
	static const int none = 0;
	/// make the LED flash in green
	static const int green = 1;
	/// make the LED flash in red
	static const int red = 2;

}

/// Define the sound for data confirmation
class DataConfirmationBeep {

	/// no sound
	static const int none = 0;
	/// short beep for success
	static const int good = 1;
	/// long beep for failure
	static const int bad = 2;

}

/// Define the rumble for data confirmation
class DataConfirmationRumble {

	/// no sound
	static const int none = 0;
	/// short rumble for success
	static const int good = 1;
	/// long rumble for failure
	static const int bad = 2;

}

/// Define the flash setting
class Flash {

	/// turn off the flash
	static const int off = 0;
	/// turn on the flash
	static const int on = 1;

}

/// Define the SocketCam experience (iOS-iPadOs only)
class SocketCam {

	/// Enable SocketCam
	static const int enable = 0;
	/// Disable SocketCam
	static const int disable = 1;
	/// SocketCam is not supported, and cannot be enabled
	static const int notSupported = 2;
	/// SocketCam is supported and can be enabled
	static const int supported = 2;

}

/// Define the possible power states
class PowerState {

	/// The power state is unknown
	static const int unknown = 0;
	/// The power state is on battery
	static const int onBattery = 1;
	/// The power state is on cradle
	static const int onCradle = 2;
	/// The power state in on AC
	static const int onAc = 4;

}

/// Define the monitor feature (DEBUG build only)
class MonitorDbg {

	/// define the level for the debug traces
	static const int level = 1;
	/// define the output channel for the debug traces
	static const int channel = 2;
	/// define the number of lines in the file
	static const int fileLineLevel = 3;

}

/// identifiers for the statistic counters
class Counter {

	/// use for convenience only to skip a counter
	static const int skip = -1;
	/// unknow counter
	static const int unknown = 0;
	/// number of connections
	static const int connect = 1;
	/// number of disconnections
	static const int disconnect = 2;
	/// number of unbound operation
	static const int unbound = 3;
	/// number of reset to factory default
	static const int factoryReset = 4;
	/// number of reads (scans)
	static const int reads = 5;
	/// number of trigger button released
	static const int triggerButtonUp = 6;
	/// number of trigger button pressed
	static const int triggerButtonDown = 7;
	/// number of power button released
	static const int powerButtonUp = 8;
	/// number of power button pressed
	static const int powerButtonDown = 9;
	/// number of minutes in AC power
	static const int onAcTimeInMinutes = 10;
	/// number of minutes on battery
	static const int onBatTimeInMinutes = 11;
	/// number of RFCOMM sent (SSI only)
	static const int rfcommSend = 12;
	/// number of RFCOMM received (SSI only)
	static const int rfcommReceive = 13;
	/// number of RFCOMM discarded (SSI only)
	static const int rfcommReceiveDiscarded = 14;
	/// number of UART sent (SSI only)
	static const int uartSend = 15;
	/// number of UART received (SSI only)
	static const int uartReceive = 16;
	/// number of UART discarded (SSI only)
	static const int uartReceiveDiscarded = 17;
	/// number of left button press (CRS only)
	static const int buttonLeftPress = 18;
	/// number of left button release (CRS only)
	static const int buttonLeftRelease = 19;
	/// number of right button press (CRS only)
	static const int buttonRightPress = 20;
	/// number of right button release (CRS only)
	static const int buttonRightRelease = 21;
	/// number of ring unit detach (CRS only)
	static const int ringUnitDetach = 22;
	/// number of ring unit attach (CRS only)
	static const int ringUnitAttach = 23;
	/// number of decoded bytes (7x only ISCI)
	static const int decodedBytes = 24;
	/// number of abnormal shutdowns (7x only ISCI)
	static const int abnormalShutdowns = 25;
	/// number of battery charge cycles (7x only ISCI)
	static const int batteryChargeCycles = 26;
	/// number of battery charge count (7x only ISCI)
	static const int batteryChargeCount = 27;
	/// number of power on (only 8Ci)
	static const int powerOn = 28;
	/// number of power off (only 8Ci)
	static const int powerOff = 29;
	/// number of stand mode change (only 7X/Q 7630 and higher)
	static const int standModeChange = 30;

}

/// Disconnect parameters to instruct the device what to do after disconnection
class Disconnect {

	/// disconnect and then start the current profile
	static const int startProfile = 0;
	/// Disconnect and disable radio (low power)
	static const int disableRadio = 1;
	/// Disconnect a device and make it available for a new connection (for Bluetooth Low Energy device)
	static const int makeAvailable = 2;

}

/// Select a profile for the device (None, SPP, HID)
class ProfileSelect {

	/// The device is in acceptor mode, not trying to connect to any host
	static const int none = 0;
	/// The device is in App mode
	static const int spp = 1;
	/// The device is in Basic mode, sometimes referred as Keyboard emulation
	static const int hid = 2;

}

/// Configure a profile for the device (None, Acceptor, Initiator)
class ProfileConfig {

	/// The device is in either acceptor or initiator mode, meaning not even discoverable
	static const int none = 0;
	/// The device is discoverable and will accept any connection
	static const int acceptor = 1;
	/// The device initiates a connection to the Bluetooth address specified in the Profile Configuration
	static const int initiator = 2;

}

/// Configuration masks for selecting the notifications the device should send to the host
class Notifications {

	/// The device sends a notification when the trigger button is pressed
	static const int triggerButtonPress = 1;
	/// The device sends a notification when the trigger button is released
	static const int triggerButtonRelease = 2;
	/// The device sends a notification when the power button is pressed
	static const int powerButtonPress = 4;
	/// The device sends a notification when the power button is released
	static const int powerButtonRelease = 8;
	/// The device sends a notification when the power state changes (battery to AC or vice-versa) (not supported on all device)
	static const int powerState = 16;
	/// The device sends a notification when the battery level changed (not supported on all device)
	static const int batteryLevelChange = 32;

}

/// Identifies the timers used in the device, (trigger lock, disconnected, connected)
class Timer {

	/// The trigger button stays ineffective for the specified amount of time 
	/// or until the device receives a data confirmation command.
	static const int autoLock = 1;
	/// This timer specifies the amount of time the device stays on while it is not connected to any host.
	static const int powerOffDisconnected = 2;
	/// This timer specifies the amount of time the device stays on while it is connected to a host.
	static const int powerOffConnected = 4;

}

/// Identifies the data format the device should send the data to the host
class DataFormat {

	/// The device sends the data without any protocol overhead
	static const int raw = 0;
	/// The device sends the data embedded in a protocol packet (default)
	static const int packet = 1;
	/// The device sends only the RFID tag ID, (valid only for D600 NFC devices)
	static const int idOnly = 2;
	/// The device sends the tag type and RFID tag ID, (valid only for D600 NFC devices)
	static const int tagTypeAndId = 10;
	/// The device sends only the tag data, (valid only for D600 NFC devices)
	static const int dataOnly = 4;
	/// The device sends the tag type and the tag data, (valid only for D600 NFC devices)
	static const int tagTypeAndData = 12;

}

/// defines the operational mode of the device
class TriggerMode {

	/// The device triggers a read only by pressing the trigger button
	static const int localOnly = 1;
	/// The device triggers a read by pressing the trigger button or by receiving the trigger command
	static const int remoteAndLocal = 2;
	/// the device waits for the host to unlock the trigger
	static const int autoLock = 3;
	/// the device locks and unlocks the trigger locally (default)
	static const int normalLock = 4;
	/// The device triggers a read automatically without user intervention
	static const int presentation = 5;

}

/// defines the reason as of how the device connects to the host
class ConnectReason {

	/// The device connects to the host from unknown reason
	static const int unknown = 0;
	/// The device connects to the host just after power on
	static const int powerOn = 1;
	/// The device connects to the host by reading the host address from a barcode
	static const int barcode = 2;
	/// The device connects to the host by user action (usually a press on the trigger button)
	static const int userAction = 3;
	/// The device connects to the host from a change of the host address in the profile configuration
	static const int hostChange = 4;
	/// The device connects to the host after a retry (device coming back to the radio range)
	static const int retry = 5;

}

/// The start up role SPP defines the start up role when using the SPP profile.
class StartUpRoleSpp {

	/// The device returns to acceptor mode, not initiating a connection to a host.
	static const int acceptor = 0;
	/// The device uses the last role configuration upon startup.
	static const int lastRole = 1;

}

/// The connect beep configuration allows to turn off or on the connection beep when the scanner connects
class ConnectBeepConfig {

	/// The device won't beep upon connection to a host.
	static const int noBeep = 0;
	/// The device beeps when connecting to the host.
	static const int beep = 1;

}

/// The stand configuration defines the operational mode of the device when used with a stand.
class StandConfig {

	/// Mobile mode Works like today existing firmware Engine is always in 
	///  trigger mode Engine hibernate enabled
	static const int mobileMode = 0;
	/// Stand mode Engine always in presentation mode Engine hibernate 
	/// disabled Scanner turns on immediately Power timers disabled Connection 
	/// retries forever
	static const int standMode = 1;
	/// Detect mode On stand engine in presentation mode On stand engine 
	/// hibernate disabled On stand charging led state not show On stand 
	/// scanner turns on immediately On stand power timers disabled On stand 
	/// connection retries forever Off stand engine in level mode Off stand 
	/// battery led state reported Off stand engine hibernate enabled Off stand 
	/// power off timers running Off stand connection retries halt after max 
	/// count
	static const int detectMode = 2;
	/// Auto mode On stand engine in presentation mode On stand engine hibernate 
	/// disabled On stand charging led state not show On stand scanner turns on 
	/// immediately On stand power timers disabled On stand connection retries 
	/// forever Off stand does nothing, engine remains in presentation mode Off 
	/// stand trigger press causes engine to enter level mode Engine in level 
	/// mode battery led state reported Engine in level mode hibernate enabled 
	/// Engine in level mode power off timers running Engine in level mode 
	/// connection retries halt after max count
	static const int autoMode = 3;

}

/// The mask to apply for each button that is pressed
class ButtonPressMask {

	/// The left button is pressed.
	static const int left = 1;
	/// The right button is pressed.
	static const int right = 2;
	/// The middle button is pressed.
	static const int middle = 4;
	/// The power button is pressed.
	static const int power = 8;
	/// The Ring is detached from the wrist unit.
	static const int ringDetach = 16;

}


