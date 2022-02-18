/**
  @file CaptureDataSource.ts
  @brief Define the Data Source object in Capture

  @copyright © 2022 Socket Mobile, Inc.

 */

/**

 @brief idenfity a barcode symbology or a RFID/NFC Tag

 */
export class CaptureDataSourceID {
	// the data source ID is not specified or initialized
	static readonly NotSpecified = 0;

	// the barcode symbology for Australia post
	static readonly SymbologyAustraliaPost = 1;

	// the barcode symbology Aztec
	static readonly SymbologyAztec = 2;

	// the barcode symbology Bookland EAN
	static readonly SymbologyBooklandEan = 3;

	// the barcode symbology for British post
	static readonly SymbologyBritishPost = 4;

	// the barcode symbology for Canada post
	static readonly SymbologyCanadaPost = 5;

	// the barcode symbology Chinese 2 of 5
	static readonly SymbologyChinese2of5 = 6;

	// the barcode symbology Codabar
	static readonly SymbologyCodabar = 7;

	// the barcode symbology Codablock A
	static readonly SymbologyCodablockA = 8;

	// the barcode symbology Codablock F
	static readonly SymbologyCodablockF = 9;

	// the barcode symbology Code 11
	static readonly SymbologyCode11 = 10;

	// the barcode symbology Code 39
	static readonly SymbologyCode39 = 11;

	// the barcode symbology Code 39 Extended
	static readonly SymbologyCode39Extended = 12;

	// the barcode symbology Code 39 Trioptic
	static readonly SymbologyCode39Trioptic = 13;

	// the barcode symbology Code 93
	static readonly SymbologyCode93 = 14;

	// the barcode symbology Code 128
	static readonly SymbologyCode128 = 15;

	// the barcode symbology DataMatrix
	static readonly SymbologyDataMatrix = 16;

	// the barcode symbology for Dutch post
	static readonly SymbologyDutchPost = 17;

	// the barcode symbology EAN 8
	static readonly SymbologyEan8 = 18;

	// the barcode symbology EAN 13
	static readonly SymbologyEan13 = 19;

	// the barcode symbology EAN 128
	static readonly SymbologyEan128 = 20;

	// the barcode symbology EAN 128 Irregular
	static readonly SymbologyEan128Irregular = 21;

	// the barcode symbology EAN UCC Composite AB
	static readonly SymbologyEanUccCompositeAB = 22;

	// the barcode symbology EAN UCC Composite C
	static readonly SymbologyEanUccCompositeC = 23;

	// the barcode symbology GS1 Databar
	static readonly SymbologyGs1Databar = 24;

	// the barcode symbology GS1 Databar Limited
	static readonly SymbologyGs1DatabarLimited = 25;

	// the barcode symbology GS1 Databar Expanded
	static readonly SymbologyGs1DatabarExpanded = 26;

	// the barcode symbology Interleaved 2 of 5
	static readonly SymbologyInterleaved2of5 = 27;

	// the barcode symbology ISBT 128
	static readonly SymbologyIsbt128 = 28;

	// the barcode symbology for Japan post
	static readonly SymbologyJapanPost = 29;

	// the barcode symbology Matrix 2 of 5
	static readonly SymbologyMatrix2of5 = 30;

	// the barcode symbology Maxi Code
	static readonly SymbologyMaxicode = 31;

	// the barcode symbology MSI
	static readonly SymbologyMsi = 32;

	// the barcode symbology PDF 417
	static readonly SymbologyPdf417 = 33;

	// the barcode symbology PDF 417 Micro
	static readonly SymbologyPdf417Micro = 34;

	// the barcode symbology Planet
	static readonly SymbologyPlanet = 35;

	// the barcode symbology Plessey
	static readonly SymbologyPlessey = 36;

	// the barcode symbology Postnet
	static readonly SymbologyPostnet = 37;

	// the barcode symbology QR Code
	static readonly SymbologyQRCode = 38;

	// the barcode symbology Standard 2 of 5
	static readonly SymbologyStandard2of5 = 39;

	// the barcode symbology Telepen
	static readonly SymbologyTelepen = 40;

	// the barcode symbology TLC 39
	static readonly SymbologyTlc39 = 41;

	// the barcode symbology UPC A
	static readonly SymbologyUpcA = 42;

	// the barcode symbology UPC E0
	static readonly SymbologyUpcE0 = 43;

	// the barcode symbology UPC E1
	static readonly SymbologyUpcE1 = 44;

	// the barcode symbology USPS Intelligent Mail
	static readonly SymbologyUspsIntelligentMail = 45;

	// the barcode symbology Direct Part Marking
	static readonly SymbologyDirectPartMarking = 46;

	// the barcode symbology Han Xin
	static readonly SymbologyHanXin = 47;

	// the barcode symbology DotCode
	static readonly SymbologyDotCode = 48;

	// the barcode symbology Digimarc
	static readonly SymbologyDigimarc = 49;

	// the last barcode symbology ID, not an actual barcode symbology
	static readonly LastSymbologyID = 50;

	// the RFID Tag Type ISO 14443 A
	static readonly TagTypeISO14443TypeA = 256;

	// the RFID Tag Type ISO 14443 B
	static readonly TagTypeISO14443TypeB = 257;

	// the RFID Tag Type Felica
	static readonly TagTypeFelica = 258;

	// the RFID Tag Type ISO 15693
	static readonly TagTypeISO15693 = 259;

	// the RFID Tag Type NXPI Code 1
	static readonly TagTypeNXPICODE1 = 260;

	// the RFID Tag Type Inside Secure Pico Tag
	static readonly TagTypeInsideSecurePicoTag = 261;

	// the RFID Tag Type Innovision Topaz Jewel
	static readonly TagTypeInnovisionTopazJewel = 262;

	// the RFID Tag Type Thin Film NFC Barcode
	static readonly TagTypeThinfilmNFCBarcode = 263;

	// the RFID Tag Type ST Micro Electronics SR
	static readonly TagTypeSTMicroElectronicsSR = 264;

	// the RFID Tag Type ASK CTS 256B or CTS 512B
	static readonly TagTypeASKCTS256BOrCTS512B = 265;

	// the RFID Tag Type NFC Forum
	static readonly TagTypeNFCForum = 266;

	// the RFID Tag Type Innovatron Radio Protocol
	static readonly TagTypeInnovatronRadioProtocol = 267;

	// the last RFID tag type, not an actual tag type
	static readonly TagTypeLastTagType = 268;

};


/**

 @brief define the data source status

 */
export class CaptureDataSourceStatus {
	// the data source status is disabled
	static readonly Disable = 0;

	// the data source status is enabled
	static readonly Enable = 1;

	// the data source is not supported
	static readonly NotSupported = 2;

};


/**

 @brief define the flag value of a data source structure

 */
export class CaptureDataSourceFlags {
	// the data source contains a status
	static readonly Status = 1;

	// the data source contains some parameters
	static readonly Param = 2;

};

