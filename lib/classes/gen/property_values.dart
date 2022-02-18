//property_values.dart
//This file is generated when calling npm run update
//

class GoodBadHelper {
  // no sound
  int none = 0;
  // short sound for success
  int good = 1;
  // long sound for failure
  int bad = 2;
}

class OnOffHelper {
  int off = 0;
  int on = 1;

  OnOffHelper();
}

// Data Confirmation Mode indicates what is
// expected to the send the Data ACK back to the scanner
class DataConfirmationMode {
  // use the device configuration (Local Confirmation or App)
  int modeOff = 0;
  // the device confirms the decoded data locally
  int modeDevice = 1;
  // Capture confirms the decoded data as it receives them and there is one app
  int modeCapture = 2;
  // the Application confirms the decoded data as it receives them
  int modeApp = 3;

  DataConfirmationMode();
}

// Device Data Acknowledgment mode
class DeviceDataAcknowledgment extends OnOffHelper {
  DeviceDataAcknowledgment();
}

// Security Mode
class SecurityMode {
  // No security
  int none = 0;
  // communication protected by authentication
  int authentication = 1;
  // communication protected by authentication and encrytion
  int authenticationEncryption = 2;

  SecurityMode();
}

// trigger parameter
class Trigger {
  // start a read
  int start = 1;
  // stop a read
  int stop = 2;
  // enable the trigger
  int enable = 3;
  // disable the trigger
  int disable = 4;
  // start a read in continuous
  int continuousScan = 5;

  Trigger();
}

// Delete the pairing of the device
class DeletePairing {
  // delete the current pairing
  int current = 0;
  // delete all the pairing of the device
  int all = 1;

  DeletePairing();
}

// sound configuration for the a type of action
class SoundActionType {
  // sound configuration for a good read action
  int goodRead = 0;
  // sound configuration for a good read local action
  int goodReadLocal = 1;
  // sound configuration for a bad read action
  int badRead = 2;
  // sound configuration for a bad read local action
  int badReadLocal = 3;

  SoundActionType();
}

// Sound frequency configuration
class SoundFrequency {
  // no frequency
  int none = 0;
  // Low pitch frequency
  int low = 1;
  // Medium pitch frequency
  int medium = 2;
  // High pitch frequency
  int high = 3;

  SoundFrequency();
}

// Rumble configuration for the a type of action
class RumbleActionType {
  // Rumble configuration for a good read action
  int goodRead = 0;
  // Rumble configuration for a good read local action
  int goodReadLocal = 1;
  // Rumble configuration for a bad read action
  int badRead = 2;
  // Rumble configuration for a bad read local action
  int badReadLocal = 3;

  RumbleActionType();
}

// Define the action for a local decode
class LocalDecodeAction {
  // no action
  int none = 0;
  // Beep when a local decode occurs
  int beep = 1;
  // Flash the LED when a local decode occurs
  int flash = 2;
  // Rumble when a local decode occurs
  int rumble = 4;

  LocalDecodeAction();
}

// Define the LED for data confirmation
class DataConfirmationLed {
  // no LED
  int none = 0;
  // make the LED flash in green
  int green = 1;
  // make the LED flash in red
  int red = 2;

  DataConfirmationLed();
}

// Define the sound for data confirmation
class DataConfirmationBeep extends GoodBadHelper {
  DataConfirmationBeep();
}

// Define the rumble for data confirmation
class DataConfirmationRumble extends GoodBadHelper {
  DataConfirmationRumble();
}

// Define the flash setting
class Flash extends OnOffHelper {
  Flash();
}

// Define the Softscan experience (iOS-iPadOs only)
class SoftScan {
  // Enable SoftScan
  int enable = 0;
  // Disable SoftScan
  int disable = 1;
  // SoftScan is not supported; and cannot be enabled
  int notSupported = 2;
  // SoftScan is supported and can be enabled
  int supported = 2;

  SoftScan();
}

// Define the possible power states
class PowerState {
  // The power state is unknown
  int unknown = 0;
  // The power state is on battery
  int onBattery = 1;
  // The power state is on cradle
  int onCradle = 2;
  // The power state in on AC
  int onAc = 4;

  PowerState();
}

// Define the monitor feature (DEBUG build only)
class MonitorDbg {
  // define the level for the debug traces
  int level = 1;
  // define the output channel for the debug traces
  int channel = 2;
  // define the number of lines in the file
  int fileLineLevel = 3;

  MonitorDbg();
}

// identifiers for the statistic counters
class Counter {
  // use for convenience only to skip a counter
  int skip = -1;
  // unknow counter
  int unknown = 0;
  // number of connections
  int connect = 1;
  // number of disconnections
  int disconnect = 2;
  // number of unbound operation
  int unbound = 3;
  // number of reset to factory default
  int factoryReset = 4;
  // number of reads (scans)
  int reads = 5;
  // number of trigger button released
  int triggerButtonUp = 6;
  // number of trigger button pressed
  int triggerButtonDown = 7;
  // number of power button released
  int powerButtonUp = 8;
  // number of power button pressed
  int powerButtonDown = 9;
  // number of minutes in AC power
  int onAcTimeInMinutes = 10;
  // number of minutes on battery
  int onBatTimeInMinutes = 11;
  // number of RFCOMM sent (SSI only)
  int rfcommSend = 12;
  // number of RFCOMM received (SSI only)
  int rfcommReceive = 13;
  // number of RFCOMM discarded (SSI only)
  int rfcommReceiveDiscarded = 14;
  // number of UART sent (SSI only)
  int uartSend = 15;
  // number of UART received (SSI only)
  int uartReceive = 16;
  // number of UART discarded (SSI only)
  int uartReceiveDiscarded = 17;
  // number of left button press (CRS only)
  int buttonLeftPress = 18;
  // number of left button release (CRS only)
  int buttonLeftRelease = 19;
  // number of right button press (CRS only)
  int buttonRightPress = 20;
  // number of right button release (CRS only)
  int buttonRightRelease = 21;
  // number of ring unit detach (CRS only)
  int ringUnitDetach = 22;
  // number of ring unit attach (CRS only)
  int ringUnitAttach = 23;
  // number of decoded bytes (7x only ISCI)
  int decodedBytes = 24;
  // number of abnormal shutdowns (7x only ISCI)
  int abnormalShutdowns = 25;
  // number of battery charge cycles (7x only ISCI)
  int batteryChargeCycles = 26;
  // number of battery charge count (7x only ISCI)
  int batteryChargeCount = 27;
  // number of power on (only 8Ci)
  int powerOn = 28;
  // number of power off (only 8Ci)
  int powerOff = 29;
  // number of stand mode change (only 7X/Q 7630 and higher)
  int standModeChange = 30;

  Counter();
}

// Disconnect parameters to instruct the device what to do after disconnection
class Disconnect {
  // disconnect and then start the current profile
  int startProfile = 0;
  // Disconnect and disable radio (low power)
  int disableRadio = 1;

  Disconnect();
}

// Select a profile for the device (None; SPP; HID)
class ProfileSelect {
  // The device is in acceptor mode; not trying to connect to any host
  int none = 0;
  // The device is in App mode
  int spp = 1;
  // The device is in Basic mode; sometimes referred as Keyboard emulation
  int hid = 2;

  ProfileSelect();
}

// Configure a profile for the device (None; Acceptor; Initiator)
class ProfileConfig {
  // The device is in either acceptor or initiator mode; meaning not even discoverable
  int none = 0;
  // The device is discoverable and will accept any connection
  int acceptor = 1;
  // The device initiates a connection to the Bluetooth address specified in the Profile Configuration
  int initiator = 2;

  ProfileConfig();
}

// Configuration masks for selecting the notifications the device should send to the host
class Notifications {
  // The device sends a notification when the trigger button is pressed
  int triggerButtonPress = 1;
  // The device sends a notification when the trigger button is released
  int triggerButtonRelease = 2;
  // The device sends a notification when the power button is pressed
  int powerButtonPress = 4;
  // The device sends a notification when the power button is released
  int powerButtonRelease = 8;
  // The device sends a notification when the power state changes (battery to AC or vice-versa) (not supported on all device)
  int powerState = 16;
  // The device sends a notification when the battery level changed (not supported on all device)
  int batteryLevelChange = 32;

  Notifications();
}

// Identifies the timers used in the device; (trigger lock; disconnected; connected)
class Timer {
  // The trigger button stays ineffective for the specified amount of time
  // or until the device receives a data confirmation command.
  int autoLock = 1;
  // This timer specifies the amount of time the device stays on while it is not connected to any host.
  int powerOffDisconnected = 2;
  // This timer specifies the amount of time the device stays on while it is connected to a host.
  int powerOffConnected = 4;

  Timer();
}

// Identifies the data format the device should send the data to the host
class DataFormat {
  // The device sends the data without any protocol overhead
  int raw = 0;
  // The device sends the data embedded in a protocol packet (default)
  int packet = 1;
  // The device sends only the RFID tag ID; (valid only for D600 NFC devices)
  int idOnly = 2;
  // The device sends the tag type and RFID tag ID; (valid only for D600 NFC devices)
  int tagTypeAndId = 10;
  // The device sends only the tag data; (valid only for D600 NFC devices)
  int dataOnly = 4;
  // The device sends the tag type and the tag data; (valid only for D600 NFC devices)
  int tagTypeAndData = 12;

  DataFormat();
}

// defines the operational mode of the device
class TriggerMode {
  // The device triggers a read only by pressing the trigger button
  int localOnly = 1;
  // The device triggers a read by pressing the trigger button or by receiving the trigger command
  int remoteAndLocal = 2;
  // the device waits for the host to unlock the trigger
  int autoLock = 3;
  // the device locks and unlocks the trigger locally (default)
  int normalLock = 4;
  // The device triggers a read automatically without user intervention
  int presentation = 5;

  TriggerMode();
}

// defines the reason as of how the device connects to the host
class ConnectReason {
  // The device connects to the host from unknown reason
  int unknown = 0;
  // The device connects to the host just after power on
  int powerOn = 1;
  // The device connects to the host by reading the host address from a barcode
  int barcode = 2;
  // The device connects to the host by user action (usually a press on the trigger button)
  int userAction = 3;
  // The device connects to the host from a change of the host address in the profile configuration
  int hostChange = 4;
  // The device connects to the host after a retry (device coming back to the radio range)
  int retry = 5;

  ConnectReason();
}

// The start up role SPP defines the start up role when using the SPP profile.
class StartUpRoleSpp {
  // The device returns to acceptor mode; not initiating a connection to a host.
  int acceptor = 0;
  // The device uses the last role configuration upon startup.
  int lastRole = 1;

  StartUpRoleSpp();
}

// The connect beep configuration allows to turn off or on the connection beep when the scanner connects
class ConnectBeepConfig {
  // The device won't beep upon connection to a host.
  int noBeep = 0;
  // The device beeps when connecting to the host.
  int beep = 1;

  ConnectBeepConfig();
}

// The stand configuration defines the operational mode of the device when used with a stand.
class StandConfig {
  // Mobile mode Works like today existing firmware Engine is always in
  //  trigger mode Engine hibernate enabled
  int mobileMode = 0;
  // Stand mode Engine always in presentation mode Engine hibernate
  // disabled Scanner turns on immediately Power timers disabled Connection
  // retries forever
  int standMode = 1;
  // Detect mode On stand engine in presentation mode On stand engine
  // hibernate disabled On stand charging led state not show On stand
  // scanner turns on immediately On stand power timers disabled On stand
  // connection retries forever Off stand engine in level mode Off stand
  // battery led state reported Off stand engine hibernate enabled Off stand
  // power off timers running Off stand connection retries halt after max
  // count
  int detectMode = 2;
  // Auto mode On stand engine in presentation mode On stand engine hibernate
  // disabled On stand charging led state not show On stand scanner turns on
  // immediately On stand power timers disabled On stand connection retries
  // forever Off stand does nothing; engine remains in presentation mode Off
  // stand trigger press causes engine to enter level mode Engine in level
  // mode battery led state reported Engine in level mode hibernate enabled
  // Engine in level mode power off timers running Engine in level mode
  // connection retries halt after max count
  int autoMode = 3;

  StandConfig();
}

// The mask to apply for each button that is pressed
class ButtonPressMask {
  // The left button is pressed.
  int left = 1;
  // The right button is pressed.
  int right = 2;
  // The middle button is pressed.
  int middle = 4;
  // The power button is pressed.
  int power = 8;
  // The Ring is detached from the wrist unit.
  int ringDetach = 16;

  ButtonPressMask();
}
