.. _usingcontactlessreaderwriterlabel:

Using Contactless Reader/Writer with Flutter Capture
====================================================

.. NOTE::
  Not all the Companions support the Contactless Reader/Writer. At the moment only iOS and iPadOS Companion work with Socket Mobile D600 and S550 with Capture.
  The platforms that don't support BLE or the Socket Mobile D600 and S550 is not yet supported simply don't receive the device manager arrival message. 

Device Manager
^^^^^^^^^^^^^^
The Socket Mobile contactless reader/writer (D600 and S550) uses Bluetooth Low Energy (BLE) to communicate with the host.

Capture SDK provides a new Device Manager object in order to provide some control over the BLE transport.

The Device Manager UUID and reference are received in the 2 notifications 
``CaptureEventIds.DeviceManagerArrival`` and ``CaptureEventIds.DeviceManagerRemoval``.

Here is an example of such a notification in a sample app:

.. code-block:: javascript

  _onCaptureEvent(e, handle) {
    
      if (e == null) {
        return;
      } else if (e.runtimeType == CaptureException) {
        print("${e.code}" + ': ' + e.message;
        return;
      }

      logger.log('onCaptureEvent from: ', '$handle');

      switch (e.id) {
        case CaptureEventIds.DeviceManagerArrival:
          print('Open the device: ' + event.value.guid);
                
          setState(() {
              _deviceCapture = deviceCapture;
          });
          
          try {
              dynamic res = await captureDevice.openDevice(event.value.guid, capture);
              print('opening device returns: ' + result);
              CaptureProperty property = new CaptureProperty(
                  CapturePropertyIds.Favorite,
                  CapturePropertyTypes.none,
                  {}
              );
              try {
                  dynamic response = await captureDevice.getProperty(property);
                  if (favorite.length === 0) {
                    CaptureProperty property = new CaptureProperty(
                      CapturePropertyIds.Favorite,
                      CapturePropertyTypes.String,
                      '*'
                    );

                    return captureDeviceManager.setProperty(property);
                  } 
              } catch (err){
                  print(err);
              }
    
          break;
        ...
      }
    }



In this example the assumptions are a ``capture`` reference set to the main capture is already open with the app credentials, and the ``captureDeviceManager`` is declared in a scope accessible to this Capture notification handler.

Favorite Devices
^^^^^^^^^^^^^^^^
To facilitate the operations of discovering and connecting to a BLE contactless
reader/writer, a concept of favorite devices has been introduced.

The Device Manager has a property to configure in a persistent way the favorite
devices.

As soon as the Device Manager favorite devices is set to either a device
identifier or ``"*"`` the **auto discovery and connect** mode starts
automatically.

In this mode, the Device Manager starts a discovery and connects to the
contactless reader/writer corresponding to the identifier found in the favorite
devices property or to the first contactless reader/writer it finds in the case
where the favorite devices is set to ``"*"``.

.. note::

  Using **auto discovery and connect** mode can increase power consumption.
  Once the contactless reader/writer is connected, the consumption level drops.
  But as soon as the discovery restarts when, for example when the contactless
  reader/writer is no longer ON or in range, then the power consumption
  increases slightly. Setting the favorite devices to an empty string will stop
  the **auto discovery and connect** mode, and BLE discovery won't happen again
  until the favorite devices is set or the discovery is implicitly started by
  using the BLE Device Manager startDiscovery property.

.. _contactlessreaderwriterautodiscoveryconnnectlabel:

Starting Contactless Reader/Writer Auto Discovery Mode
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The following code sample shows how to turn on by default in an app the
**auto discovery and connect** mode to support contactless reader/writer, so
that as soon as there is a device turned on in the vicinity, the app will
automatically connect to it:

.. code-block:: javascript

  _onCaptureEvent(e, handle) {
    
      if (e == null) {
        return;
      } else if (e.runtimeType == CaptureException) {
        print("${e.code}" + ': ' + e.message;
        return;
      }

      logger.log('onCaptureEvent from: ', '$handle');

      switch (e.id) {
        case CaptureEventIds.DeviceManagerArrival:
          print('Open the device: ' + event.value.guid);
                
          setState(() {
              _deviceCapture = deviceCapture;
          });
          
          try {
              dynamic res = await captureDevice.openDevice(event.value.guid, capture);
              print('opening device returns: ' + result);
              CaptureProperty property = new CaptureProperty(
                  CapturePropertyIds.FavoriteDevice,
                  CapturePropertyTypes.none,
                  {}
              );
              try {
                  dynamic response = await captureDevice.getProperty(property);
                  if (favorite.length === 0) {
                    CaptureProperty property = new CaptureProperty(
                      CapturePropertyIds.FavoriteDevice,
                      CapturePropertyTypes.String,
                      '*'
                    );

                    return captureDeviceManager.setProperty(property);
                  } 
              } catch (err){
                  print(err);
              }
    
          break;
        ...
      }
    }




To turn off this feature, just set the favorite devices to an empty string:

.. code-block:: javascript

  const property = new CaptureProperty(
    SocketMobile.CapturePropertyIds.FavoriteDevice,
    SocketMobile.CapturePropertyTypes.String,
    ''
  );

  try {
    dynamic result = await deviceCapture.setProperty(property)
    print('device manager favorite has been reset')
  } on CaptureException catch (exception){
    print('error while setting device manager favorite: ' + exception.code.toString() + ': ' + exception.message);
  }



.. _contactlessreaderwriterpresencelabel:

Presence of a Contactless Reader/Writer
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The presence of contactless reader/write device reference is handled by the
application by handling in the notification handler, the ids ``CaptureEventIds.DeviceArrival`` and
``CaptureEventIds.DeviceRemoval`` indicate if a device has been connected and ready or when a device has disconnected and is no longer available.


.. NOTE::
  These ``CaptureEventIds.DeviceArrival`` and
  ``CaptureEventIds.DeviceRemoval`` events are received for any Socket Mobile device connects or disconnects from the host, not only the NFC Reader/Writer product. The device type parameter helps to identify which device is available or no longer available.

To keep a particular device a favorite device, its device unique identifier can
be retrieved using the Device Manager
``getDeviceUniqueIdentifierFromDeviceGuid`` API and it can then be used to set
the Device Manager favorite devices as shown below:

.. code-block:: javascript

  async function setThisDeviceAsFavorite(deviceManager, deviceGuid) {
      // first get the unique device ID of the device identified
      // by its GUID, then set this unique device ID as favorite
      // in the device manager to connect only to that device
      let property = new CaptureProperty(
        CapturePropertyIds.UniqueDeviceIdentifier,
        CapturePropertyTypes.String,
        deviceGuid
      );
      
      const result = await deviceManager.getProperty(property);

      property = new SocketMobile.CaptureProperty(
        SocketMobile.CapturePropertyIds.Favorite,
        SocketMobile.CapturePropertyTypes.String,
        result.value
      );
      
      return deviceManager.setProperty(property);
  }

  _onCaptureEvent (event, handle) {
    if(event) {
      print('event: ', event);
      String eventName = getEventName(event.id);
      print(`received ${eventName}`);
      if(event.id === CaptureEventIds.DeviceArrival) {
        print('Open the device: ', event.value.guid);
        Capture deviceCapture = new Capture();
        try {
          dynamic result = await deviceCapture.openDevice(event.value.guid, capture);

          _devices[event.value.guid] = captureDevice;

          result = await setThisDeviceAsFavorite(deviceCapture, event.value.guid);
        } on CaptureException catch (exception){
          print('error while setting device manager favorite: ' + exception.code.toString() + ': ' + exception.message);
        }
      }
    }
    ...


This example sets the device favorite to the first contactless reader/writer that
connects to the host if the device favorite was set with a ``*``.
By doing so, this contactless reader/writer becomes the preferred device to
be connected to this host, until the favorite device string is reset to either an
empty string to stop the **auto discovery and connect** mode, or to ``*`` to
connect to another or the same contactless reader/writer device.

.. _contactlessreaderwriterdiscoverylabel:

Contactless Reader/Writer Discovery
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The Device Manager offers an API to discover the contactless reader/writer devices that are in the vicinity.

Once a device has been discovered, its identifier UUID can be used to set the Device Manager favorite devices.
As soon as the Device Manager favorite devices is set with this UUID, the Device Manager will then connect to this particular contactless reader/writer device.

Here is an example showing how to start the device discovery:

.. code-block:: javascript

      CaptureProperty property = new CaptureProperty(
        CapturePropertyIds.StartDiscovery,
        CapturePropertyTypes.Ulong,
        5000
      );

      dynamic result = await deviceCapture.getProperty(property);



Then for each discovered device the ``CaptureEventIds.DeviceDiscovered`` event is fired:

.. code-block:: javascript

  _onCaptureEvent(e, handle) {

      switch (e.id) {
        case CaptureEventIds.DeviceDiscovered:
          print('Discovered the device: ' + event.value));
          const discoveredDevice = jsonDecode(event.value);
          try{

            dynamic result = await setThisDeviceAsFavorite(captureDeviceManager, event.value.guid);

            CaptureProperty property = new CaptureProperty(
              CapturePropertyIds.Favorite,
              CapturePropertyTypes.String,
              discoveredDevice.identifierUUID
            );

            result = await deviceManager.setProperty(property);
            
          } on CaptureException catch (exception){
            print(exception.code.toString() + ': ' + exception.message);
          }
          break;
      }
    }
    ...



Here is how the ``event.value`` might look::

  {
    "identifierUUID": "BE495AA0-A93C-4274-9006-F3BC2428ACDF",
    "name": "Socket D600 [7EF619]",
    "serviceUUID": "6CB501B7-96F6-4EEF-ACB1-D7535F153CF0"
  }


In this case the last discovered device is set as favorite.
The device **identifierUUID** is what can be used to set the favorite devices
with in order to connect to that particular contactless reader/writer device.

The device discovery ends once the time out has elapsed and notifies the app by
firing the ``SocketMobile.CaptureEventIds.DiscoveryEnd`` event:

.. code-block:: javascript

  _onCaptureEvent(e, handle) {

      switch (e.id) {
        case CaptureEventIds.DiscoveryEnd:
            print('end of discovery');
          } on CaptureException catch (exception){
            print(exception.code.toString() + ': ' + exception.message);
          }
          break;
        ...
      }
    }


.. _contactlessreaderwriterdataformatlabel:

Contactless Reader/Writer Data Format (D600 only)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When the contactless reader/writer reads data from a card, it can display
this data in four different formats:

  - Tag Type and ID: ``DataFormat.tagTypeAndId``
    This Data Format will display the type of card (NFC Forum, etc.)
    as well as the unique identifier associated with the card.

  - ID Only: ``DataFormat.idOnly``
    This Data Format will only display the unique identifier from the card. (This format is not supported)

  - Tag Type and Data: ``DataFormat.tagTypeAndData``
    This Data Format will display the type of card (NFC Forum, etc.)
    as well as the expected data on the card. This data can be translated
    into a String format or otherwise if expected.

  - Data Only ``DataFormat.dataOnly``
    This Data Format will display only the data from the card. (This format is not supported.)



^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Setting and Getting the current Data Format (D600 only)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  You can change the current data format by using one of the aforementioned data format types.
  Example of setting to ``DataFormat.tagTypeAndData``:

  .. code-block:: javascript

        CaptureProperty property = new CaptureProperty(
          CapturePropertyIds.DataFormatDevice,
          CapturePropertyTypes.Byte,
          CapturePropertyValues.TagTypeAndData
        );
      
        dynamic result = await deviceCapture.setProperty(property);

  Getting the current data format is similar to setting:

  .. code-block:: javascript

        CaptureProperty property = new CaptureProperty(
          CapturePropertyIds.DataFormatDevice,
          CapturePropertyTypes.None,
          {}
        );
      
        dynamic result = await deviceCapture.getProperty(property);
        
