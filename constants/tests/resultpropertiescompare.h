/**
  This is an properties template file for the properties definition

  2022 © Socket Mobile, Inc. all rights reserved
*/

#ifndef __properties_definition
#define __properties_definition



// Group IDs
enum {
	///<summary>
	///properties that are common to any devices
	///</summary>
	kSktCaptureGroupGeneral=0,
	///<summary>
	///properties that are local to a device
	///</summary>
	kSktCaptureGroupLocalFunctions=1,
	///<summary>
	///properties that are used by Device Manager (BLE)
	///</summary>
	kSktCaptureGroupManagerFunctions=2,
};

// Properties

// CaptureGroup
enum {
	kSktCaptureIdAbort=0,
	kSktCaptureIdVersion=1,
	kSktCaptureIdInterfaceVersion=2,
	kSktCaptureIdConfiguration=3,
	kSktCaptureIdDataConfirmationMode=4,
	kSktCaptureIdDataConfirmationAction=5,
	kSktCaptureIdMonitorMode=6,
	kSktCaptureIdSocketCamStatus=7,
	kSktCaptureIdDataSourceInfo=8,
	kSktCaptureIdDataEditingProfile=9,
	kSktCaptureIdDataEditingCurrentProfile=10,
	kSktCaptureIdDataEditingTriggerSymbologies=11,
	kSktCaptureIdDataEditingTriggerMinLength=12,
	kSktCaptureIdDataEditingTriggerMaxLength=13,
	kSktCaptureIdDataEditingTriggerStartsBy=14,
	kSktCaptureIdDataEditingTriggerEndsWith=15,
	kSktCaptureIdDataEditingTriggerContains=16,
	kSktCaptureIdDataEditingOperation=17,
	kSktCaptureIdDataEditingImportExport=18,
	kSktCaptureLastGeneralGroup=19,
};
// DeviceGeneralGroup
enum {
	kSktCaptureIdDeviceVersion=0,
	kSktCaptureIdDeviceInterfaceVersion=1,
	kSktCaptureIdDeviceType=2,
	kSktCaptureIdDeviceSpecific=3,
	kSktCaptureIdDeviceDataSource=4,
	kSktCaptureIdDeviceTrigger=5,
	kSktCaptureIdDeviceApplyConfig=6,
	kSktCaptureIdDevicePreamble=7,
	kSktCaptureIdDevicePostamble=8,
	kSktCaptureIdDeviceCapabilities=9,
	kSktCaptureIdDeviceChangeId=10,
	kSktCaptureIdDeviceDataFormat=11,
	kSktCaptureLastDeviceGeneralGroup=12,
};
// DeviceLocalFunctionsGroup
enum {
	kSktCaptureIdDeviceFriendlyName=0,
	kSktCaptureIdDeviceSecurityMode=1,
	kSktCaptureIdDevicePinCode=2,
	kSktCaptureIdDeviceDeletePairingBonding=3,
	kSktCaptureIdDeviceRestoreFactoryDefaults=4,
	kSktCaptureIdDeviceSetPowerOff=5,
	kSktCaptureIdDeviceButtonsStatus=6,
	kSktCaptureIdDeviceSoundConfig=7,
	kSktCaptureIdDeviceTimers=8,
	kSktCaptureIdDeviceLocalAcknowledgement=9,
	kSktCaptureIdDeviceDataConfirmation=10,
	kSktCaptureIdDeviceBatteryLevel=11,
	kSktCaptureIdDeviceLocalDecodeAction=12,
	kSktCaptureIdDeviceBluetoothAddress=13,
	kSktCaptureIdDeviceStatisticCounters=14,
	kSktCaptureIdDeviceRumbleConfig=15,
	kSktCaptureIdDeviceProfileConfig=16,
	kSktCaptureIdDeviceDisconnect=17,
	kSktCaptureIdDeviceDataStore=18,
	kSktCaptureIdDeviceNotifications=19,
	kSktCaptureIdDeviceConnectReason=20,
	kSktCaptureIdDevicePowerState=21,
	kSktCaptureIdDeviceStartUpRoleSPP=22,
	kSktCaptureIdDeviceConnectionBeepConfig=23,
	kSktCaptureIdDeviceFlash=24,
	kSktCaptureIdDeviceOverlayView=25,
	kSktCaptureIdDeviceStandConfig=26,
	kSktCaptureIdDevicePcScTagTransmit=27,
	kSktCaptureIdDevicePcScCouplerControl=28,
	kSktCaptureLastDeviceLocalFunctions=29,
};
// DeviceManagerFunctionsGroup
enum {
	kSktCaptureIdDeviceManagerStartDiscovery=0,
	kSktCaptureIdDeviceManagerFavorite=1,
	kSktCaptureIdDeviceManagerUniqueDeviceIdentifier=2,
	kSktCaptureLastDeviceManagerFunctions=3,
};

// Property IDs
enum {
	///<summary>
	/// Set to notify Capture that the client is shutting down gracefully.
	/// Capture will send device removal events followed by a terminate
	/// event. Once you receive the terminate event, it is safe to shut
	/// down Capture.
	///</summary>
	kSktCapturePropIdAbort = -2146435072,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kNone)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdAbort)

	///<summary>
	/// Gets the Capture service version.
	///</summary>
	kSktCapturePropIdVersion = -2147418111,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdVersion)

	///<summary>
	/// Gets the version of the firmware interface that Capture service
	/// supports. This can be useful for determining if the Capture service
	/// supports a particular hardware feature.
	///</summary>
	kSktCapturePropIdInterfaceVersion = -2147418112,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID( kSktCaptureIdInterfaceVersion)

	///<summary>
	/// property to set or get the Capture configuration
	///</summary>
	kSktCapturePropIdConfiguration = -2141913085,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdConfiguration)

	///<summary>
	/// Gets or sets the data confirmation mode. The data confirmation mode
	/// determines who acknowledges whether the data received was good or
	/// bad.
	///</summary>
	kSktCapturePropIdDataConfirmationMode = -2147352572,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataConfirmationMode)

	///<summary>
	/// Gets or sets the data confirmation action. Data confirmation action
	/// determines how good or bad data is acknowledged.
	///</summary>
	kSktCapturePropIdDataConfirmationAction = -2147287035,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kNone)|SKTSETTYPE(kUlong)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataConfirmationAction)

	///<summary>
	/// Gets or sets the log level of various Capture service components
	/// (Only works on debug builds of the service).
	///</summary>
	kSktCapturePropIdMonitorMode = -2145124346,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kByte)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdMonitorMode)

	///<summary>
	/// property to get or set the SocketCam status
	/// (iOS only)
	///</summary>
	kSktCapturePropIdSocketCamStatus = -2147352569,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdSocketCamStatus)

	///<summary>
	/// property to get and set the Data Editing Profile
	///</summary>
	kSktCapturePropIdDataEditingProfile = -2147155959,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kNone)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingProfile)

	///<summary>
	/// property to get or set the Data Editing Current Profile
	///</summary>
	kSktCapturePropIdDataEditingCurrentProfile = -2147155958,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kNone)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingCurrentProfile)

	///<summary>
	/// property to set or get the Data Editing Trigger on Symbologies
	///</summary>
	kSktCapturePropIdDataEditingTriggerSymbologies = -2141913077,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingTriggerSymbologies)

	///<summary>
	/// property to set or get the Data Editing Trigger on Decoded Data
	/// Minimum Length
	///</summary>
	kSktCapturePropIdDataEditingTriggerMinLength = -2141913076,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingTriggerMinLength)

	///<summary>
	/// property to set or get the Data Editing Trigger on Decoded Data
	/// Maximum Length
	///</summary>
	kSktCapturePropIdDataEditingTriggerMaxLength = -2141913075,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingTriggerMaxLength)

	///<summary>
	/// property to set or get the Data Editing Trigger on Decoded Data
	/// starting by a specific string
	///</summary>
	kSktCapturePropIdDataEditingTriggerStartsBy = -2141913074,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingTriggerStartsBy)

	///<summary>
	/// property to set or get the Data Editing Trigger on Decoded Data
	/// ending by a specific string
	///</summary>
	kSktCapturePropIdDataEditingTriggerEndsWith = -2141913073,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingTriggerEndsWith)

	///<summary>
	/// property to set or get the Data Editing Trigger on Decoded Data
	/// containing a specific string
	///</summary>
	kSktCapturePropIdDataEditingTriggerContains = -2141913072,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingTriggerContains)

	///<summary>
	/// property to set or get the Data Editing Operation
	///</summary>
	kSktCapturePropIdDataEditingOperation = -2141913071,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingOperation)

	///<summary>
	/// property to set (Import) or get (Export) Data Editing profiles
	///</summary>
	kSktCapturePropIdDataEditingImportExport = -2141913070,		// SKTPROPIDCAPTURE(True)|SKTGETTYPE(kString)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDataEditingImportExport)

	///<summary>
	/// Gets the firmware version of the device
	///</summary>
	kSktCapturePropIdVersionDevice = 65536,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceVersion)

	///<summary>
	/// Gets the model of the device
	///</summary>
	kSktCapturePropIdDeviceType = 65538,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceType)

	///<summary>
	/// Sends an arbitrary get or set command to the device
	///</summary>
	kSktCapturePropIdDeviceSpecific = 4456451,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kArray)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceSpecific)

	///<summary>
	/// property to get or set the data source status / information
	///</summary>
	kSktCapturePropIdDataSourceDevice = 7798788,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kDataSource)|SKTSETTYPE(kDataSource)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceDataSource)

	///<summary>
	/// Sets the trigger of the device - can start or stop a read and
	/// enable or disable the physical trigger button on the device.
	///</summary>
	kSktCapturePropIdTriggerDevice = 1179653,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceTrigger)

	///<summary>
	/// property to apply a config to a Capture Device (not yet enabled)
	///</summary>
	kSktCapturePropIdApplyConfigDevice = 1048582,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kNone)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceApplyConfig)

	///<summary>
	/// Gets or sets a preamble for data decoded by the device. When set,
	/// the preamble is added in front of the decoded data.
	///</summary>
	kSktCapturePropIdPreambleDevice = 327687,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDevicePreamble)

	///<summary>
	/// Gets or sets a postamble for data decoded by the device. When set,
	/// the postamble is added to the end of the decoded data.
	///</summary>
	kSktCapturePropIdPostambleDevice = 327688,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDevicePostamble)

	///<summary>
	/// property to get the Capture Device capabilities
	///</summary>
	kSktCapturePropIdCapabilitiesDevice = 2162697,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kByte)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceCapabilities)

	///<summary>
	/// Gets the change id of the device. The change id is a checksum of
	/// all the engine settings - e.g. symbology settings, preamble,
	/// postamble, etc - and can be used to determine if the device
	/// configuration has been altered by another application or using a
	/// command barcode.
	///</summary>
	kSktCapturePropIdChangeIdDevice = 65546,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceChangeId)

	///<summary>
	/// property to get or set the Decoded Data Format of a Capture Device
	///</summary>
	kSktCapturePropIdDataFormatDevice = 131083,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupGeneral)|SKTSETPROPID(kSktCaptureIdDeviceDataFormat)

	///<summary>
	/// Gets or sets the friendly name of the device. The friendly name is
	/// the name that appears in Bluetooth settings.
	///</summary>
	kSktCapturePropIdFriendlyNameDevice = 327936,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceFriendlyName)

	///<summary>
	/// property to get or set the Capture Device Security Mode
	///</summary>
	kSktCapturePropIdSecurityModeDevice = 131329,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceSecurityMode)

	///<summary>
	/// property to get or set the Capture Device PIN code
	///</summary>
	kSktCapturePropIdPinCodeDevice = 1376514,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDevicePinCode)

	///<summary>
	/// Set deletes pairing and bonding information off the device. Useful
	/// when preparing to pair the Capture device to a different host.
	///</summary>
	kSktCapturePropIdDeletePairingBondingDevice = 1179907,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceDeletePairingBonding)

	///<summary>
	/// Set resets all the settings on the device to their default values.
	///</summary>
	kSktCapturePropIdRestoreFactoryDefaultsDevice = 1048836,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kNone)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceRestoreFactoryDefaults)

	///<summary>
	/// Set turns the device off
	///</summary>
	kSktCapturePropIdSetPowerOffDevice = 1048837,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kNone)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceSetPowerOff)

	///<summary>
	/// Gets the current state of each button on the device. Consider using
	/// kNotificationsDevice to subscribe to button events instead.
	///</summary>
	kSktCapturePropIdButtonsStatusDevice = 65798,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceButtonsStatus)

	///<summary>
	/// Gets or sets the sound configuration of the device. There are
	/// separate sound configurations for when a good scan is acknowledged
	/// locally (by the Capture device) and when it is acknowledged by the
	/// host. The same applies to the bad scan sound configuration.
	///</summary>
	kSktCapturePropIdSoundConfigDevice = 2359559,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kByte)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceSoundConfig)

	///<summary>
	/// Gets or sets the trigger lock and auto-off timers. The trigger lock
	/// determines how long the trigger remains locked after decoding data
	/// without receiving confirmation. There are two auto-off timers, one
	/// for when the device is connected to a host and one for when it is
	/// not.
	///</summary>
	kSktCapturePropIdTimersDevice = 262408,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceTimers)

	///<summary>
	/// Gets or sets local device acknowledgement. When enabled, the device
	/// acknowledges decoded data as soon as it is decoded. When disabled,
	/// the device waits for the host to acknowledge decoded data and the
	/// trigger will be locked until acknowledgement is received or the
	/// trigger lock timeout has elapsed.
	///</summary>
	kSktCapturePropIdLocalAcknowledgmentDevice = 131337,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceLocalAcknowledgement)

	///<summary>
	/// Sends an acknowledgement to the device. Acknowledgement can either
	/// be positive or negative - a.k.a. good scan or bad scan.
	///</summary>
	kSktCapturePropIdDataConfirmationDevice = 1245450,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kUlong)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceDataConfirmation)

	///<summary>
	/// Gets the current battery level of the device. Consider using 
	/// kNotificationsDevice to subscribe to battery level change events
	/// instead.
	///</summary>
	kSktCapturePropIdBatteryLevelDevice = 65803,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceBatteryLevel)

	///<summary>
	/// Gets or sets the local decode action of the device. Determines how
	/// decoded data is acknowledged - i.e. with a beep, rumble, flash or
	/// some combination of all three.
	///</summary>
	kSktCapturePropIdLocalDecodeActionDevice = 131340,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceLocalDecodeAction)

	///<summary>
	/// Gets the Bluetooth address of the device
	///</summary>
	kSktCapturePropIdBluetoothAddressDevice = 65805,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceBluetoothAddress)

	///<summary>
	/// Gets the statistics counters of the device. Counters record the
	/// absolute number of times a particular event has occurred.
	///</summary>
	kSktCapturePropIdStatisticCountersDevice = 65806,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceStatisticCounters)

	///<summary>
	/// Gets or sets the rumble configuration of the device. There are
	/// separate rumble configurations for when a good scan is acknowledged
	/// locally (by the Capture device) and when it is acknowledged by the
	/// host. The same applies to the bad scan rumble configuration.
	///</summary>
	kSktCapturePropIdRumbleConfigDevice = 2359567,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kByte)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceRumbleConfig)

	///<summary>
	/// property to get or set the Capture Device Profile Configuration
	///</summary>
	kSktCapturePropIdProfileConfigDevice = 262416,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceProfileConfig)

	///<summary>
	/// Instructs the device to drop its connection. Note: After sending
	/// this command, the host will be unable to send any subsequent
	/// commands to this device.
	///</summary>
	kSktCapturePropIdDisconnectDevice = 1179921,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceDisconnect)

	///<summary>
	/// Gets or sets arbitrary bytes to store on the device. The device has
	/// 16 storage locations which can hold up to 64 bytes each.
	///</summary>
	kSktCapturePropIdDataStoreDevice = 4456722,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kArray)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceDataStore)

	///<summary>
	/// Gets or sets subscriptions to various events from the device.
	/// Events that can be subscribed to include, trigger press/release,
	/// power button press/release, power state and battery level change.
	///</summary>
	kSktCapturePropIdNotificationsDevice = 196883,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kUlong)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceNotifications)

	///<summary>
	/// property to get the Capture Device Connect reason
	///</summary>
	kSktCapturePropIdConnectReasonDevice = 65812,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceConnectReason)

	///<summary>
	/// Gets the current power state of the device. Consider using
	/// kNotificationsDevice to subscribe to power state events instead.
	///</summary>
	kSktCapturePropIdPowerStateDevice = 65813,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDevicePowerState)

	///<summary>
	/// Gets or sets the reconnect behavior of the device when it is
	/// powered on in application mode. By default, the device will attempt
	/// to reconnect to the last host, but this feature can be turned off
	/// using this property.
	///</summary>
	kSktCapturePropIdStartUpRoleSPPDevice = 131350,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceStartUpRoleSPP)

	///<summary>
	/// property to get or set the Capture Device Connection Beep
	/// Configuration.
	///</summary>
	kSktCapturePropIdConnectionBeepConfigDevice = 131351,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceConnectionBeepConfig)

	///<summary>
	/// Gets or sets the status of the flash on the SocketCam device.
	///</summary>
	kSktCapturePropIdFlashDevice = 131352,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kByte)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceFlash)

	///<summary>
	/// property to get or set the Capture Device Overlay View (SocketCam
	/// only)
	///</summary>
	kSktCapturePropIdOverlayViewDevice = 590105,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kObject)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceOverlayView)

	///<summary>
	/// property to get or set the Capture Device Stand Configuration
	///</summary>
	kSktCapturePropIdStandConfigDevice = 196890,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kUlong)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDeviceStandConfig)

	///<summary>
	/// property to start a BLE discovery from a Device Manager
	///</summary>
	kSktCapturePropIdStartDiscovery = 1245696,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNotApplicable)|SKTSETTYPE(kUlong)|SKTSETGROUPID(kSktCaptureGroupManagerFunctions)|SKTSETPROPID(kSktCaptureIdDeviceManagerStartDiscovery)

	///<summary>
	/// property to set or get the BLE favorites for a Device Manager
	///</summary>
	kSktCapturePropIdFavorite = 328193,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kNone)|SKTSETTYPE(kString)|SKTSETGROUPID(kSktCaptureGroupManagerFunctions)|SKTSETPROPID(kSktCaptureIdDeviceManagerFavorite)

	///<summary>
	/// property to get the BLE Unique Device Identifier that can be used to set favorite with
	///</summary>
	kSktCapturePropIdUniqueDeviceIdentifier = 5308930,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kString)|SKTSETTYPE(kNotApplicable)|SKTSETGROUPID(kSktCaptureGroupManagerFunctions)|SKTSETPROPID(kSktCaptureIdDeviceManagerUniqueDeviceIdentifier)

	///<summary>
	/// property to transmit through PC/SC an array of bytes often called APDU
	///</summary>
	kSktCapturePropIdPcScTagTransmit = 4456731,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kArray)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDevicePcScTagTransmit)

	///<summary>
	/// property to control the PC/SC coupler device by passing an array of bytes often called APDU
	///</summary>
	kSktCapturePropIdPcScCouplerControl = 4456732,		// SKTPROPIDCAPTURE(False)|SKTGETTYPE(kArray)|SKTSETTYPE(kArray)|SKTSETGROUPID(kSktCaptureGroupLocalFunctions)|SKTSETPROPID(kSktCaptureIdDevicePcScCouplerControl)

};



#endif
