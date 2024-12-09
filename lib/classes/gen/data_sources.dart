// @file CaptureDataSource.dart
// @brief Define the Data Source object in Capture
// @copyright © 2017 Socket Mobile, Inc.

// @brief idenfity a barcode symbology or a RFID/NFC Tag

/// Generated datasource information for data in capture events.
class CaptureDataSourceID {
	/// the data source ID is not specified or initialized
	static const int notSpecified = 0;

	/// the barcode symbology for Australia post
	static const int symbologyAustraliaPost = 1;

	/// the barcode symbology Aztec
	static const int symbologyAztec = 2;

	/// the barcode symbology Bookland EAN
	static const int symbologyBooklandEan = 3;

	/// the barcode symbology for British post
	static const int symbologyBritishPost = 4;

	/// the barcode symbology for Canada post
	static const int symbologyCanadaPost = 5;

	/// the barcode symbology Chinese 2 of 5
	static const int symbologyChinese2of5 = 6;

	/// the barcode symbology Codabar
	static const int symbologyCodabar = 7;

	/// the barcode symbology Codablock A
	static const int symbologyCodablockA = 8;

	/// the barcode symbology Codablock F
	static const int symbologyCodablockF = 9;

	/// the barcode symbology Code 11
	static const int symbologyCode11 = 10;

	/// the barcode symbology Code 39
	static const int symbologyCode39 = 11;

	/// the barcode symbology Code 39 Extended
	static const int symbologyCode39Extended = 12;

	/// the barcode symbology Code 39 Trioptic
	static const int symbologyCode39Trioptic = 13;

	/// the barcode symbology Code 93
	static const int symbologyCode93 = 14;

	/// the barcode symbology Code 128
	static const int symbologyCode128 = 15;

	/// the barcode symbology DataMatrix
	static const int symbologyDataMatrix = 16;

	/// the barcode symbology for Dutch post
	static const int symbologyDutchPost = 17;

	/// the barcode symbology EAN 8
	static const int symbologyEan8 = 18;

	/// the barcode symbology EAN 13
	static const int symbologyEan13 = 19;

	/// the barcode symbology EAN 128
	static const int symbologyEan128 = 20;

	/// the barcode symbology EAN 128 Irregular
	static const int symbologyEan128Irregular = 21;

	/// the barcode symbology EAN UCC Composite AB
	static const int symbologyEanUccCompositeAB = 22;

	/// the barcode symbology EAN UCC Composite C
	static const int symbologyEanUccCompositeC = 23;

	/// the barcode symbology GS1 Databar
	static const int symbologyGs1Databar = 24;

	/// the barcode symbology GS1 Databar Limited
	static const int symbologyGs1DatabarLimited = 25;

	/// the barcode symbology GS1 Databar Expanded
	static const int symbologyGs1DatabarExpanded = 26;

	/// the barcode symbology Interleaved 2 of 5
	static const int symbologyInterleaved2of5 = 27;

	/// the barcode symbology ISBT 128
	static const int symbologyIsbt128 = 28;

	/// the barcode symbology for Japan post
	static const int symbologyJapanPost = 29;

	/// the barcode symbology Matrix 2 of 5
	static const int symbologyMatrix2of5 = 30;

	/// the barcode symbology Maxi Code
	static const int symbologyMaxicode = 31;

	/// the barcode symbology MSI
	static const int symbologyMsi = 32;

	/// the barcode symbology PDF 417
	static const int symbologyPdf417 = 33;

	/// the barcode symbology PDF 417 Micro
	static const int symbologyPdf417Micro = 34;

	/// the barcode symbology Planet
	static const int symbologyPlanet = 35;

	/// the barcode symbology Plessey
	static const int symbologyPlessey = 36;

	/// the barcode symbology Postnet
	static const int symbologyPostnet = 37;

	/// the barcode symbology QR Code
	static const int symbologyQRCode = 38;

	/// the barcode symbology Standard 2 of 5
	static const int symbologyStandard2of5 = 39;

	/// the barcode symbology Telepen
	static const int symbologyTelepen = 40;

	/// the barcode symbology TLC 39
	static const int symbologyTlc39 = 41;

	/// the barcode symbology UPC A
	static const int symbologyUpcA = 42;

	/// the barcode symbology UPC E0
	static const int symbologyUpcE0 = 43;

	/// the barcode symbology UPC E1
	static const int symbologyUpcE1 = 44;

	/// the barcode symbology USPS Intelligent Mail
	static const int symbologyUspsIntelligentMail = 45;

	/// the barcode symbology Direct Part Marking
	static const int symbologyDirectPartMarking = 46;

	/// the barcode symbology Han Xin
	static const int symbologyHanXin = 47;

	/// the barcode symbology DotCode
	static const int symbologyDotCode = 48;

	/// the barcode symbology Digimarc
	static const int symbologyDigimarc = 49;

	/// the barcode symbology Korea Post
	static const int symbologyKoreaPost = 50;

	/// the last barcode symbology ID, not an actual barcode symbology
	static const int lastSymbologyID = 51;

	/// the RFID Tag Type ISO 14443 A
	static const int tagTypeISO14443TypeA = 256;

	/// the RFID Tag Type ISO 14443 B
	static const int tagTypeISO14443TypeB = 257;

	/// the RFID Tag Type Felica
	static const int tagTypeFelica = 258;

	/// the RFID Tag Type ISO 15693
	static const int tagTypeISO15693 = 259;

	/// the RFID Tag Type NXPI Code 1
	static const int tagTypeNXPICODE1 = 260;

	/// the RFID Tag Type Inside Secure Pico Tag
	static const int tagTypeInsideSecurePicoTag = 261;

	/// the RFID Tag Type Innovision Topaz Jewel
	static const int tagTypeInnovisionTopazJewel = 262;

	/// the RFID Tag Type Thin Film NFC Barcode
	static const int tagTypeThinfilmNFCBarcode = 263;

	/// the RFID Tag Type ST Micro Electronics SR
	static const int tagTypeSTMicroElectronicsSR = 264;

	/// the RFID Tag Type ASK CTS 256B or CTS 512B
	static const int tagTypeASKCTS256BOrCTS512B = 265;

	/// the RFID Tag Type NFC Forum
	static const int tagTypeNFCForum = 266;

	/// the RFID Tag Type Innovatron Radio Protocol
	static const int tagTypeInnovatronRadioProtocol = 267;

	/// the last RFID tag type, not an actual tag type
	static const int tagTypeLastTagType = 268;

}


// @brief define the data source status

/// Status properties for data sources in capture events.
class CaptureDataSourceStatus {
	/// the data source status by default
	static const int defaultStatus = -1;

	/// the data source status is disabled
	static const int disable = 0;

	/// the data source status is enabled
	static const int enable = 1;

	/// the data source is not supported
	static const int notSupported = 2;

}


// @brief define the flag value of a data source structure

/// Flags for the different data sources in capture events.
class CaptureDataSourceFlags {
	/// the data source contains a status
	static const int status = 1;

	/// the data source contains some parameters
	static const int param = 2;

}

