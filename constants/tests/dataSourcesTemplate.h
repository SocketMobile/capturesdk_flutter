/*
SktCaptureTypes.h
Type definitions for Socket Capture
(c) Socket Mobile, Inc.
*/

/*
NOTES:
IF ANY MODIFICATION IS MADE IN THIS FILE THE CAPTURE INTERFACE VERSION
WILL NEED TO BE UPDATED TO IDENTIFY THIS CHANGE.
THE CAPTURE INTERFACE VERSION IS DEFINED IN SktCapture.h
THE MODIFICATION MUST BE DESCRIBED IN Capture.doc
*/

#ifndef _SktCaptureTypes_h
#define _SktCaptureTypes_h

typedef void *SKTHANDLE;
typedef long SKTRESULT;
#define kSktCaptureDeviceNameSize 64
#ifndef IN
#define IN
#define OUT
#define OPTIONAL
#endif

// identifies the type of message
// Capture can send to the App
enum ESktCaptureMsgID
{
	kSktCaptureMsgIdNotInitialized,// this id should never be received
	kSktCaptureMsgIdDeviceArrival,
	kSktCaptureMsgIdDeviceRemoval,
	kSktCaptureMsgIdTerminate,
	kSktCaptureMsgSetComplete,
	kSktCaptureMsgGetComplete,
	kSktCaptureMsgEvent,
	kSktCaptureMsgLastID// just for marking the end of this enum
};

// identifies the type of Event
// Capture can send to the App
enum ESktCaptureEventOldID
{
	kSktCaptureEventOldError,
	kSktCaptureEventOldDecodedData,
	kSktCaptureEventOldPower,
	kSktCaptureEventOldButtons,
	kSktCaptureEventOldBatteryLevel,// Battery Level has changed
	kSktCaptureEventOldListenerStarted,// the communication port listener has started
	kSktCaptureEventOldDeviceOwnership,// Notification when a device ownership changes
	kSktCaptureEventOldLastID// just for marking the end of this enum
};

// New Event IDs combining MsgID and EventID
// The Get and Set Complete events have been removed
// from event notifications as they are now part of
// the response of a Get or Set property
enum ESktCaptureEventID
{
	kSktCaptureEventIdNotInitialized,// this id should never be received
	kSktCaptureEventIdDeviceArrival,
	kSktCaptureEventIdDeviceRemoval,
	kSktCaptureEventIdTerminate,
	kSktCaptureEventIdError,
	kSktCaptureEventIdDecodedData,
	kSktCaptureEventIdPower,
	kSktCaptureEventIdButtons,
	kSktCaptureEventIdBatteryLevel,// Battery Level has changed
	kSktCaptureEventIdListenerStarted,// the communucation port listener has started
	kSktCaptureEventIdDeviceOwnership,// Notification when a device ownership changes
	kSktCaptureEventIdLastID// just for marking the end of this enum
};

// identifies the type of data
// receive in the Event Data structure
enum ESktEventDataType
{
	kSktCaptureEventDataTypeNone,
	kSktCaptureEventDataTypeByte,
	kSktCaptureEventDataTypeUlong,
	kSktCaptureEventDataTypeArray,
	kSktCaptureEventDataTypeString,
	kSktCaptureEventDataTypeDecodedData,
	kSktCaptureEventDataTypeDeviceInfo, // contains the device guid, type, and name
	kSktCaptureEventDataTypeLastID// just for marking the end of this enum
};

$DATASOURCES$

// identifies the property type
enum ESktCapturePropType
{
	kSktCapturePropTypeNone,
	kSktCapturePropTypeNotApplicable,
	kSktCapturePropTypeByte,
	kSktCapturePropTypeUlong,
	kSktCapturePropTypeArray,
	kSktCapturePropTypeString,
	kSktCapturePropTypeVersion,
	kSktCapturePropTypeSymbology,
	kSktCapturePropTypeEnum,
  kSktCapturePropTypeObject,
	kSktCapturePropTypeLastType// just for marking the end of this enum
};

$DATASOURCESFLAGS$

$DATASOURCESSTATUS$


// define an Array
typedef struct
{
	size_t Size;
	unsigned char* pData;
}TSktCaptureArray;

// define a string
typedef struct
{
	size_t nLength;
	char* pValue;
}TSktCaptureString;

// define a version
typedef struct
{
	unsigned long dwMajor;
	unsigned long dwMiddle;
	unsigned long dwMinor;
	unsigned long dwBuild;
	unsigned short wMonth;
	unsigned short wDay;
	unsigned short wYear;
	unsigned short wHour;
	unsigned short wMinute;
}TSktCaptureVersion;

// define a decoded data structure
typedef struct
{
	enum ESktCaptureSymbologyID SymbologyID;
	TSktCaptureString SymbologyName;
	TSktCaptureArray Data;
}TSktCaptureDecodedData;

// define Event Data received
// when Capture sends an Event to the application
typedef struct
{
	enum ESktEventDataType Type;
	union
	{
		unsigned char Byte;
		unsigned long Ulong;
		TSktCaptureArray Array;
		TSktCaptureString String;
		TSktCaptureDecodedData DecodedData;
	}Value;
}TSktEventData;


// define a parameter of a Symbology
typedef struct
{
	unsigned long Reserved;
}TSktCaptureSymbologyParam;

// Symbology information structure
typedef struct
{
	enum ESktCaptureSymbologyID ID;								// Symbology ID
	enum ESktCaptureSymbologyFlags Flags;						// Flags: Status  and/or Param
	enum ESktCaptureSymbologyStatus Status;						// Status: Disable, Enable or Not Supported
	TSktCaptureSymbologyParam Param;
	TSktCaptureString Name;								// Symbology name
}TSktCaptureSymbology;


// define a CaptureObject Property
typedef struct
{
	int ID;// property ID (defined in SktCapturePropIds.h)
	enum ESktCapturePropType Type;// define the type used in the following union
	union
	{
		unsigned char Byte;
		unsigned long Ulong;
		TSktCaptureArray Array;
		TSktCaptureString String;
		TSktCaptureVersion Version;
		//TSktCaptureEnum Enum;
		TSktCaptureSymbology Symbology;
        void* Object;
	}Value;
	// context can travel with the property,
	// so when a response is received,
	// the context is the one used in the original request
	void* Context;
}TSktCaptureProperty;

// defines an enumeration struture
typedef struct
{
	unsigned int nCurrentIndex;
	unsigned int nTotal;
	TSktCaptureProperty Property;
}TSktCaptureEnum;

// sample of a STRING GUID:"{D8DF7B22-6F5A-4f91-BF4F-C27E5BB8D286}"
#define kSktCaptureStringGuidSize		39 // including the null character and {}s
typedef char SKTSTRINGGUID [kSktCaptureStringGuidSize];

typedef struct
{
	enum ESktCaptureEventID ID;
	TSktEventData Data;
}TSktCaptureEvent;

typedef struct
{
	char szDeviceName[kSktCaptureDeviceNameSize];
	SKTHANDLE hDevice;
	unsigned long DeviceType;
	SKTSTRINGGUID Guid;
}TSktCaptureDevice;

// defines CaptureObject struture
// CaptureObject is used to exchange data
// between Application and Capture or a device
// by using the Set/Get/Wait API
typedef struct
{
	struct{
		enum ESktCaptureMsgID MsgID;// message ID received as asynchronous event
		SKTRESULT Result;// result of a complete message
		TSktCaptureDevice Device;
		TSktCaptureEvent Event;
	}Msg;
	TSktCaptureProperty Property;
}TSktCaptureObject;

extern const char* kSktCaptureSoftScanContext;
extern const char* kSktCaptureSoftScanLayoutId;
extern const char* kSktCaptureSoftScanViewFinderId;
extern const char* kSktCaptureSoftScanFlashButtonId;
extern const char* kSktCaptureSoftScanCancelButton;
extern const char* kSktCaptureSoftScanFlashButton;
extern const char* kSktCaptureSoftScanDirectionText;
extern const char* kSktCaptureSoftScanBackgroundColor;
extern const char* kSktCaptureSoftScanTextColor;
extern const char* kSktCaptureSoftScanCamera;



#endif // _SktCaptureTypes_h
