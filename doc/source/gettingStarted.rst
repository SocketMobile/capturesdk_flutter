.. |br| raw:: html

   <br />

Getting Started with React Native Capture SDK
=============================================

Requirements
------------
The Socket Mobile Capture SDK uses Bluetooth Classic for the barcode scanner products and Bluetooth Low Energy (BLE) for the Contactless Reader/Writer products (Socket Mobile D600, S550).

Even though the React Native Capture SDK allows to develop an app to run on iOS and Android the underlying Capture architecture on these 2 platforms is different.

On Android there is a service embedded in the Socket Mobile Companion app that is required in order to connect the Socket Mobile device to the Android host.

On iOS the communication with the Socket Mobile devices are embedded in the React Native Module therefore adding more configuration to be taken care of in the application itself.

**Requirements for iOS platform**

For applications that need to work with barcode scanners, make sure the following requirements are met:

#.	Your iOS application needs to be registered in our Apple MFI Approved Application list before submitting your application to the Apple Store. It will not pass the Apple Store review if this is not done.

#.	Your application must have the string ``com.socketmobile.chs`` in the Supported External Protocol setting. |br|
	|ExternalAccessory|

	.. |ExternalAccessory| image:: images/ExternalAccessoryInfo.png


#. Your application must add some security descriptions for the Bluetooth permissions as shown here: |br|
  |BluetoothPrivacy|

  .. |BluetoothPrivacy| image:: images/Bluetooth-Privacy-Strings.png


**Requirements for both iOS and Android platforms**

#.	**Your application will need a SocketMobile AppKey.** Follow the link to `create an AppKey <https://www.socketmobile.com/appkey>`_. AppKeys can be generated online and at no additional cost beyond the nominal one time registration fee.  The AppKey is validated by the SDK library on the device, no internet connection is required. Note: You don’t need to create your own AppKey to compile and run the sample apps.


#.	**The scanner needs to be paired with your devices in Application Mode.** This can be done using Socket Mobile Companion app which can be downloaded from the `App Store <https://itunes.apple.com/us/app/socket-mobile-companion/id1175638950>`_ .

#.  Try our React Native sample app `Single Entry React Native <https://github.com/SocketMobile/singleentry-rn>`_.



SDK Installation
----------------
The React Native Capture SDK is released as a NPM (Node Package Manager) package.

**Using yarn**

.. code-block::

    yarn add react-native-capture

**Using npm**

.. code-block::

    npm install --save react-native-capture
    

Using Capture SDK
-----------------
First, once the NPM package has been installed CaptureSDK can be imported as shown below:

.. code-block:: javascript
  import { CaptureRn, CaptureEventIds, SktErrors } from 'react-native-capture';


Here are the usual steps to follow:

#. Open Capture with the App credentials and provide event handler function
#. Handle device arrival and open the device in the event handler function
#. Handle device removal and close the device in the event handler function
#. Handle decoded data in the event handler function

**Opening Capture with App credentials**

The React Native Capture SDK is an extension of the CaptureJS SDK. The main difference is the first instance that use **CaptureRn** instead of **Capture**:

.. code-block:: javascript

      const capture = new CaptureRn();
      const appInfo = {
      appId: 'web:com.socketmobile.SingleEntryRN',
      developerId: 'bb57d8e1-f911-47ba-b510-693be162686a',
      appKey:
        'MC4CFQCcoE4i6nBXLRLKVkx8jwbEnzToWAIVAJdfJOE3U+5rUcrRGDLuXWpz0qgu',
      };
      capture
      .open(appInfo, onCaptureEvent)
      .then(() => {
        setStatus('capture open success');
      })
      .catch(err => {
        myLogger.error(err);
        setStatus(`failed to open Capture: ${err}`);
        // this is mostly for Android platform which requires
        // Socket Mobile Companion app to be installed
        if (err === SktErrors.ESKT_UNABLEOPENDEVICE) {
          setStatus('Is Socket Mobile Companion app installed?');
        }
      });

**Handle device arrival and open the device**

When the application receives a **Device Arrival** notification, it can create a new **CaptureRn** object that represents the new device.

The application opens the device by passing **GUID** and the main **CaptureRn** reference as arguments of the device open function.

Opening the device allows to receive the decoded data from this device.

.. note:: the device **GUID** changes everytime the device connects. It identifies a connection session with a device.

.. note:: If a Socket Mobile device is already connected to the host prior to the app opening Capture SDK, the device arrival notificaiton will still be sent to make the application aware that the device is connected.

.. note:: The second argument of the **onCaptureEvent**, handle, is optional. It could be used to identify which Capture object is the source of the notification.

In the **onCaptureEvent** callback passed when opening Capture you could have code similar to this handling the device arrival notification:

.. code-block:: javascript

      const onCaptureEvent = (e, handle) => {
        if (!e) {
          return;
        }

        switch (e.id) {
          // **********************************
          // Device Arrival Event
          //   a device needs to be opened in
          //   to receive the decoded data
          //  e = {
          //    id: CaptureEventIds.DeviceArrival,
          //    type: CaptureEventTypes.DeviceInfo,
          //    value: {
          //      guid: "b876d9a8-85b6-1bb5-f1f6-1bb5d78a2c6e",
          //      name: "Socket S740 [E2ABB4]",
          //      type: CaptureDeviceType.ScannerS740
          //    }
          //  }
          // **********************************
          case CaptureEventIds.DeviceArrival:
            const newDevice = new CaptureRn();
            const {guid, name} = e.value;
            newDevice
              .openDevice(guid, capture)
              .then(result => {
                setStatus(`result of opening ${e.value.name} : ${result}`);
                setDevices(prevDevices => {
                  prevDevices = prevDevices || [];
                  prevDevices.push({
                    guid,
                    name,
                    handle: newDevice.clientOrDeviceHandle,
                    device: newDevice,
                  });
                  return [...prevDevices];
                });
              })
              .catch(err => {
                setStatus(`error opening a device: ${err}`);
              });
            break;
      ../..


**Handle device removal and close the device**

The device removal occurs when the Socket Mobile is no longer connected to the host. It is recommended to close it.

In the **onCaptureEvent** callback passed when opening Capture you could have code similar to this:

.. code-block:: javascript

    // **********************************
    // Device Removal Event
    //   it is better to close the device
    //  e = {
    //    id: CaptureEventIds.DeviceRemoval,
    //    type: CaptureEventTypes.DeviceInfo,
    //    value: {
    //      guid: "b876d9a8-85b6-1bb5-f1f6-1bb5d78a2c6e",
    //      name: "Socket S740 [E2ABB4]",
    //      type: CaptureDeviceType.ScannerS740
    //    }
    //  }
    // **********************************
    case CaptureEventIds.DeviceRemoval:
      const removeDevice = devices.find(d => d.guid === e.value.guid);
      if (!removeDevice) {
        return;
      }
      setDevices(prevDevices => {
        prevDevices = prevDevices.filter(d => d.guid !== e.value.guid);
        return prevDevices;
      });
      removeDevice.device
        .close()
        .then(result => {
          setStatus(`result of closing ${removeDevice.name}: ${result}`);
        })
        .catch(err => {
          setStatus(`error closing a device: ${err}`);
        });
      break;

      ../..

**Handle decoded data in the event handler function**

Each time a Socket Mobile device is successful at reading a barcode or an NFC tag, the decoded data notification is sent and can be handled as shown here:

.. note:: 
    Capture does not interpret the decoded data, only the application knows how to interpret it. For demonstration purpose the decoded data can be displayed with the help of a function like this:
    
    .. code-block:: javascript 

        function arrayToString(dataArray) {
            return String.fromCharCode.apply(null, dataArray);
        }


.. code-block:: javascript

      // **********************************
      // Decoded Data
      //   receive the decoded data from
      //   a specific device
      //  e = {
      //    id: CaptureEventIds.DecodedData,
      //    type: CaptureEventTypes.DecodedData,
      //    value: {
      //      data: [55, 97, 100, 57, 53, 100, 97, 98, 48, 102, 102, 99, 52, 53, 57, 48, 97, 52, 57, 54, 49, 97, 51, 49, 57, 50, 99, 49, 102, 51, 53, 55],
      //      id: CaptureDataSourceID.SymbologyQRCode,
      //      name: "QR Code"
      //    }
      //  }
      // **********************************
      case CaptureEventIds.DecodedData:
        const deviceSource = devices.find(d => d.handle === handle);
        if (deviceSource) {
          setStatus(`decoded data from: ${deviceSource.name}`);
        }
        if (lastDecodedData.length) {
          setDecodedDataList(prevList => {
            const newDecodedData = {...lastDecodedData};
            newDecodedData.id = dataId++;
            return [newDecodedData, ...prevList];
          });
        }
        lastDecodedData = {
          data: arrayToString(e.value.data),
          length: e.value.data.length,
          name: e.value.name,
        };
        setDecodedData(lastDecodedData);
        break;
        
        ../..


