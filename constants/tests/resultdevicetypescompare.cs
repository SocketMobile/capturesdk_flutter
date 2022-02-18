/**
  This is the definition of the Device Types supported by Capture

  2018 © Socket Mobile, Inc. all rights reserved
*/


/// <summary>
/// defines the Device Type Classes used in Capture
/// </summary>
public class DeviceTypeClasses
{
	///<summary>
	/// the class is a device
	/// value: 0 (0x00000)
	///</summary>
	public const int DeviceClass = 0;

	///<summary>
	/// the class is a device manager
	/// value: 1 (0x00001)
	///</summary>
	public const int DeviceManagerClass = 1;

};

/// <summary>
/// defines the Device Type Interfaces used in Capture
/// </summary>
public class DeviceTypeInterfaces
{
	///<summary>
	/// no interface
	/// value: 0 (0x00000)
	///</summary>
	public const int None = 0;

	///<summary>
	/// SD interface
	/// value: 1 (0x00001)
	///</summary>
	public const int SD = 1;

	///<summary>
	/// CF interface
	/// value: 2 (0x00002)
	///</summary>
	public const int CF = 2;

	///<summary>
	/// Bluetooth interface
	/// value: 3 (0x00003)
	///</summary>
	public const int Bluetooth = 3;

	///<summary>
	/// Serial interface
	/// value: 4 (0x00004)
	///</summary>
	public const int Serial = 4;

	///<summary>
	/// Bluetooth Low Energy interface
	/// value: 5 (0x00005)
	///</summary>
	public const int Ble = 5;

	///<summary>
	/// NFC
	/// value: 6 (0x00006)
	///</summary>
	public const int NFC = 6;

};

/// <summary>
/// defines the Device Type used in Capture
/// </summary>
public class DeviceTypes
{
	/// <summary>
	/// no device type (initial value)
	/// value: 0 (0x00000)
	/// </summary>
	public const int kNone = 0;

	/// <summary>
	/// Model 7
	/// value: 196609 (0x30001)
	/// </summary>
	public const int kScanner7 = 196609;

	/// <summary>
	/// Model 7X
	/// value: 196610 (0x30002)
	/// </summary>
	public const int kScanner7x = 196610;

	/// <summary>
	/// Model 7Xi
	/// value: 196612 (0x30004)
	/// </summary>
	public const int kScanner7xi = 196612;

	/// <summary>
	/// Model 9 CRS
	/// value: 196611 (0x30003)
	/// </summary>
	public const int kScanner9 = 196611;

	/// <summary>
	/// SoftScan (only used in iOS and Android)
	/// value: 5 (0x00005)
	/// </summary>
	public const int kSoftScan = 5;

	/// <summary>
	/// Model S800
	/// value: 196614 (0x30006)
	/// </summary>
	public const int kScannerS800 = 196614;

	/// <summary>
	/// Model S850
	/// value: 196615 (0x30007)
	/// </summary>
	public const int kScannerS850 = 196615;

	/// <summary>
	/// Model S840
	/// value: 196616 (0x30008)
	/// </summary>
	public const int kScannerS840 = 196616;

	/// <summary>
	/// Model D700
	/// value: 196617 (0x30009)
	/// </summary>
	public const int kScannerD700 = 196617;

	/// <summary>
	/// Model D730
	/// value: 196618 (0x3000A)
	/// </summary>
	public const int kScannerD730 = 196618;

	/// <summary>
	/// Model D740
	/// value: 196619 (0x3000B)
	/// </summary>
	public const int kScannerD740 = 196619;

	/// <summary>
	/// Model D750
	/// value: 196620 (0x3000C)
	/// </summary>
	public const int kScannerD750 = 196620;

	/// <summary>
	/// Model D760
	/// value: 196621 (0x3000D)
	/// </summary>
	public const int kScannerD760 = 196621;

	/// <summary>
	/// Model S700
	/// value: 196622 (0x3000E)
	/// </summary>
	public const int kScannerS700 = 196622;

	/// <summary>
	/// Model S730
	/// value: 196623 (0x3000F)
	/// </summary>
	public const int kScannerS730 = 196623;

	/// <summary>
	/// Model S740
	/// value: 196624 (0x30010)
	/// </summary>
	public const int kScannerS740 = 196624;

	/// <summary>
	/// Model S750
	/// value: 196625 (0x30011)
	/// </summary>
	public const int kScannerS750 = 196625;

	/// <summary>
	/// Model S760
	/// value: 196626 (0x30012)
	/// </summary>
	public const int kScannerS760 = 196626;

	/// <summary>
	/// Model S860
	/// value: 196627 (0x30013)
	/// </summary>
	public const int kScannerS860 = 196627;

	/// <summary>
	/// Model D790
	/// value: 196628 (0x30014)
	/// </summary>
	public const int kScannerD790 = 196628;

	/// <summary>
	/// Model D600
	/// value: 327701 (0x50015)
	/// </summary>
	public const int kScannerD600 = 327701;

	/// <summary>
	/// Model S550
	/// value: 327702 (0x50016)
	/// </summary>
	public const int kScannerS550 = 327702;

	/// <summary>
	/// NFC Tag
	/// value: 393239 (0x60017)
	/// </summary>
	public const int kNFCTag = 393239;

	/// <summary>
	/// device type unknown by this version of Capture
	/// value: 196632 (0x30018)
	/// </summary>
	public const int kBtUnknown = 196632;

	/// <summary>
	/// device manager for controlling BLE
	/// value: 17104897 (0x1050001)
	/// </summary>
	public const int kDeviceManagerBle = 17104897;

};


