Capture Event IDs
=================
The following array shows the notifications that can be received in the `eventNotification` callback used during the open Capture.

.. _captureeventslistlabel:

Capture Events List
-------------------


+---------------------------------------------------+--------------------------------------------------------+
|               NAME                                |                   DESCRIPTION                          |
+===================================================+========================================================+
| CaptureEventIds.deviceArrival                     |  Device Arrival occurs when a device connects          |
+---------------------------------------------------+--------------------------------------------------------+
| CaptureEventIds.deviceRemoval                     |  Device Removal occurs when a device disconnects       |
+---------------------------------------------------+--------------------------------------------------------+
| CaptureEventIds.terminate                         |  Terminate is sent when Capture is terminated          |
+---------------------------------------------------+--------------------------------------------------------+
| CaptureEventIds.error                             |  A Capture error has occurred                          |
+---------------------------------------------------+--------------------------------------------------------+
| CaptureEventIds.decodedData                       |  A device has decoded some data                        |
+---------------------------------------------------+--------------------------------------------------------+
| CaptureEventIds.power                             |  A device power status has changed (not all devices)   |
+---------------------------------------------------+--------------------------------------------------------+
| CaptureEventIds.buttons                           |  A device buttons has been pressed (not all devices)   |
+---------------------------------------------------+--------------------------------------------------------+
| CaptureEventIds.batteryLevel                      |  A device battery level has changed (not all devices)  |
+---------------------------------------------------+--------------------------------------------------------+
| CaptureEventIds.listenerStarted                   |  Capture Bluetooth Classic listener has started        |
+---------------------------------------------------+--------------------------------------------------------+
| CaptureEventIds.deviceOwnership                   |  A device ownership has changed (lost or gain)         |
+---------------------------------------------------+--------------------------------------------------------+
| CaptureEventIds.deviceManagerArrival              |  A Bluetooth Low Energy device manager is ready for use|
+---------------------------------------------------+--------------------------------------------------------+
| CaptureEventIds.deviceManagerRemoval              |  A Bluetooth Low Energy device manager has been remove |
+---------------------------------------------------+--------------------------------------------------------+
| CaptureEventIds.deviceDiscovered                  |  A Bluetooth Low Energy device has been discovered     |
+---------------------------------------------------+--------------------------------------------------------+
| CaptureEventIds.discoveryEnd                      |  The Bluetooth Low Energy device discovery has ended   |
+---------------------------------------------------+--------------------------------------------------------+
| CaptureEventIds.ccidStatus                        |  PC/SC CCID Status notification (not used)             |
+---------------------------------------------------+--------------------------------------------------------+


CaptureEventIds.deviceArrival
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This event is received each time a device connects to the host and has been successfully initialized by capture.

Arguments: 
      - id: ``CaptureEventIds.deviceArrival``,
      - type: ``CaptureEventType.deviceInfo``,
      - value:
            - name: name of the device,
            - guid: GUID of the device that can be used to open the device,
            - type: type of the device

CaptureEventIds.deviceRemoval
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This event is received each time a device has disconnected from the host.

Arguments:
      - id: ``CaptureEventIds.deviceRemoval``,
      - type: ``CaptureEventType.deviceInfo``,
      - value:
            - name: name of the device,
            - guid: GUID of the device that was used to open the device,
            - type: type of the device


CaptureEventIds.terminate
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This event is sent when everything has been closed upon the client request.

Arguments:
      - id: ``CaptureEventIds.terminate``,
      - type: ``CaptureEventType.none``,
      - value: n/a

CaptureEventIds.error
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This event is received each time Capture needs to report an error on a non-solicitated operation.
A non solicitated operation could be about the Bluetooth Radio that has been turned off, or the Companion Service has been terminated.

Arguments:
      - id: ``CaptureEventIds.error``,
      - type: ``CaptureEventTypes.ulong``,
      - value: error code.

CaptureEventIds.decodedData
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This event is received each time a device has succesfully decoded some data. This is the same notification for all of Socket Mobile products.

Arguments:
      - id: ``CaptureEventIds.decodedData``
      - type: ``CaptureEventTypes.decodedData``
      - value: 
            - id: the data source ID (Symbology ID in case of a barcode scanner, Card Type in case of NFC reader/writer),
            - name: name of the data source,
            - data: array of integer containing the decoded data

CaptureEventIds.power
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This event is received when a device power status has changed. 

By default a device does not send a Power event unless its notification configuration has been set up for sending such event.

This is not supported on all Socket Mobile devices.

Arguments:
      - id: ``CaptureEventIds.power``
      - type: ``CaptureEventTypes.ulong``
      - value: one of these:
            - ``PowerState.unknown`` : the power state is unknown,
            - ``PowerState.onBattery`` : the device is running on battery,
            - ``PowerState.onCradle`` : the device is on the cradle, 
            - ``PowerState.onAc`` : the device is plugged to an AC source

CaptureEventIds.buttons
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This event is received when a device buttons has been pressed.

This event is not sent by default. The device notification configuration needs to be configured in order for the device to send such event.

This is not supported on all devices.

Arguments:
      - id: ``CaptureEventIds.buttons``
      - type: ``CaptureEventTypes.byte``
      - value: a combination of the following values:
            ``ButtonPressMask.left`` when the left button is pressed,
            ``ButtonPressMask.right`` when the right button is pressed,
            ``ButtonPressMask.middle`` when the middle button is pressed,
            ``ButtonPressMask.power`` when the power button is pressed,
            ``ButtonPressMask.ringDetach`` when the ring is detached from the wrist unit.

CaptureEventIds.batteryLevel
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The device sends this event each time the device battery level has changed.

By default the device does not send this event.
The device notification configuration must be set up for the device to send this notification every time the battery level change.

This feature is not supported on all devices. The alternate solution is to query the device battery level periodically.

Arguments:
      - id: ``CaptureEventIds.batteryLevel``
      - type: ``CaptureEventTypes.ulong``
      - value: refer to :ref:`Battery Level value<batterylevelvaluelabel>`. 

CaptureEventIds.listenerStarted
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This confirms the correct initialization of the Companion.

Arguments:
      - id: ``CaptureEventIds.listenerStarted``
      - type: ``CaptureEventTypes.none``


CaptureEventIds.deviceOwnership
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A device ownership has changed (lost or gain)

Arguments:
      - id: ``CaptureEventIds.deviceOwnership``
      - type: ``CaptureEventTypes.string``
      - value: ownership GUID (not related to the device GUID).
            when this GUID is NULL ``00000000-0000-0000-0000-000000000000``, it means the device ownership has been lost and some other application is currently using the device.

The ownership will eventually come back once the other application has close the device. 

So in most cases, doing nothing special about this notification is OK.

If the application needs really to regain the ownership of a device, then it can close and reopen the device.



CaptureEventIds.deviceManagerArrival
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A Bluetooth Low Energy device manager is ready to be used. 

The Bluetooth Low Energy device manager could initiate a Bluetooth Low Energy device discovery, or start the auto discovery if the device manager favorite property is not empty.

If the Bluetooth Low Energy device manager is not open, then it won't try to discover or connect to Bluetooth Low Energy Socket Mobile devices such as D600 or S550.

Please refer to :ref:`Using Contactless Reader/Writer<usingcontactlessreaderwriterlabel>` for more information about connecting to Socket Mobile Contactless Reader/Writer devices.

Arguments: 
      - id: ``CaptureEventIds.deviceManagerArrival``,
      - type: ``CaptureEventType.deviceInfo``,
      - value:
            - name: name of the device manager,
            - guid: GUID of the device manager that can be used to open the device manager,
            - type: type of the device manager


CaptureEventIds.deviceManagerRemoval
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A Bluetooth Low Energy device manager has been removed, often when the Bluetooth Radio of the host has been turned off.

Arguments:
      - id: ``CaptureEventIds.deviceRemoval``,
      - type: ``CaptureEventType.deviceInfo``,
      - value:
            - name: name of the device manager,
            - guid: GUID of the device manager that was used to open the device manager,
            - type: type of the device manager


CaptureEventIds.deviceDiscovered
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A Bluetooth Low Energy device has been discovered by the Bluetooth Low Energy device manager.

Arguments:
      - id: ``CaptureEventIds.deviceDiscovered``,
      - type: ``CaptureEventType.string``,
      - value: sperator delimited string that contains:
            - name: name of the device,
            - serviceUUID: the UUID of the device service,
            - identifierUUID: This is the UUID to set the device manager favorite with in order to connect only to this particular device.

An example of the string value could look like this:

.. code-block::

            {
            identifierUUID = "BE495AA0-A93C-4274-9006-F3BC2428ACDF";
            name = "Socket D600 [7EF619]";
            serviceUUID = "6CB501B7-96F6-4EEF-ACB1-D7535F153CF0";
            }




CaptureEventIds.discoveryEnd
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The Bluetooth Low Energy device discovery has ended.

Arguments:
      - id: ``CaptureEventIds.discoveryEnd``,
      - type: ``CaptureEventType.none``,
      - value: n/a


CaptureEventIds.ccidStatus
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
PC/SC CCID Status notification (not used).


