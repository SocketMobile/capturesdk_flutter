Connecting a Socket Mobile Device
=================================

Socket Mobile Companion
-----------------------

The easiest way to connect a Socket Mobile Device to a host independently of a Capture enabled app is to use the Socket Mobile Companion app.

Socket Mobile Companion for iOS can be found on the `App Store <https://itunes.apple.com/us/app/socket-mobile-companion/id1175638950>`_, and for Android  on `Play Store <https://play.google.com/store/apps/details?id=com.socketmobile.companion&hl=en_US&gl=US>`_ .

Connecting with a Socket Mobile barcode scanner
-----------------------------------------------
The Socket Mobile barcode scanners use Bluetooth for connecting to the host.

For an Android host, Socket Mobile Companion takes care of all the details to connect and pair to a Socket Mobile scanner.

For iOS host, the application needs to be configured with some specific settings that include an External Accessory Protocol String and some Privacy Bluetooth Description strings.

The application is aware when the scanner is connected and ready to be used when it receives the **DeviceArrival** notification.


Configuring Contactless NFC Reader/Writer D600 and S550
-------------------------------------------------------

The Socket Mobile Contactless NFC Reader/Writer D600 and S550 are using Bluetooth Low Energy (Bluetooth LE) for connecting to the host.

The iOS platform fully support both Socket Mobile NFC devices and Android support is coming soon.

The BluetoothLE experience is handled by a Capture Device Manager. Following the same logic as for any other device, Capture will send a **DeviceManagerArrival** when BluetoothLE is supported.

The BluetoothLE connection process use a Capture **Auto Discovery** mechanism that is enabled as soon as the Capture BluetoothLE Device Manager **Favorite** contains either a "*" (star) character or a **Unique Device UUID**.

In the case of the favorite containing a "*", the BluetoothLE Capture Device Manager will discover and connect to the first Socket Mobile it finds.

In the case of the favorite containing a **Unique device UUID**, the BluetoothLE Capture Device Manager will search and connect to the corresponding Socket Mobile Contactless NFC Reader/Writer.

Once a Socket Mobile Contactless NFC Reader/Writer is connected to the host, Capture sends a **Device Arrival** notification as for any other device. 

.. note:: A **Device Manager Arrival** is required in order to open a **Device Manager** and to be able to set or get its favorite. Such notification is only sent on the host supporting BluetoothLE and with Capture supporting at least one of the Socket Mobile Contactless NFC Reader/Writers.



