// This is an error template file for the error definition
// 2022 © Socket Mobile, Inc. all rights reserved


/// defines the Errors used in Capture
class SktErrors
{
	/// The wait timed out
	static const int ESKT_WAITTIMEOUT = 1;

	/// This operation is already complete
	static const int ESKT_ALREADYDONE = 2;

	/// This operation is pending
	static const int ESKT_PENDING = 3;

	/// This operation is still pending
	static const int ESKT_STILLPENDING = 4;

	/// The object has been created
	static const int ESKT_CREATED = 5;

	/// There is no error
	static const int ESKT_NOERROR = 0;

	/// At least one test has failed
	static const int ESKT_TESTFAILED = -1;

	/// There is not enough memory to complete the operation
	static const int ESKT_NOTENOUGHMEMORY = -2;

	/// A lock cannot be created
	static const int ESKT_UNABLECREATELOCK = -3;

	/// Unable to lock a shared resource
	static const int ESKT_UNABLELOCK = -4;

	/// Unable to unlock a shared resource
	static const int ESKT_UNABLEUNLOCK = -5;

	/// Unable to remove an item from a list because the list is empty
	static const int ESKT_LISTEMPTY = -6;

	/// An event cannot be created
	static const int ESKT_UNABLECREATEEVENT = -7;

	/// Unable to set an event
	static const int ESKT_UNABLESETEVENT = -8;

	/// Unable to reset an event
	static const int ESKT_UNABLERESETEVENT = -9;

	/// The event is not created
	static const int ESKT_EVENTNOTCREATED = -10;

	/// The provided handle is invalid
	static const int ESKT_INVALIDHANDLE = -11;

	/// A thread cannot be created
	static const int ESKT_UNABLECREATETHREAD = -12;

	/// The thread is already created
	static const int ESKT_THREADALREADYCREATED = -13;

	/// The thread is still running
	static const int ESKT_THREADSTILLRUNNING = -14;

	/// This operation is not supported
	static const int ESKT_NOTSUPPORTED = -15;

	/// The previous operation is not completed
	static const int ESKT_PENDINGOPERATIONNOTCOMPLETED = -16;

	/// The item cannot be found
	static const int ESKT_NOTFOUND = -17;

	/// The provided parameter is invalid
	static const int ESKT_INVALIDPARAMETER = -18;

	/// Trying to use an object that is not yet initialized
	static const int ESKT_NOTINITIALIZED = -19;

	/// The timeout value is out of range
	static const int ESKT_TIMEOUTOUTOFRANGE = -20;

	/// The object cannot be initialized
	static const int ESKT_UNABLEINITIALIZE = -21;

	/// The object cannot be un-initialized
	static const int ESKT_UNABLEDEINITIALIZE = -22;

	/// The configuration is unknown
	static const int ESKT_UNKNOWNCONFIGURATION = -23;

	/// The configuration is invalid
	static const int ESKT_INVALIDCONFIGURATION = -24;

	/// Creating or adding an item that already exists
	static const int ESKT_ALREADYEXISTING = -25;

	/// The provided buffer is too small
	static const int ESKT_BUFFERTOOSMALL = -26;

	/// The specified device cannot be opened
	static const int ESKT_UNABLEOPENDEVICE = -27;

	/// The specified device cannot be configured
	static const int ESKT_UNABLECONFIGUREDEVICE = -28;

	/// The string cannot be converted
	static const int ESKT_UNABLECONVERTSTRING = -29;

	/// The specified string cannot be copied
	static const int ESKT_UNABLECOPYSTRING = -30;

	/// The specified device is not open
	static const int ESKT_DEVICENOTOPEN = -31;

	/// The specified item is not available
	static const int ESKT_NOTAVAILABLE = -32;

	/// The specified file cannot be written
	static const int ESKT_UNABLEWRITEFILE = -33;

	/// The specified file cannot be read
	static const int ESKT_UNABLEREADFILE = -34;

	/// The wait has failed
	static const int ESKT_WAITFAILED = -35;

	/// The specified checksum is invalid
	static const int ESKT_INVALIDCHECKSUM = -36;

	/// This command has been denied
	static const int ESKT_COMMANDDENIED = -37;

	/// There was an error during communication
	static const int ESKT_COMMUNICATIONERROR = -38;

	/// An unexpected command has been received
	static const int ESKT_RECEIVEUNEXPECTEDCOMMAND = -39;

	/// The GUID cannot be created
	static const int ESKT_UNABLECREATEGUID = -40;

	/// The specified value is invalid
	static const int ESKT_INVALIDVALUE = -41;

	/// The request has timed out
	static const int ESKT_REQUESTTIMEDOUT = -42;

	/// The operation is invalid
	static const int ESKT_INVALIDOPERATION = -43;

	/// The protocol used is not the correct one
	static const int ESKT_WRONGPROTOCOL = -44;

	/// The queue has been reset
	static const int ESKT_QUEUERESETED = -45;

	/// The data size exceeeds maximum transmission unit
	static const int ESKT_EXCEEDINGMTUSIZE = -46;

	/// The listener thread has nothing to listen to
	static const int ESKT_NOTHINGTOLISTEN = -47;

	/// The current version is outdated
	static const int ESKT_OUTDATEDVERSION = -48;

	/// The XML tag is invalid
	static const int ESKT_INVALIDXMLTAG = -49;

	/// Cannot register for  HID change notifications
	static const int ESKT_UNABLEREGISTERFORHIDCHANGES = -50;

	/// The message cannot be retrieved
	static const int ESKT_UNABLERETRIEVEMESSAGE = -51;

	/// There is a syntax error
	static const int ESKT_SYNTAXERROR = -52;

	/// The specified file cannot be opened
	static const int ESKT_UNABLEOPENFILE = -53;

	/// The file path cannot be retrieved
	static const int ESKT_UNABLERETRIEVEPATH = -54;

	/// The specified directory cannot be created
	static const int ESKT_UNABLECREATEDIRECTORY = -55;

	/// The specified file cannot be deleted
	static const int ESKT_UNABLEDELETEFILE = -56;

	/// The specified directory cannot be deleted
	static const int ESKT_UNABLEDELETEDIRECTORY = -57;

	/// The modem status cannot be read
	static const int ESKT_UNABLEREADMODEMSTATUS = -60;

	/// The Class of Devices cannot be retrieved
	static const int ESKT_UNABLEGETCLASSDEVICES = -61;

	/// The device interface cannot be retrieved
	static const int ESKT_UNABLEGETDEVICEINTERFACE = -62;

	/// The specified file or device cannot be found
	static const int ESKT_FILENOTFOUND = -63;

	/// The specified file or device is not accessible
	static const int ESKT_FILEACCESSDENIED = -64;

	/// The HID information cannot be read
	static const int ESKT_UNABLEREADHIDINFO = -70;

	/// The number of parameters is incorrect
	static const int ESKT_INCORRECTNUMBEROFPARAMETERS = -84;

	/// The specified format is invalid
	static const int ESKT_INVALIDFORMAT = -85;

	/// The version is invalid
	static const int ESKT_INVALIDVERSION = -86;

	/// The service does not respond
	static const int ESKT_SERVICENOTCOMMUNICATING = -87;

	/// The SoftScan overlay view is not set
	static const int ESKT_OVERLAYVIEWNOTSET = -90;

	/// This operation has been canceled
	static const int ESKT_CANCEL = -91;

	/// The operation has expired
	static const int ESKT_EXPIRED = -92;

	/// The AppInfo information is invalid
	static const int ESKT_INVALIDAPPINFO = -93;

	/// BLE operation failed
	static const int ESKT_BLEGATT = -94;

	/// Auto-discovery is in progress
	static const int ESKT_FAVORITENOTEMPTY = -95;

	/// Location permission is required to complete the operation
	static const int ESKT_LOCATIONPERMISSIONMISSING = -96;

	/// The requested operation cannot be completed
	static const int ESKT_UNABLETOCOMPLETEOPERATION = -97;

	/// Location service is disabled
	static const int ESKT_LOCATIONSERVICEDISABLED = -98;

}