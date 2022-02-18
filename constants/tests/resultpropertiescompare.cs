/**
  This is an property IDs template file for the properties definition

  2017 © Socket Mobile, Inc. all rights reserved
*/


/// <summary>
/// defines the property value type. Properties can have value of different
/// type or no value at all.
/// </summary>
public class Types {
	/// <summary>
	/// for capture properties that don't have any value
	/// </summary>
	public const int kNone=0;

	/// <summary>
	/// for capture properties that don't have a value for
	/// either a get operation or a set operation or neither of
	/// them.
	/// </summary>
	public const int kNotApplicable=1;

	/// <summary>
	/// the property has a byte value
	/// </summary>
	public const int kByte=2;

	/// <summary>
	/// the property has a unsigned long value
	/// </summary>
	public const int kUlong=3;

	/// <summary>
	/// the property has a byte array value
	/// </summary>
	public const int kArray=4;

	/// <summary>
	/// the property has a string value
	/// </summary>
	public const int kString=5;

	/// <summary>
	/// the property has a version structure as value (read only)
	/// </summary>
	public const int kVersion=6;

	/// <summary>
	/// the property has a data source structure as value
	/// </summary>
	public const int kDataSource=7;

	/// <summary>
	/// the property has an enum value
	/// </summary>
	public const int kEnum=8;

	/// <summary>
	/// the property has an object as value
	/// </summary>
	public const int kObject=9;

	/// <summary>
	/// the property type should not be equal or higher that kLast otherwise
	/// it means the SDK is not in sync with the actual version of Socket
	/// Mobile Companion running on the host
	/// </summary>
	public const int kLastType=10;

};

internal class GroupId
{
	public const int kSktCaptureGroupGeneral = 0;
	public const int kSktCaptureGroupLocalFunctions = 1;
	public const int kSktCaptureGroupManagerFunctions = 2;
};

internal class CaptureGroup
{
	public const int kSktCaptureIdAbort = 0;
	public const int kSktCaptureIdVersion = 1;
	public const int kSktCaptureIdInterfaceVersion = 2;
	public const int kSktCaptureIdConfiguration = 3;
	public const int kSktCaptureIdDataConfirmationMode = 4;
	public const int kSktCaptureIdDataConfirmationAction = 5;
	public const int kSktCaptureIdMonitorMode = 6;
	public const int kSktCaptureIdSoftScanStatus = 7;
	public const int kSktCaptureIdDataSourceInfo = 8;
	public const int kSktCaptureIdDataEditingProfile = 9;
	public const int kSktCaptureIdDataEditingCurrentProfile = 10;
	public const int kSktCaptureIdDataEditingTriggerSymbologies = 11;
	public const int kSktCaptureIdDataEditingTriggerMinLength = 12;
	public const int kSktCaptureIdDataEditingTriggerMaxLength = 13;
	public const int kSktCaptureIdDataEditingTriggerStartsBy = 14;
	public const int kSktCaptureIdDataEditingTriggerEndsWith = 15;
	public const int kSktCaptureIdDataEditingTriggerContains = 16;
	public const int kSktCaptureIdDataEditingOperation = 17;
	public const int kSktCaptureIdDataEditingImportExport = 18;
	public const int kSktCaptureLastGeneralGroup = 19;
};

internal class DeviceGeneralGroup
{
	public const int kSktCaptureIdDeviceVersion = 0;
	public const int kSktCaptureIdDeviceInterfaceVersion = 1;
	public const int kSktCaptureIdDeviceType = 2;
	public const int kSktCaptureIdDeviceSpecific = 3;
	public const int kSktCaptureIdDeviceDataSource = 4;
	public const int kSktCaptureIdDeviceTrigger = 5;
	public const int kSktCaptureIdDeviceApplyConfig = 6;
	public const int kSktCaptureIdDevicePreamble = 7;
	public const int kSktCaptureIdDevicePostamble = 8;
	public const int kSktCaptureIdDeviceCapabilities = 9;
	public const int kSktCaptureIdDeviceChangeId = 10;
	public const int kSktCaptureIdDeviceDataFormat = 11;
	public const int kSktCaptureLastDeviceGeneralGroup = 12;
};

internal class DeviceLocalFunctionsGroup
{
	public const int kSktCaptureIdDeviceFriendlyName = 0;
	public const int kSktCaptureIdDeviceSecurityMode = 1;
	public const int kSktCaptureIdDevicePinCode = 2;
	public const int kSktCaptureIdDeviceDeletePairingBonding = 3;
	public const int kSktCaptureIdDeviceRestoreFactoryDefaults = 4;
	public const int kSktCaptureIdDeviceSetPowerOff = 5;
	public const int kSktCaptureIdDeviceButtonsStatus = 6;
	public const int kSktCaptureIdDeviceSoundConfig = 7;
	public const int kSktCaptureIdDeviceTimers = 8;
	public const int kSktCaptureIdDeviceLocalAcknowledgement = 9;
	public const int kSktCaptureIdDeviceDataConfirmation = 10;
	public const int kSktCaptureIdDeviceBatteryLevel = 11;
	public const int kSktCaptureIdDeviceLocalDecodeAction = 12;
	public const int kSktCaptureIdDeviceBluetoothAddress = 13;
	public const int kSktCaptureIdDeviceStatisticCounters = 14;
	public const int kSktCaptureIdDeviceRumbleConfig = 15;
	public const int kSktCaptureIdDeviceProfileConfig = 16;
	public const int kSktCaptureIdDeviceDisconnect = 17;
	public const int kSktCaptureIdDeviceDataStore = 18;
	public const int kSktCaptureIdDeviceNotifications = 19;
	public const int kSktCaptureIdDeviceConnectReason = 20;
	public const int kSktCaptureIdDevicePowerState = 21;
	public const int kSktCaptureIdDeviceStartUpRoleSPP = 22;
	public const int kSktCaptureIdDeviceConnectionBeepConfig = 23;
	public const int kSktCaptureIdDeviceFlash = 24;
	public const int kSktCaptureIdDeviceOverlayView = 25;
	public const int kSktCaptureIdDeviceStandConfig = 26;
	public const int kSktCaptureIdDevicePcScTagTransmit = 27;
	public const int kSktCaptureIdDevicePcScCouplerControl = 28;
	public const int kSktCaptureLastDeviceLocalFunctions = 29;
};

internal class DeviceManagerFunctionsGroup
{
	public const int kSktCaptureIdDeviceManagerStartDiscovery = 0;
	public const int kSktCaptureIdDeviceManagerFavorite = 1;
	public const int kSktCaptureIdDeviceManagerUniqueDeviceIdentifier = 2;
	public const int kSktCaptureLastDeviceManagerFunctions = 3;
};



/// <summary>
/// defines the property IDs used in Capture
/// </summary>
public class PropId
{
	/// <summary>
	/// Set to notify Capture that the client is shutting down gracefully.
	/// Capture will send device removal events followed by a terminate
	/// event. Once you receive the terminate event, it is safe to shut
	/// down Capture.
	/// </summary>
	public const int kAbort = -2146435072;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kNone)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdAbort)

	/// <summary>
	/// Gets the Capture service version.
	/// </summary>
	public const int kVersion = -2147418111;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdVersion)

	/// <summary>
	/// Gets the version of the firmware interface that Capture service
	/// supports. This can be useful for determining if the Capture service
	/// supports a particular hardware feature.
	/// </summary>
	public const int kInterfaceVersion = -2147418112;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID( kSktCaptureIdInterfaceVersion)

	/// <summary>
	/// property to set or get the Capture configuration
	/// </summary>
	public const int kConfiguration = -2141913085;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdConfiguration)

	/// <summary>
	/// Gets or sets the data confirmation mode. The data confirmation mode
	/// determines who acknowledges whether the data received was good or
	/// bad.
	/// </summary>
	public const int kDataConfirmationMode = -2147352572;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataConfirmationMode)

	/// <summary>
	/// Gets or sets the data confirmation action. Data confirmation action
	/// determines how good or bad data is acknowledged.
	/// </summary>
	public const int kDataConfirmationAction = -2147287035;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kNone)|SKTSETTYPE(kUlong)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataConfirmationAction)

	/// <summary>
	/// Gets or sets the log level of various Capture service components
	/// (Only works on debug builds of the service).
	/// </summary>
	public const int kMonitorMode = -2145124346;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kByte)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdMonitorMode)

	/// <summary>
	/// property to get or set the SoftScan status
	/// (iOS only)
	/// </summary>
	public const int kSoftScanStatus = -2147352569;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdSoftScanStatus)

	/// <summary>
	/// property to get and set the Data Editing Profile
	/// </summary>
	public const int kDataEditingProfile = -2147155959;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kNone)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingProfile)

	/// <summary>
	/// property to get or set the Data Editing Current Profile
	/// </summary>
	public const int kDataEditingCurrentProfile = -2147155958;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kNone)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingCurrentProfile)

	/// <summary>
	/// property to set or get the Data Editing Trigger on Symbologies
	/// </summary>
	public const int kDataEditingTriggerSymbologies = -2141913077;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingTriggerSymbologies)

	/// <summary>
	/// property to set or get the Data Editing Trigger on Decoded Data
	/// Minimum Length
	/// </summary>
	public const int kDataEditingTriggerMinLength = -2141913076;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingTriggerMinLength)

	/// <summary>
	/// property to set or get the Data Editing Trigger on Decoded Data
	/// Maximum Length
	/// </summary>
	public const int kDataEditingTriggerMaxLength = -2141913075;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingTriggerMaxLength)

	/// <summary>
	/// property to set or get the Data Editing Trigger on Decoded Data
	/// starting by a specific string
	/// </summary>
	public const int kDataEditingTriggerStartsBy = -2141913074;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingTriggerStartsBy)

	/// <summary>
	/// property to set or get the Data Editing Trigger on Decoded Data
	/// ending by a specific string
	/// </summary>
	public const int kDataEditingTriggerEndsWith = -2141913073;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingTriggerEndsWith)

	/// <summary>
	/// property to set or get the Data Editing Trigger on Decoded Data
	/// containing a specific string
	/// </summary>
	public const int kDataEditingTriggerContains = -2141913072;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingTriggerContains)

	/// <summary>
	/// property to set or get the Data Editing Operation
	/// </summary>
	public const int kDataEditingOperation = -2141913071;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingOperation)

	/// <summary>
	/// property to set (Import) or get (Export) Data Editing profiles
	/// </summary>
	public const int kDataEditingImportExport = -2141913070;		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingImportExport)

	/// <summary>
	/// Gets the firmware version of the device
	/// </summary>
	public const int kVersionDevice = 65536;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceVersion)

	/// <summary>
	/// Gets the model of the device
	/// </summary>
	public const int kDeviceType = 65538;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceType)

	/// <summary>
	/// Sends an arbitrary get or set command to the device
	/// </summary>
	public const int kDeviceSpecific = 4456451;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kArray)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceSpecific)

	/// <summary>
	/// property to get or set the data source status / information
	/// </summary>
	public const int kDataSourceDevice = 7798788;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kDataSource)|SKTSETTYPE(kDataSource)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceDataSource)

	/// <summary>
	/// Sets the trigger of the device - can start or stop a read and
	/// enable or disable the physical trigger button on the device.
	/// </summary>
	public const int kTriggerDevice = 1179653;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceTrigger)

	/// <summary>
	/// property to apply a config to a Capture Device (not yet enabled)
	/// </summary>
	public const int kApplyConfigDevice = 1048582;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kNone)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceApplyConfig)

	/// <summary>
	/// Gets or sets a preamble for data decoded by the device. When set,
	/// the preamble is added in front of the decoded data.
	/// </summary>
	public const int kPreambleDevice = 327687;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDevicePreamble)

	/// <summary>
	/// Gets or sets a postamble for data decoded by the device. When set,
	/// the postamble is added to the end of the decoded data.
	/// </summary>
	public const int kPostambleDevice = 327688;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDevicePostamble)

	/// <summary>
	/// property to get the Capture Device capabilities
	/// </summary>
	public const int kCapabilitiesDevice = 2162697;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kByte)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceCapabilities)

	/// <summary>
	/// Gets the change id of the device. The change id is a checksum of
	/// all the engine settings - e.g. symbology settings, preamble,
	/// postamble, etc - and can be used to determine if the device
	/// configuration has been altered by another application or using a
	/// command barcode.
	/// </summary>
	public const int kChangeIdDevice = 65546;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceChangeId)

	/// <summary>
	/// property to get or set the Decoded Data Format of a Capture Device
	/// </summary>
	public const int kDataFormatDevice = 131083;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceDataFormat)

	/// <summary>
	/// Gets or sets the friendly name of the device. The friendly name is
	/// the name that appears in Bluetooth settings.
	/// </summary>
	public const int kFriendlyNameDevice = 327936;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceFriendlyName)

	/// <summary>
	/// property to get or set the Capture Device Security Mode
	/// </summary>
	public const int kSecurityModeDevice = 131329;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceSecurityMode)

	/// <summary>
	/// property to get or set the Capture Device PIN code
	/// </summary>
	public const int kPinCodeDevice = 1376514;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDevicePinCode)

	/// <summary>
	/// Set deletes pairing and bonding information off the device. Useful
	/// when preparing to pair the Capture device to a different host.
	/// </summary>
	public const int kDeletePairingBondingDevice = 1179907;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceDeletePairingBonding)

	/// <summary>
	/// Set resets all the settings on the device to their default values.
	/// </summary>
	public const int kRestoreFactoryDefaultsDevice = 1048836;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kNone)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceRestoreFactoryDefaults)

	/// <summary>
	/// Set turns the device off
	/// </summary>
	public const int kSetPowerOffDevice = 1048837;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kNone)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceSetPowerOff)

	/// <summary>
	/// Gets the current state of each button on the device. Consider using
	/// kNotificationsDevice to subscribe to button events instead.
	/// </summary>
	public const int kButtonsStatusDevice = 65798;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceButtonsStatus)

	/// <summary>
	/// Gets or sets the sound configuration of the device. There are
	/// separate sound configurations for when a good scan is acknowledged
	/// locally (by the Capture device) and when it is acknowledged by the
	/// host. The same applies to the bad scan sound configuration.
	/// </summary>
	public const int kSoundConfigDevice = 2359559;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kByte)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceSoundConfig)

	/// <summary>
	/// Gets or sets the trigger lock and auto-off timers. The trigger lock
	/// determines how long the trigger remains locked after decoding data
	/// without receiving confirmation. There are two auto-off timers, one
	/// for when the device is connected to a host and one for when it is
	/// not.
	/// </summary>
	public const int kTimersDevice = 262408;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceTimers)

	/// <summary>
	/// Gets or sets local device acknowledgement. When enabled, the device
	/// acknowledges decoded data as soon as it is decoded. When disabled,
	/// the device waits for the host to acknowledge decoded data and the
	/// trigger will be locked until acknowledgement is received or the
	/// trigger lock timeout has elapsed.
	/// </summary>
	public const int kLocalAcknowledgmentDevice = 131337;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceLocalAcknowledgement)

	/// <summary>
	/// Sends an acknowledgement to the device. Acknowledgement can either
	/// be positive or negative - a.k.a. good scan or bad scan.
	/// </summary>
	public const int kDataConfirmationDevice = 1245450;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kUlong)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceDataConfirmation)

	/// <summary>
	/// Gets the current battery level of the device. Consider using 
	/// kNotificationsDevice to subscribe to battery level change events
	/// instead.
	/// </summary>
	public const int kBatteryLevelDevice = 65803;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceBatteryLevel)

	/// <summary>
	/// Gets or sets the local decode action of the device. Determines how
	/// decoded data is acknowledged - i.e. with a beep, rumble, flash or
	/// some combination of all three.
	/// </summary>
	public const int kLocalDecodeActionDevice = 131340;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceLocalDecodeAction)

	/// <summary>
	/// Gets the Bluetooth address of the device
	/// </summary>
	public const int kBluetoothAddressDevice = 65805;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceBluetoothAddress)

	/// <summary>
	/// Gets the statistics counters of the device. Counters record the
	/// absolute number of times a particular event has occurred.
	/// </summary>
	public const int kStatisticCountersDevice = 65806;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceStatisticCounters)

	/// <summary>
	/// Gets or sets the rumble configuration of the device. There are
	/// separate rumble configurations for when a good scan is acknowledged
	/// locally (by the Capture device) and when it is acknowledged by the
	/// host. The same applies to the bad scan rumble configuration.
	/// </summary>
	public const int kRumbleConfigDevice = 2359567;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kByte)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceRumbleConfig)

	/// <summary>
	/// property to get or set the Capture Device Profile Configuration
	/// </summary>
	public const int kProfileConfigDevice = 262416;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceProfileConfig)

	/// <summary>
	/// Instructs the device to drop its connection. Note: After sending
	/// this command, the host will be unable to send any subsequent
	/// commands to this device.
	/// </summary>
	public const int kDisconnectDevice = 1179921;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceDisconnect)

	/// <summary>
	/// Gets or sets arbitrary bytes to store on the device. The device has
	/// 16 storage locations which can hold up to 64 bytes each.
	/// </summary>
	public const int kDataStoreDevice = 4456722;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kArray)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceDataStore)

	/// <summary>
	/// Gets or sets subscriptions to various events from the device.
	/// Events that can be subscribed to include, trigger press/release,
	/// power button press/release, power state and battery level change.
	/// </summary>
	public const int kNotificationsDevice = 196883;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kUlong)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceNotifications)

	/// <summary>
	/// property to get the Capture Device Connect reason
	/// </summary>
	public const int kConnectReasonDevice = 65812;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceConnectReason)

	/// <summary>
	/// Gets the current power state of the device. Consider using
	/// kNotificationsDevice to subscribe to power state events instead.
	/// </summary>
	public const int kPowerStateDevice = 65813;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDevicePowerState)

	/// <summary>
	/// Gets or sets the reconnect behavior of the device when it is
	/// powered on in application mode. By default, the device will attempt
	/// to reconnect to the last host, but this feature can be turned off
	/// using this property.
	/// </summary>
	public const int kStartUpRoleSPPDevice = 131350;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceStartUpRoleSPP)

	/// <summary>
	/// property to get or set the Capture Device Connection Beep
	/// Configuration.
	/// </summary>
	public const int kConnectionBeepConfigDevice = 131351;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceConnectionBeepConfig)

	/// <summary>
	/// Gets or sets the status of the flash on the SoftScan device.
	/// </summary>
	public const int kFlashDevice = 131352;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceFlash)

	/// <summary>
	/// property to get or set the Capture Device Overlay View (SoftScan
	/// only)
	/// </summary>
	public const int kOverlayViewDevice = 590105;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kObject)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceOverlayView)

	/// <summary>
	/// property to get or set the Capture Device Stand Configuration
	/// </summary>
	public const int kStandConfigDevice = 196890;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kUlong)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceStandConfig)

	/// <summary>
	/// property to start a BLE discovery from a Device Manager
	/// </summary>
	public const int kStartDiscovery = 1245696;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kUlong)|SKTSETGROUPID(kSktCaptureGroupManagerFunctions)|SKTSETPROPID(kSktCaptureIdDeviceManagerStartDiscovery)

	/// <summary>
	/// property to set or get the BLE favorites for a Device Manager
	/// </summary>
	public const int kFavorite = 328193;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupManagerFunctions)|SKTSETPROPID(kSktCaptureIdDeviceManagerFavorite)

	/// <summary>
	/// property to get the BLE Unique Device Identifier that can be used to set favorite with
	/// </summary>
	public const int kUniqueDeviceIdentifier = 5308930;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kString)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupManagerFunctions)|SKTSETPROPID(kSktCaptureIdDeviceManagerUniqueDeviceIdentifier)

	/// <summary>
	/// property to transmit through PC/SC an array of bytes often called APDU
	/// </summary>
	public const int kPcScTagTransmit = 4456731;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kArray)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDevicePcScTagTransmit)

	/// <summary>
	/// property to control the PC/SC coupler device by passing an array of bytes often called APDU
	/// </summary>
	public const int kPcScCouplerControl = 4456732;		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kArray)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDevicePcScCouplerControl)

};


