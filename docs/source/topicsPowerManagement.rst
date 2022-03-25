Power Management
================

It is important to know the power state of the scanner as it is for the host to make sure it does not need to be recharged during the time the scanner is needed and the operation has a chance to change batteries or charge the scanner.

The application can check the battery level of the scanner using Capture SDK.

Additionally, many Socket Mobile scanners support battery level change notification.

Following are some examples on how to configure the scanner for these features.


Reading the Battery Level
^^^^^^^^^^^^^^^^^^^^^^^^^
Here is example code showing how to request the scanner battery level information:

.. code-block:: javascript

    Future getBatteryLevel() {
        CaptureProperty property = new CaptureProperty(
            CapturePropertyIds.batteryLevelDevice,
            CapturePropertyTypes.none,
            {}
        );
        try {
            dynamic res = await deviceCapture.getProperty(property);
            print(`Battery: ${(value & 0xff00)>>8}%`;);
        } catch (err){  
            print(`error while getting the battery level: ${err}`);
        }
    }


.. note::
   .. _batterylevelvaluelabel:

   The value returned when getting the battery level of a device is an integer composed of 3 values:
                     +-------------+-----------------+-------------+
                     |  Max Range  |  Current Value  |  Min Range  |
                     +-------------+-----------------+-------------+
                     |   Byte 2    |      Byte 1     |    Byte 0   |
                     +-------------+-----------------+-------------+

   The Max Range is often 100, and Min Range 0, so the current value is expressed as a percentile, but ideally if the Socket Mobile device changes the granularity of the range, it is recommended to use the full scale: ``current value x 100 ÷ (Max range - Min Range)``   


Set up the Battery Level Change Notification
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Setting up the scanner to make it send a notification each time the battery level changes is a 2 step process. 

Since this setting is persistent in the scanner, the first time the scanner connects to the application we query the notification setting, if the battery level change notification is not activated then we activate it.

The initial battery level needs to be read at this time because it could take a long time before the first battery level change notification is received.

.. code-block:: javascript

            Future configureNotification() {
               CaptureProperty property = new CaptureProperty(
                  CapturePropertyIds.notificationsDevice,
                  CapturePropertyTypes.none,
                  {}
               );
               try {
                    dynamic event = await deviceCapture.getProperty(property);
                    if(event.value & Notifications.batteryLevelChange === 0) {
                        dynamic val = value ?? Notifications.batteryLevelChange;
                        property = new CaptureProperty(
                            CapturePropertyIds.notificationsDevice,
                            CapturePropertyTypes.ulong,
                            val
                        );
                        return captureDevice.setProperty(property)
                    }
                } catch (err){  
                    print('error while configuring the notifications: ' + err);
                }
            }


An appropriate place to read the first battery level is when the device connects.

The battery level change notifications are received in the same notification handler as any other Capture events and they are identified by this Capture event ID: ``CaptureEventIds.batteryLevel``.



Power State Change and other Events
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The same principle can be followed for the other events of the device, such as the ``CaptureEventIds.power`` event which notifies the application each time the scanner is plugged into a power source, or unplugged or dropped in the charger cradle.

Other events such as buttons state can be tracked by handling the Capture event ID: ``CaptureEventIds.buttons`` that has a long value that is a combination of the following mask values:


Available notifications
^^^^^^^^^^^^^^^^^^^^^^^

Below is a table of all the possible values for configuring the notifications that a device could send aside the device arrival/removal, decoded data.

These settings can be set conjointly if multiple events need to be received by the application.

+--------------------------------------------------+---------------------------------------------------+
|                      Name                        |                      Description                  |
+==================================================+===================================================+
|  Notifications.triggerButtonPress                |  The device sends a notification when the trigger |
|                                                  |  button is pressed                                |
+--------------------------------------------------+---------------------------------------------------+
|  Notifications.triggerButtonRelease              |  The device sends a notification when the trigger |
|                                                  |  button is released                               |
+--------------------------------------------------+---------------------------------------------------+
|  Notifications.powerButtonPress                  |  The device sends a notification when the power   |
|                                                  |  button is pressed                                |
+--------------------------------------------------+---------------------------------------------------+
|  Notifications.powerButtonRelease                |  The device sends a notification when the power   |
|                                                  |  button is released                               |
+--------------------------------------------------+---------------------------------------------------+
|  Notifications.powerState                        |  The device sends a notification when the power   |
|                                                  |  state changes (battery to AC or vice-versa) (not |
|                                                  |  supported on all device)                         |
+--------------------------------------------------+---------------------------------------------------+
|  Notifications.batteryLevelChange                |  The device sends a notification when the battery |
|                                                  |  level changed (not supported on all device)      |
+--------------------------------------------------+---------------------------------------------------+


These notifications are often regrouped by type. The notifications regarding the buttons are regrouped in the Capture event with the ``CaptureEventIds.buttons`` ID, the battery level notification is sent with the ``CaptureEventIds.batteryLevel`` ID, the power state change notification is sent with the ``CaptureEventIds.power`` ID.

Refer to :ref:`Capture Events List<captureeventslistlabel>` for a complete list of events Capture or the device could send.
