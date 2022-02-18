/**
  This is the definition of the Data Sources supported by Capture

  2018 © Socket Mobile, Inc. all rights reserved
*/

using System;

namespace SocketMobile
{
    namespace Capture
    {
        /// <summary>
        /// defines a symbology
        /// </summary>
        public abstract class ICaptureSymbology
        {
            /// <summary>
            /// ID of the symbology
            /// </summary>
            public abstract int ID { get; set; }
            /// <summary>
            /// Flags to know if the Param property is used
            /// </summary>
            public abstract int Flags { get; set; }
            /// <summary>
            /// Current status of a symbology
            /// </summary>
            public abstract int Status { get; set; }
            /// <summary>
            /// Parameters of a symbology (reserved for future use)
            /// </summary>
            public abstract int Param { get; set; }
            /// <summary>
            /// Name of the Symbology
            /// </summary>
            public abstract String Name { get; }

            /// <summary>
/// defines the Data Source IDs used in Capture
/// </summary>
public class Id
{
	/// <summary>
	/// the data source ID is not specified or initialized
	/// </summary>
	public const int kNotSpecified = 0;

	/// <summary>
	/// the barcode symbology for Australia post
	/// </summary>
	public const int kSymbologyAustraliaPost = 1;

	/// <summary>
	/// the barcode symbology Aztec
	/// </summary>
	public const int kSymbologyAztec = 2;

	/// <summary>
	/// the barcode symbology Bookland EAN
	/// </summary>
	public const int kSymbologyBooklandEan = 3;

	/// <summary>
	/// the barcode symbology for British post
	/// </summary>
	public const int kSymbologyBritishPost = 4;

	/// <summary>
	/// the barcode symbology for Canada post
	/// </summary>
	public const int kSymbologyCanadaPost = 5;

	/// <summary>
	/// the barcode symbology Chinese 2 of 5
	/// </summary>
	public const int kSymbologyChinese2of5 = 6;

	/// <summary>
	/// the barcode symbology Codabar
	/// </summary>
	public const int kSymbologyCodabar = 7;

	/// <summary>
	/// the barcode symbology Codablock A
	/// </summary>
	public const int kSymbologyCodablockA = 8;

	/// <summary>
	/// the barcode symbology Codablock F
	/// </summary>
	public const int kSymbologyCodablockF = 9;

	/// <summary>
	/// the barcode symbology Code 11
	/// </summary>
	public const int kSymbologyCode11 = 10;

	/// <summary>
	/// the barcode symbology Code 39
	/// </summary>
	public const int kSymbologyCode39 = 11;

	/// <summary>
	/// the barcode symbology Code 39 Extended
	/// </summary>
	public const int kSymbologyCode39Extended = 12;

	/// <summary>
	/// the barcode symbology Code 39 Trioptic
	/// </summary>
	public const int kSymbologyCode39Trioptic = 13;

	/// <summary>
	/// the barcode symbology Code 93
	/// </summary>
	public const int kSymbologyCode93 = 14;

	/// <summary>
	/// the barcode symbology Code 128
	/// </summary>
	public const int kSymbologyCode128 = 15;

	/// <summary>
	/// the barcode symbology DataMatrix
	/// </summary>
	public const int kSymbologyDataMatrix = 16;

	/// <summary>
	/// the barcode symbology for Dutch post
	/// </summary>
	public const int kSymbologyDutchPost = 17;

	/// <summary>
	/// the barcode symbology EAN 8
	/// </summary>
	public const int kSymbologyEan8 = 18;

	/// <summary>
	/// the barcode symbology EAN 13
	/// </summary>
	public const int kSymbologyEan13 = 19;

	/// <summary>
	/// the barcode symbology EAN 128
	/// </summary>
	public const int kSymbologyEan128 = 20;

	/// <summary>
	/// the barcode symbology EAN 128 Irregular
	/// </summary>
	public const int kSymbologyEan128Irregular = 21;

	/// <summary>
	/// the barcode symbology EAN UCC Composite AB
	/// </summary>
	public const int kSymbologyEanUccCompositeAB = 22;

	/// <summary>
	/// the barcode symbology EAN UCC Composite C
	/// </summary>
	public const int kSymbologyEanUccCompositeC = 23;

	/// <summary>
	/// the barcode symbology GS1 Databar
	/// </summary>
	public const int kSymbologyGs1Databar = 24;

	/// <summary>
	/// the barcode symbology GS1 Databar Limited
	/// </summary>
	public const int kSymbologyGs1DatabarLimited = 25;

	/// <summary>
	/// the barcode symbology GS1 Databar Expanded
	/// </summary>
	public const int kSymbologyGs1DatabarExpanded = 26;

	/// <summary>
	/// the barcode symbology Interleaved 2 of 5
	/// </summary>
	public const int kSymbologyInterleaved2of5 = 27;

	/// <summary>
	/// the barcode symbology ISBT 128
	/// </summary>
	public const int kSymbologyIsbt128 = 28;

	/// <summary>
	/// the barcode symbology for Japan post
	/// </summary>
	public const int kSymbologyJapanPost = 29;

	/// <summary>
	/// the barcode symbology Matrix 2 of 5
	/// </summary>
	public const int kSymbologyMatrix2of5 = 30;

	/// <summary>
	/// the barcode symbology Maxi Code
	/// </summary>
	public const int kSymbologyMaxicode = 31;

	/// <summary>
	/// the barcode symbology MSI
	/// </summary>
	public const int kSymbologyMsi = 32;

	/// <summary>
	/// the barcode symbology PDF 417
	/// </summary>
	public const int kSymbologyPdf417 = 33;

	/// <summary>
	/// the barcode symbology PDF 417 Micro
	/// </summary>
	public const int kSymbologyPdf417Micro = 34;

	/// <summary>
	/// the barcode symbology Planet
	/// </summary>
	public const int kSymbologyPlanet = 35;

	/// <summary>
	/// the barcode symbology Plessey
	/// </summary>
	public const int kSymbologyPlessey = 36;

	/// <summary>
	/// the barcode symbology Postnet
	/// </summary>
	public const int kSymbologyPostnet = 37;

	/// <summary>
	/// the barcode symbology QR Code
	/// </summary>
	public const int kSymbologyQRCode = 38;

	/// <summary>
	/// the barcode symbology Standard 2 of 5
	/// </summary>
	public const int kSymbologyStandard2of5 = 39;

	/// <summary>
	/// the barcode symbology Telepen
	/// </summary>
	public const int kSymbologyTelepen = 40;

	/// <summary>
	/// the barcode symbology TLC 39
	/// </summary>
	public const int kSymbologyTlc39 = 41;

	/// <summary>
	/// the barcode symbology UPC A
	/// </summary>
	public const int kSymbologyUpcA = 42;

	/// <summary>
	/// the barcode symbology UPC E0
	/// </summary>
	public const int kSymbologyUpcE0 = 43;

	/// <summary>
	/// the barcode symbology UPC E1
	/// </summary>
	public const int kSymbologyUpcE1 = 44;

	/// <summary>
	/// the barcode symbology USPS Intelligent Mail
	/// </summary>
	public const int kSymbologyUspsIntelligentMail = 45;

	/// <summary>
	/// the barcode symbology Direct Part Marking
	/// </summary>
	public const int kSymbologyDirectPartMarking = 46;

	/// <summary>
	/// the barcode symbology Han Xin
	/// </summary>
	public const int kSymbologyHanXin = 47;

	/// <summary>
	/// the barcode symbology DotCode
	/// </summary>
	public const int kSymbologyDotCode = 48;

	/// <summary>
	/// the barcode symbology Digimarc
	/// </summary>
	public const int kSymbologyDigimarc = 49;

	/// <summary>
	/// the last barcode symbology ID, not an actual barcode symbology
	/// </summary>
	public const int kLastSymbologyID = 50;

	/// <summary>
	/// the RFID Tag Type ISO 14443 A
	/// </summary>
	public const int kTagTypeISO14443TypeA = 256;

	/// <summary>
	/// the RFID Tag Type ISO 14443 B
	/// </summary>
	public const int kTagTypeISO14443TypeB = 257;

	/// <summary>
	/// the RFID Tag Type Felica
	/// </summary>
	public const int kTagTypeFelica = 258;

	/// <summary>
	/// the RFID Tag Type ISO 15693
	/// </summary>
	public const int kTagTypeISO15693 = 259;

	/// <summary>
	/// the RFID Tag Type NXPI Code 1
	/// </summary>
	public const int kTagTypeNXPICODE1 = 260;

	/// <summary>
	/// the RFID Tag Type Inside Secure Pico Tag
	/// </summary>
	public const int kTagTypeInsideSecurePicoTag = 261;

	/// <summary>
	/// the RFID Tag Type Innovision Topaz Jewel
	/// </summary>
	public const int kTagTypeInnovisionTopazJewel = 262;

	/// <summary>
	/// the RFID Tag Type Thin Film NFC Barcode
	/// </summary>
	public const int kTagTypeThinfilmNFCBarcode = 263;

	/// <summary>
	/// the RFID Tag Type ST Micro Electronics SR
	/// </summary>
	public const int kTagTypeSTMicroElectronicsSR = 264;

	/// <summary>
	/// the RFID Tag Type ASK CTS 256B or CTS 512B
	/// </summary>
	public const int kTagTypeASKCTS256BOrCTS512B = 265;

	/// <summary>
	/// the RFID Tag Type NFC Forum
	/// </summary>
	public const int kTagTypeNFCForum = 266;

	/// <summary>
	/// the RFID Tag Type Innovatron Radio Protocol
	/// </summary>
	public const int kTagTypeInnovatronRadioProtocol = 267;

	/// <summary>
	/// the last RFID tag type, not an actual tag type
	/// </summary>
	public const int kTagTypeLastTagType = 268;

};



            /// <summary>
/// defines the Data Source Flags used in a Capture Data Source
/// </summary>
public class FlagsMask
{
	/// <summary>
	/// the data source contains a status
	/// </summary>
	public const int kStatus = 1;

	/// <summary>
	/// the data source contains some parameters
	/// </summary>
	public const int kParam = 2;

};



            /// <summary>
/// defines the Data Source Status used in Capture
/// </summary>
public class StatusValues
{
	/// <summary>
	/// the data source status is disabled
	/// </summary>
	public const int kDisable = 0;

	/// <summary>
	/// the data source status is enabled
	/// </summary>
	public const int kEnable = 1;

	/// <summary>
	/// the data source is not supported
	/// </summary>
	public const int kNotSupported = 2;

};


          }
      }
  }
  
