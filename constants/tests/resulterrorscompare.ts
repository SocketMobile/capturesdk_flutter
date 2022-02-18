/**
  This is an error template file for the error definition

  2017 © Socket Mobile, Inc. all rights reserved
*/


/// <summary>
/// defines the Errors used in Capture
/// </summary>
class SktErrors
{
	/// <summary>
	/// The wait timed out
	/// </summary>
	static readonly ESKT_WAITTIMEOUT = 1;

	/// <summary>
	/// This operation is already complete
	/// </summary>
	static readonly ESKT_ALREADYDONE = 2;

	/// <summary>
	/// This operation is pending
	/// </summary>
	static readonly ESKT_PENDING = 3;

	/// <summary>
	/// This operation is still pending
	/// </summary>
	static readonly ESKT_STILLPENDING = 4;

	/// <summary>
	/// The object has been created
	/// </summary>
	static readonly ESKT_CREATED = 5;

	/// <summary>
	/// There is no error
	/// </summary>
	static readonly ESKT_NOERROR = 0;

	/// <summary>
	/// At least one test has failed
	/// </summary>
	static readonly ESKT_TESTFAILED = -1;

	/// <summary>
	/// There is not enough memory to complete the operation
	/// </summary>
	static readonly ESKT_NOTENOUGHMEMORY = -2;

	/// <summary>
	/// A lock cannot be created
	/// </summary>
	static readonly ESKT_UNABLECREATELOCK = -3;

	/// <summary>
	/// Unable to lock a shared resource
	/// </summary>
	static readonly ESKT_UNABLELOCK = -4;

	/// <summary>
	/// Unable to unlock a shared resource
	/// </summary>
	static readonly ESKT_UNABLEUNLOCK = -5;

	/// <summary>
	/// Unable to remove an item from a list because the list is empty
	/// </summary>
	static readonly ESKT_LISTEMPTY = -6;

	/// <summary>
	/// An event cannot be created
	/// </summary>
	static readonly ESKT_UNABLECREATEEVENT = -7;

	/// <summary>
	/// Unable to set an event
	/// </summary>
	static readonly ESKT_UNABLESETEVENT = -8;

	/// <summary>
	/// Unable to reset an event
	/// </summary>
	static readonly ESKT_UNABLERESETEVENT = -9;

	/// <summary>
	/// The event is not created
	/// </summary>
	static readonly ESKT_EVENTNOTCREATED = -10;

	/// <summary>
	/// The provided handle is invalid
	/// </summary>
	static readonly ESKT_INVALIDHANDLE = -11;

	/// <summary>
	/// A thread cannot be created
	/// </summary>
	static readonly ESKT_UNABLECREATETHREAD = -12;

	/// <summary>
	/// The thread is already created
	/// </summary>
	static readonly ESKT_THREADALREADYCREATED = -13;

	/// <summary>
	/// The thread is still running
	/// </summary>
	static readonly ESKT_THREADSTILLRUNNING = -14;

	/// <summary>
	/// This operation is not supported
	/// </summary>
	static readonly ESKT_NOTSUPPORTED = -15;

	/// <summary>
	/// The previous operation is not completed
	/// </summary>
	static readonly ESKT_PENDINGOPERATIONNOTCOMPLETED = -16;

	/// <summary>
	/// The item cannot be found
	/// </summary>
	static readonly ESKT_NOTFOUND = -17;

	/// <summary>
	/// The provided parameter is invalid
	/// </summary>
	static readonly ESKT_INVALIDPARAMETER = -18;

	/// <summary>
	/// Trying to use an object that is not yet initialized
	/// </summary>
	static readonly ESKT_NOTINITIALIZED = -19;

	/// <summary>
	/// The timeout value is out of range
	/// </summary>
	static readonly ESKT_TIMEOUTOUTOFRANGE = -20;

	/// <summary>
	/// The object cannot be initialized
	/// </summary>
	static readonly ESKT_UNABLEINITIALIZE = -21;

	/// <summary>
	/// The object cannot be un-initialized
	/// </summary>
	static readonly ESKT_UNABLEDEINITIALIZE = -22;

	/// <summary>
	/// The configuration is unknown
	/// </summary>
	static readonly ESKT_UNKNOWNCONFIGURATION = -23;

	/// <summary>
	/// The configuration is invalid
	/// </summary>
	static readonly ESKT_INVALIDCONFIGURATION = -24;

	/// <summary>
	/// Creating or adding an item that already exists
	/// </summary>
	static readonly ESKT_ALREADYEXISTING = -25;

	/// <summary>
	/// The provided buffer is too small
	/// </summary>
	static readonly ESKT_BUFFERTOOSMALL = -26;

	/// <summary>
	/// The specified device cannot be opened
	/// </summary>
	static readonly ESKT_UNABLEOPENDEVICE = -27;

	/// <summary>
	/// The specified device cannot be configured
	/// </summary>
	static readonly ESKT_UNABLECONFIGUREDEVICE = -28;

	/// <summary>
	/// The string cannot be converted
	/// </summary>
	static readonly ESKT_UNABLECONVERTSTRING = -29;

	/// <summary>
	/// The specified string cannot be copied
	/// </summary>
	static readonly ESKT_UNABLECOPYSTRING = -30;

	/// <summary>
	/// The specified device is not open
	/// </summary>
	static readonly ESKT_DEVICENOTOPEN = -31;

	/// <summary>
	/// The specified item is not available
	/// </summary>
	static readonly ESKT_NOTAVAILABLE = -32;

	/// <summary>
	/// The specified file cannot be written
	/// </summary>
	static readonly ESKT_UNABLEWRITEFILE = -33;

	/// <summary>
	/// The specified file cannot be read
	/// </summary>
	static readonly ESKT_UNABLEREADFILE = -34;

	/// <summary>
	/// The wait has failed
	/// </summary>
	static readonly ESKT_WAITFAILED = -35;

	/// <summary>
	/// The specified checksum is invalid
	/// </summary>
	static readonly ESKT_INVALIDCHECKSUM = -36;

	/// <summary>
	/// This command has been denied
	/// </summary>
	static readonly ESKT_COMMANDDENIED = -37;

	/// <summary>
	/// There was an error during communication
	/// </summary>
	static readonly ESKT_COMMUNICATIONERROR = -38;

	/// <summary>
	/// An unexpected command has been received
	/// </summary>
	static readonly ESKT_RECEIVEUNEXPECTEDCOMMAND = -39;

	/// <summary>
	/// The GUID cannot be created
	/// </summary>
	static readonly ESKT_UNABLECREATEGUID = -40;

	/// <summary>
	/// The specified value is invalid
	/// </summary>
	static readonly ESKT_INVALIDVALUE = -41;

	/// <summary>
	/// The request has timed out
	/// </summary>
	static readonly ESKT_REQUESTTIMEDOUT = -42;

	/// <summary>
	/// The operation is invalid
	/// </summary>
	static readonly ESKT_INVALIDOPERATION = -43;

	/// <summary>
	/// The protocol used is not the correct one
	/// </summary>
	static readonly ESKT_WRONGPROTOCOL = -44;

	/// <summary>
	/// The queue has been reset
	/// </summary>
	static readonly ESKT_QUEUERESETED = -45;

	/// <summary>
	/// The data size exceeeds maximum transmission unit
	/// </summary>
	static readonly ESKT_EXCEEDINGMTUSIZE = -46;

	/// <summary>
	/// The listener thread has nothing to listen to
	/// </summary>
	static readonly ESKT_NOTHINGTOLISTEN = -47;

	/// <summary>
	/// The current version is outdated
	/// </summary>
	static readonly ESKT_OUTDATEDVERSION = -48;

	/// <summary>
	/// The XML tag is invalid
	/// </summary>
	static readonly ESKT_INVALIDXMLTAG = -49;

	/// <summary>
	/// Cannot register for  HID change notifications
	/// </summary>
	static readonly ESKT_UNABLEREGISTERFORHIDCHANGES = -50;

	/// <summary>
	/// The message cannot be retrieved
	/// </summary>
	static readonly ESKT_UNABLERETRIEVEMESSAGE = -51;

	/// <summary>
	/// There is a syntax error
	/// </summary>
	static readonly ESKT_SYNTAXERROR = -52;

	/// <summary>
	/// The specified file cannot be opened
	/// </summary>
	static readonly ESKT_UNABLEOPENFILE = -53;

	/// <summary>
	/// The file path cannot be retrieved
	/// </summary>
	static readonly ESKT_UNABLERETRIEVEPATH = -54;

	/// <summary>
	/// The specified directory cannot be created
	/// </summary>
	static readonly ESKT_UNABLECREATEDIRECTORY = -55;

	/// <summary>
	/// The specified file cannot be deleted
	/// </summary>
	static readonly ESKT_UNABLEDELETEFILE = -56;

	/// <summary>
	/// The specified directory cannot be deleted
	/// </summary>
	static readonly ESKT_UNABLEDELETEDIRECTORY = -57;

	/// <summary>
	/// The modem status cannot be read
	/// </summary>
	static readonly ESKT_UNABLEREADMODEMSTATUS = -60;

	/// <summary>
	/// The Class of Devices cannot be retrieved
	/// </summary>
	static readonly ESKT_UNABLEGETCLASSDEVICES = -61;

	/// <summary>
	/// The device interface cannot be retrieved
	/// </summary>
	static readonly ESKT_UNABLEGETDEVICEINTERFACE = -62;

	/// <summary>
	/// The specified file or device cannot be found
	/// </summary>
	static readonly ESKT_FILENOTFOUND = -63;

	/// <summary>
	/// The specified file or device is not accessible
	/// </summary>
	static readonly ESKT_FILEACCESSDENIED = -64;

	/// <summary>
	/// The HID information cannot be read
	/// </summary>
	static readonly ESKT_UNABLEREADHIDINFO = -70;

	/// <summary>
	/// The profile file causes a conflict
	/// THIS ERROR IS DEPRECATED!!!
	/// </summary>
	static readonly ESKT_CONFLICTPROFILE = -80;

	/// <summary>
	/// The current profile cannot be deleted
	/// THIS ERROR IS DEPRECATED!!!
	/// </summary>
	static readonly ESKT_DELETECURRENTPROFILE = -81;

	/// <summary>
	/// Data editing cannot be initialized
	/// THIS ERROR IS DEPRECATED!!!
	/// </summary>
	static readonly ESKT_UNABLEINITIALIZEDATAEDITING = -82;

	/// <summary>
	/// The data editing operation is invalid
	/// THIS ERROR IS DEPRECATED!!!
	/// </summary>
	static readonly ESKT_UNKNOWNDATAEDITINGOPERATION = -83;

	/// <summary>
	/// The number of parameters is incorrect
	/// </summary>
	static readonly ESKT_INCORRECTNUMBEROFPARAMETERS = -84;

	/// <summary>
	/// The specified format is invalid
	/// </summary>
	static readonly ESKT_INVALIDFORMAT = -85;

	/// <summary>
	/// The version is invalid
	/// </summary>
	static readonly ESKT_INVALIDVERSION = -86;

	/// <summary>
	/// The service does not respond
	/// </summary>
	static readonly ESKT_SERVICENOTCOMMUNICATING = -87;

	/// <summary>
	/// The SoftScan overlay view is not set
	/// </summary>
	static readonly ESKT_OVERLAYVIEWNOTSET = -90;

	/// <summary>
	/// This operation has been canceled
	/// </summary>
	static readonly ESKT_CANCEL = -91;

	/// <summary>
	/// The operation has expired
	/// </summary>
	static readonly ESKT_EXPIRED = -92;

	/// <summary>
	/// The AppInfo information is invalid
	/// </summary>
	static readonly ESKT_INVALIDAPPINFO = -93;

	/// <summary>
	/// BLE operation failed
	/// </summary>
	static readonly ESKT_BLEGATT = -94;

	/// <summary>
	/// Auto-discovery is in progress
	/// </summary>
	static readonly ESKT_FAVORITENOTEMPTY = -95;

	/// <summary>
	/// Location permission is required to complete the operation
	/// </summary>
	static readonly ESKT_LOCATIONPERMISSIONMISSING = -96;

	/// <summary>
	/// The requested operation cannot be completed
	/// </summary>
	static readonly ESKT_UNABLETOCOMPLETEOPERATION = -97;

	/// <summary>
	/// Location service is disabled
	/// </summary>
	static readonly ESKT_LOCATIONSERVICEDISABLED = -98;

};


