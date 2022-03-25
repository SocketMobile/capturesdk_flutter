Basics
=======

Getting the Decoded Data
------------------------
Using Capture Helper to retrieve the decoded data from a scanner is as simple as handling the notification by providing a function when opening Capture and check for the Capture Event ID.

Here is a minimal example of such implementation for handling the decoded data with Capture Helper:

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
        case CaptureEventIds.deviceArrival:
          Capture deviceCapture = Capture(logger);

          setState(() {
            _deviceCapture = deviceCapture;
          });

          _openDeviceHelper(deviceCapture, e);
          break;
        case CaptureEventIds.deviceRemoval:
          _closeDeviceHelper(e, handle);
          break;

        case CaptureEventIds.decodedData:
          setState(() {
            //storing scanned data in state for future use
            _currentScan = e;
          });
          _updateVals('Decoded Data', "Successful scan!");
          break;
      }
    }

.. Note::
  This notification handler also shows how to detect the error if the Companion service is no longer responding. This could be useful to give some guidance to the user to launch the Companion.

Device Arrival
--------------
The Device arrival is fired when a Socket Mobile device is connected to the host.

This is the ideal place for opening the Capture Device or at least to keep the device GUID information that is sent in the argument of the event: ``e.value.guid``. 

.. Note:: 
  The GUID information of a Socket Mobile device changes each time the same device connects. So if the device disconnects and reconnects, a new GUID identifies this new device connection, the previous one won't have any effect if used durin a call to open the device.

The decoded data can be received as soon as the Capture device is opened.

If the decoded data is not needed right away, a Capture device instance can be instantiated with the necessary information here, and open only when the decoded data is required. 


This event can be useful for several things such as:

* confirming to the user the scanner is present and ready
* switching to a view that is ready to receive the decoded data
* checking the scanner configuration before setting its configuration

Here is an example of a Device Arrival handler:

.. code-block:: javascript

    _onCaptureEvent(e, handle){
        ...
        switch (e.id) {
            case CaptureEventIds.deviceArrival:
                Capture deviceCapture = Capture(logger);

                setState(() {
                    _deviceCapture = deviceCapture;
                });

                _openDeviceHelper(deviceCapture, e);
                break;
            ...
        }

    }


Device Ownership
----------------
The device ownership is a condition of receiving the decoded data from a Socket Mobile device in a context where several applications might use the device at the same time.

The application that opens last the device has the ownership of the device and therefore can receive the decoded data.

When an application opens a device, it then receives a device ownership notification to indicate this application has the ownership of the device and it will receive the decoded data.

If an other application opens the same device, then the previous application receives a device ownership with an NULL GUID. ``00000000-0000-0000-0000-000000000000`` to indicate it has lost the ownership of the device. The other application has the ownership of the device and it receives a device ownership event with a non-NULL GUID. 

As soon as the application that has the device ownership closes the device, the ownership goes automatically to the previous application. That application receives a ownership event with a non-NULL GUID indicating it has recovered the device full ownership and can receive the decoded data from that device.

The default behaviour does not require an application to handle the ownership so it can be ignored.

Often the last application that opens the device has the ownership, when that application closes, then the ownership goes to the previous application automatically.

If an application really needs to reclaim the ownership, closing and reopening the device will do the trick. 

Monitoring the device ownership event allows an application to confirm the decoded data would be received as expected or not if it does not have the ownership.

Example of a ownership event handler:

.. code-block:: javascript

    String OWNERSHIP_LOST = '00000000-0000-0000-0000-000000000000';

    _onCaptureEvent(e, handle){
        ...
        switch (e.id) {
        ...
        case CaptureEventIds.deviceOwnership:
            print(`ownership: ${e.value}`);

            if(e.value === OWNERSHIP_LOST) {
                print('ownership lost');
            }

            break;
            ...
        }

    }



Get the Error
-------------
It is a good idea to be notified when an unexpected error occurs. 

One possible scenario where this could happen is when the user scans too many barcodes before the application has time to consume them.

This is also the way of being notified if the Companion service is not running anymore or the service has closed the connection with the application.

Here is an example of the error event handler to display an error message in a status label in the application UI:

.. code-block:: javascript

    _onCaptureEvent(e, handle) {
        ...
        switch (e.id) {
            ...
            case CaptureEventIds.error:
                if(e.value === SktErrors.ESKT_SERVICENOTCOMMUNICATING) {
                    print('the service stops responding, is it running?');
                }
                else {
                    print('Receive an error: ' +  e.value);
                }
                break;
            }
        ...
        }
    };


Getting a Device Property such as Battery Level
-----------------------------------------------
It might be useful to display the battery level of the Socket Mobile device. 

Like any other characteristics or configuration of a Socket Mobile device, it can be retrieve or set using a Capture property. 

Capture properties are defined by an ID, a parameter type and a parameter value. If there is no value attached to the property, the parameter type would be set to ``None``.

Some properties cannot be retrieve (Get Property) and some cannot be set (Set Property), this is the case for the battery level property that can only be retrieved (Get Property).

One way to get the initial battery level is when the device connects.

Here is an example of getting the device battery level right upon its connection:

.. code-block:: javascript

    _onCaptureEvent(e, handle) {
        ...
        switch (e.id) {
            ...
            case CaptureEventIds.deviceArrival:
                print('Open the device: ' + event.value.guid);
                
                setState(() {
                    _deviceCapture = deviceCapture;
                });
                try {
                    dynamic res = await captureDevice.openDevice(event.value.guid, capture);
                    print('opening device returns: ' + result);
                    CaptureProperty property = new CaptureProperty(
                        CapturePropertyIds.batteryLevelDevice,
                        CapturePropertyTypes.none,
                        {}
                    );
                    try {
                        dynamic battery = await captureDevice.getProperty(property);
                        // the battery level value is composed of the 3 last bytes
                        // of the battery data receive as response,
                        // byte 0: min value of the range,
                        // byte 1: current value of the battery from within the range
                        // byte 2: max value of the range.
                        // usually the max is 100, (0x64), the min is 0 (0x00) so
                        // the current value is actually a percent but might be better
                        // to calculate the real value by using the min and max range in
                        // case the device is able to provide a finer granularity.
                        print(`battery: ${(battery.value & 0xff00) >> 8}%`);
                    } catch (err){
                        print(err);
                    }
                
                } catch (err){
                    print(err);
                }
                break
            ...
        }
    };


