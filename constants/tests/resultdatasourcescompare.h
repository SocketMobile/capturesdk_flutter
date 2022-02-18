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

// Data Source IDs
enum ESktCaptureDataSourceID{
	///<summary>
	/// the data source ID is not specified or initialized
	///</summary>
	kSktCaptureNotSpecified = 0,
	///<summary>
	/// the barcode symbology for Australia post
	///</summary>
	kSktCaptureSymbologyAustraliaPost = 1,
	///<summary>
	/// the barcode symbology Aztec
	///</summary>
	kSktCaptureSymbologyAztec = 2,
	///<summary>
	/// the barcode symbology Bookland EAN
	///</summary>
	kSktCaptureSymbologyBooklandEan = 3,
	///<summary>
	/// the barcode symbology for British post
	///</summary>
	kSktCaptureSymbologyBritishPost = 4,
	///<summary>
	/// the barcode symbology for Canada post
	///</summary>
	kSktCaptureSymbologyCanadaPost = 5,
	///<summary>
	/// the barcode symbology Chinese 2 of 5
	///</summary>
	kSktCaptureSymbologyChinese2of5 = 6,
	///<summary>
	/// the barcode symbology Codabar
	///</summary>
	kSktCaptureSymbologyCodabar = 7,
	///<summary>
	/// the barcode symbology Codablock A
	///</summary>
	kSktCaptureSymbologyCodablockA = 8,
	///<summary>
	/// the barcode symbology Codablock F
	///</summary>
	kSktCaptureSymbologyCodablockF = 9,
	///<summary>
	/// the barcode symbology Code 11
	///</summary>
	kSktCaptureSymbologyCode11 = 10,
	///<summary>
	/// the barcode symbology Code 39
	///</summary>
	kSktCaptureSymbologyCode39 = 11,
	///<summary>
	/// the barcode symbology Code 39 Extended
	///</summary>
	kSktCaptureSymbologyCode39Extended = 12,
	///<summary>
	/// the barcode symbology Code 39 Trioptic
	///</summary>
	kSktCaptureSymbologyCode39Trioptic = 13,
	///<summary>
	/// the barcode symbology Code 93
	///</summary>
	kSktCaptureSymbologyCode93 = 14,
	///<summary>
	/// the barcode symbology Code 128
	///</summary>
	kSktCaptureSymbologyCode128 = 15,
	///<summary>
	/// the barcode symbology DataMatrix
	///</summary>
	kSktCaptureSymbologyDataMatrix = 16,
	///<summary>
	/// the barcode symbology for Dutch post
	///</summary>
	kSktCaptureSymbologyDutchPost = 17,
	///<summary>
	/// the barcode symbology EAN 8
	///</summary>
	kSktCaptureSymbologyEan8 = 18,
	///<summary>
	/// the barcode symbology EAN 13
	///</summary>
	kSktCaptureSymbologyEan13 = 19,
	///<summary>
	/// the barcode symbology EAN 128
	///</summary>
	kSktCaptureSymbologyEan128 = 20,
	///<summary>
	/// the barcode symbology EAN 128 Irregular
	///</summary>
	kSktCaptureSymbologyEan128Irregular = 21,
	///<summary>
	/// the barcode symbology EAN UCC Composite AB
	///</summary>
	kSktCaptureSymbologyEanUccCompositeAB = 22,
	///<summary>
	/// the barcode symbology EAN UCC Composite C
	///</summary>
	kSktCaptureSymbologyEanUccCompositeC = 23,
	///<summary>
	/// the barcode symbology GS1 Databar
	///</summary>
	kSktCaptureSymbologyGs1Databar = 24,
	///<summary>
	/// the barcode symbology GS1 Databar Limited
	///</summary>
	kSktCaptureSymbologyGs1DatabarLimited = 25,
	///<summary>
	/// the barcode symbology GS1 Databar Expanded
	///</summary>
	kSktCaptureSymbologyGs1DatabarExpanded = 26,
	///<summary>
	/// the barcode symbology Interleaved 2 of 5
	///</summary>
	kSktCaptureSymbologyInterleaved2of5 = 27,
	///<summary>
	/// the barcode symbology ISBT 128
	///</summary>
	kSktCaptureSymbologyIsbt128 = 28,
	///<summary>
	/// the barcode symbology for Japan post
	///</summary>
	kSktCaptureSymbologyJapanPost = 29,
	///<summary>
	/// the barcode symbology Matrix 2 of 5
	///</summary>
	kSktCaptureSymbologyMatrix2of5 = 30,
	///<summary>
	/// the barcode symbology Maxi Code
	///</summary>
	kSktCaptureSymbologyMaxicode = 31,
	///<summary>
	/// the barcode symbology MSI
	///</summary>
	kSktCaptureSymbologyMsi = 32,
	///<summary>
	/// the barcode symbology PDF 417
	///</summary>
	kSktCaptureSymbologyPdf417 = 33,
	///<summary>
	/// the barcode symbology PDF 417 Micro
	///</summary>
	kSktCaptureSymbologyPdf417Micro = 34,
	///<summary>
	/// the barcode symbology Planet
	///</summary>
	kSktCaptureSymbologyPlanet = 35,
	///<summary>
	/// the barcode symbology Plessey
	///</summary>
	kSktCaptureSymbologyPlessey = 36,
	///<summary>
	/// the barcode symbology Postnet
	///</summary>
	kSktCaptureSymbologyPostnet = 37,
	///<summary>
	/// the barcode symbology QR Code
	///</summary>
	kSktCaptureSymbologyQRCode = 38,
	///<summary>
	/// the barcode symbology Standard 2 of 5
	///</summary>
	kSktCaptureSymbologyStandard2of5 = 39,
	///<summary>
	/// the barcode symbology Telepen
	///</summary>
	kSktCaptureSymbologyTelepen = 40,
	///<summary>
	/// the barcode symbology TLC 39
	///</summary>
	kSktCaptureSymbologyTlc39 = 41,
	///<summary>
	/// the barcode symbology UPC A
	///</summary>
	kSktCaptureSymbologyUpcA = 42,
	///<summary>
	/// the barcode symbology UPC E0
	///</summary>
	kSktCaptureSymbologyUpcE0 = 43,
	///<summary>
	/// the barcode symbology UPC E1
	///</summary>
	kSktCaptureSymbologyUpcE1 = 44,
	///<summary>
	/// the barcode symbology USPS Intelligent Mail
	///</summary>
	kSktCaptureSymbologyUspsIntelligentMail = 45,
	///<summary>
	/// the barcode symbology Direct Part Marking
	///</summary>
	kSktCaptureSymbologyDirectPartMarking = 46,
	///<summary>
	/// the barcode symbology Han Xin
	///</summary>
	kSktCaptureSymbologyHanXin = 47,
	///<summary>
	/// the barcode symbology DotCode
	///</summary>
	kSktCaptureSymbologyDotCode = 48,
	///<summary>
	/// the barcode symbology Digimarc
	///</summary>
	kSktCaptureSymbologyDigimarc = 49,
	///<summary>
	/// the last barcode symbology ID, not an actual barcode symbology
	///</summary>
	kSktCaptureLastSymbologyID = 50,
	///<summary>
	/// the RFID Tag Type ISO 14443 A
	///</summary>
	kSktCaptureTagTypeISO14443TypeA = 256,
	///<summary>
	/// the RFID Tag Type ISO 14443 B
	///</summary>
	kSktCaptureTagTypeISO14443TypeB = 257,
	///<summary>
	/// the RFID Tag Type Felica
	///</summary>
	kSktCaptureTagTypeFelica = 258,
	///<summary>
	/// the RFID Tag Type ISO 15693
	///</summary>
	kSktCaptureTagTypeISO15693 = 259,
	///<summary>
	/// the RFID Tag Type NXPI Code 1
	///</summary>
	kSktCaptureTagTypeNXPICODE1 = 260,
	///<summary>
	/// the RFID Tag Type Inside Secure Pico Tag
	///</summary>
	kSktCaptureTagTypeInsideSecurePicoTag = 261,
	///<summary>
	/// the RFID Tag Type Innovision Topaz Jewel
	///</summary>
	kSktCaptureTagTypeInnovisionTopazJewel = 262,
	///<summary>
	/// the RFID Tag Type Thin Film NFC Barcode
	///</summary>
	kSktCaptureTagTypeThinfilmNFCBarcode = 263,
	///<summary>
	/// the RFID Tag Type ST Micro Electronics SR
	///</summary>
	kSktCaptureTagTypeSTMicroElectronicsSR = 264,
	///<summary>
	/// the RFID Tag Type ASK CTS 256B or CTS 512B
	///</summary>
	kSktCaptureTagTypeASKCTS256BOrCTS512B = 265,
	///<summary>
	/// the RFID Tag Type NFC Forum
	///</summary>
	kSktCaptureTagTypeNFCForum = 266,
	///<summary>
	/// the RFID Tag Type Innovatron Radio Protocol
	///</summary>
	kSktCaptureTagTypeInnovatronRadioProtocol = 267,
	///<summary>
	/// the last RFID tag type, not an actual tag type
	///</summary>
	kSktCaptureTagTypeLastTagType = 268,
};



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

// identifies what the Data Source struct contains
enum ESktCaptureDataSourceFlags{
	///<summary>
	/// the data source contains a status
	///</summary>
	kSktCaptureDataSourceStatus = 1,
	///<summary>
	/// the data source contains some parameters
	///</summary>
	kSktCaptureDataSourceParam = 2,
};



// identifies the status of a Data Source
enum ESktCaptureDataSourceStatus{
	///<summary>
	/// the data source status is disabled
	///</summary>
	kSktCaptureDataSourceDisable = 0,
	///<summary>
	/// the data source status is enabled
	///</summary>
	kSktCaptureDataSourceEnable = 1,
	///<summary>
	/// the data source is not supported
	///</summary>
	kSktCaptureDataSourceNotSupported = 2,
};




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
