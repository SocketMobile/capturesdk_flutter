// @file CaptureDataSource.dart
// @brief Define the Data Source object in Capture
// @copyright © 2017 Socket Mobile, Inc.

// @brief idenfity a barcode symbology or a RFID/NFC Tag

class CaptureDataSourceID {
	// the data source ID is not specified or initialized
	int notSpecified = 0;

	// the barcode symbology for Australia post
	int symbologyAustraliaPost = 1;

	// the barcode symbology Aztec
	int symbologyAztec = 2;

	// the barcode symbology Bookland EAN
	int symbologyBooklandEan = 3;

	// the barcode symbology for British post
	int symbologyBritishPost = 4;

	// the barcode symbology for Canada post
	int symbologyCanadaPost = 5;

	// the barcode symbology Chinese 2 of 5
	int symbologyChinese2of5 = 6;

	// the barcode symbology Codabar
	int symbologyCodabar = 7;

	// the barcode symbology Codablock A
	int symbologyCodablockA = 8;

	// the barcode symbology Codablock F
	int symbologyCodablockF = 9;

	// the barcode symbology Code 11
	int symbologyCode11 = 10;

	// the barcode symbology Code 39
	int symbologyCode39 = 11;

	// the barcode symbology Code 39 Extended
	int symbologyCode39Extended = 12;

	// the barcode symbology Code 39 Trioptic
	int symbologyCode39Trioptic = 13;

	// the barcode symbology Code 93
	int symbologyCode93 = 14;

	// the barcode symbology Code 128
	int symbologyCode128 = 15;

	// the barcode symbology DataMatrix
	int symbologyDataMatrix = 16;

	// the barcode symbology for Dutch post
	int symbologyDutchPost = 17;

	// the barcode symbology EAN 8
	int symbologyEan8 = 18;

	// the barcode symbology EAN 13
	int symbologyEan13 = 19;

	// the barcode symbology EAN 128
	int symbologyEan128 = 20;

	// the barcode symbology EAN 128 Irregular
	int symbologyEan128Irregular = 21;

	// the barcode symbology EAN UCC Composite AB
	int symbologyEanUccCompositeAB = 22;

	// the barcode symbology EAN UCC Composite C
	int symbologyEanUccCompositeC = 23;

	// the barcode symbology GS1 Databar
	int symbologyGs1Databar = 24;

	// the barcode symbology GS1 Databar Limited
	int symbologyGs1DatabarLimited = 25;

	// the barcode symbology GS1 Databar Expanded
	int symbologyGs1DatabarExpanded = 26;

	// the barcode symbology Interleaved 2 of 5
	int symbologyInterleaved2of5 = 27;

	// the barcode symbology ISBT 128
	int symbologyIsbt128 = 28;

	// the barcode symbology for Japan post
	int symbologyJapanPost = 29;

	// the barcode symbology Matrix 2 of 5
	int symbologyMatrix2of5 = 30;

	// the barcode symbology Maxi Code
	int symbologyMaxicode = 31;

	// the barcode symbology MSI
	int symbologyMsi = 32;

	// the barcode symbology PDF 417
	int symbologyPdf417 = 33;

	// the barcode symbology PDF 417 Micro
	int symbologyPdf417Micro = 34;

	// the barcode symbology Planet
	int symbologyPlanet = 35;

	// the barcode symbology Plessey
	int symbologyPlessey = 36;

	// the barcode symbology Postnet
	int symbologyPostnet = 37;

	// the barcode symbology QR Code
	int symbologyQRCode = 38;

	// the barcode symbology Standard 2 of 5
	int symbologyStandard2of5 = 39;

	// the barcode symbology Telepen
	int symbologyTelepen = 40;

	// the barcode symbology TLC 39
	int symbologyTlc39 = 41;

	// the barcode symbology UPC A
	int symbologyUpcA = 42;

	// the barcode symbology UPC E0
	int symbologyUpcE0 = 43;

	// the barcode symbology UPC E1
	int symbologyUpcE1 = 44;

	// the barcode symbology USPS Intelligent Mail
	int symbologyUspsIntelligentMail = 45;

	// the barcode symbology Direct Part Marking
	int symbologyDirectPartMarking = 46;

	// the barcode symbology Han Xin
	int symbologyHanXin = 47;

	// the barcode symbology DotCode
	int symbologyDotCode = 48;

	// the barcode symbology Digimarc
	int symbologyDigimarc = 49;

	// the last barcode symbology ID, not an actual barcode symbology
	int lastSymbologyID = 50;

	// the RFID Tag Type ISO 14443 A
	int tagTypeISO14443TypeA = 256;

	// the RFID Tag Type ISO 14443 B
	int tagTypeISO14443TypeB = 257;

	// the RFID Tag Type Felica
	int tagTypeFelica = 258;

	// the RFID Tag Type ISO 15693
	int tagTypeISO15693 = 259;

	// the RFID Tag Type NXPI Code 1
	int tagTypeNXPICODE1 = 260;

	// the RFID Tag Type Inside Secure Pico Tag
	int tagTypeInsideSecurePicoTag = 261;

	// the RFID Tag Type Innovision Topaz Jewel
	int tagTypeInnovisionTopazJewel = 262;

	// the RFID Tag Type Thin Film NFC Barcode
	int tagTypeThinfilmNFCBarcode = 263;

	// the RFID Tag Type ST Micro Electronics SR
	int tagTypeSTMicroElectronicsSR = 264;

	// the RFID Tag Type ASK CTS 256B or CTS 512B
	int tagTypeASKCTS256BOrCTS512B = 265;

	// the RFID Tag Type NFC Forum
	int tagTypeNFCForum = 266;

	// the RFID Tag Type Innovatron Radio Protocol
	int tagTypeInnovatronRadioProtocol = 267;

	// the last RFID tag type, not an actual tag type
	int tagTypeLastTagType = 268;

}


// @brief define the data source status

class CaptureDataSourceStatus {
	// the data source status is disabled
	int Disable = 0;

	// the data source status is enabled
	int Enable = 1;

	// the data source is not supported
	int NotSupported = 2;

}


// @brief define the flag value of a data source structure

class CaptureDataSourceFlags {
	// the data source contains a status
	int Status = 1;

	// the data source contains some parameters
	int Param = 2;

}

