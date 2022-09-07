/**
Device Types definitions
PLEASE DO NOT MODIFY THIS AUTO GENERATED FILE
*/

// ignore_for_file: non_constant_identifier_names
/// Differentiate between devices and device managers.
class CaptureDeviceTypeClass {

	/// the class is a device
	/// value: 0 (0x00000)
	
	static const int deviceClass = 0;


	/// the class is a device manager
	/// value: 1 (0x00001)
	
	static const int deviceManagerClass = 1;

}

/// Differentiate between types of interfaces (bluetooth, NFC, etc).
class CaptureDeviceTypeInterface {

	/// no interface
	/// value: 0 (0x00000)
	
	static const int none = 0;


	/// SD interface
	/// value: 1 (0x00001)
	
	static const int sD = 1;


	/// CF interface
	/// value: 2 (0x00002)
	
	static const int cF = 2;


	/// Bluetooth interface
	/// value: 3 (0x00003)
	
	static const int bluetooth = 3;


	/// Serial interface
	/// value: 4 (0x00004)
	
	static const int serial = 4;


	/// Bluetooth Low Energy interface
	/// value: 5 (0x00005)
	
	static const int ble = 5;


	/// NFC
	/// value: 6 (0x00006)
	
	static const int nFC = 6;

}

/// Differentiate between types of devices (Model 7, NFC tag, etc).
class CaptureDeviceType {
	///no device type (initial value)
	///value: 0 (0x00000)
	static const int none = 0;

	///Model 7
	///value: 196609 (0x30001)
	static const int scanner7 = 196609;

	///Model 7X
	///value: 196610 (0x30002)
	static const int scanner7x = 196610;

	///Model 7Xi
	///value: 196612 (0x30004)
	static const int scanner7xi = 196612;

	///Model 9 CRS
	///value: 196611 (0x30003)
	static const int scanner9 = 196611;

	///SocketCam C820 (only used in iOS and Android)
	///value: 5 (0x00005)
	static const int socketCamC820 = 5;

	///Model S800
	///value: 196614 (0x30006)
	static const int scannerS800 = 196614;

	///Model S820
	///value: 196634 (0x3001A)
	static const int scannerS820 = 196634;

	///Model S850
	///value: 196615 (0x30007)
	static const int scannerS850 = 196615;

	///Model S840
	///value: 196616 (0x30008)
	static const int scannerS840 = 196616;

	///Model D700
	///value: 196617 (0x30009)
	static const int scannerD700 = 196617;

	///Model D720
	///value: 196633 (0x30019)
	static const int scannerD720 = 196633;

	///Model D730
	///value: 196618 (0x3000A)
	static const int scannerD730 = 196618;

	///Model D740
	///value: 196619 (0x3000B)
	static const int scannerD740 = 196619;

	///Model D750
	///value: 196620 (0x3000C)
	static const int scannerD750 = 196620;

	///Model D760
	///value: 196621 (0x3000D)
	static const int scannerD760 = 196621;

	///Model S700
	///value: 196622 (0x3000E)
	static const int scannerS700 = 196622;

	///Model S720
	///value: 196632 (0x30018)
	static const int scannerS720 = 196632;

	///Model S730
	///value: 196623 (0x3000F)
	static const int scannerS730 = 196623;

	///Model S740
	///value: 196624 (0x30010)
	static const int scannerS740 = 196624;

	///Model S750
	///value: 196625 (0x30011)
	static const int scannerS750 = 196625;

	///Model S760
	///value: 196626 (0x30012)
	static const int scannerS760 = 196626;

	///Model S860
	///value: 196627 (0x30013)
	static const int scannerS860 = 196627;

	///Model D790
	///value: 196628 (0x30014)
	static const int scannerD790 = 196628;

	///Model D600
	///value: 327701 (0x50015)
	static const int scannerD600 = 327701;

	///Model S550
	///value: 327702 (0x50016)
	static const int scannerS550 = 327702;

	///Model S370
	///value: 327707 (0x5001B)
	static const int scannerS370 = 327707;

	///Model S320
	///value: 327708 (0x5001C)
	static const int scannerS320 = 327708;

	///NFC Tag
	///value: 393239 (0x60017)
	static const int nFCTag = 393239;

	///device type unknown by this version of Capture
	///value: 196637 (0x3001D)
	static const int btUnknown = 196637;

	///device manager for controlling BLE
	///value: 17104897 (0x1050001)
	static const int deviceManagerBle = 17104897;

}
