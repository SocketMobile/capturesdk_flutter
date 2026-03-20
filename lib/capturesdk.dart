import './classes/gen/device_types.dart';

/// This is main file for package

export './capture_helper.dart';
export './capture_helper_device.dart';

export './classes/app_info.dart';
export './classes/capture.dart';
export './classes/capture_event.dart';


export './classes/capture_exception.dart';
export './classes/capture_plugin.dart';
export './classes/capture_property.dart';
export './classes/capture_version.dart';
export './classes/datasource.dart';
export './classes/decoded_data.dart';
export './classes/device_info.dart';
export './classes/discovered_device_info.dart';

export './classes/gen/data_sources.dart';
export './classes/gen/device_types.dart';
export './classes/gen/errors.dart';
export './classes/gen/event_ids.dart';
export './classes/gen/property_ids.dart';
export './classes/http_transport.dart';

export './classes/ios_transport.dart';
export './classes/ios_transport_adaptor.dart';
export './classes/ios_transport_notification.dart';
export './classes/jrpc.dart';

export './classes/jrpc_request.dart';
export './classes/jrpc_response.dart';
export './classes/logger.dart';
export './classes/params.dart';
export './classes/shared_methods.dart';

export './classes/transport.dart';
export './widgets/socket_cam_view.dart';

const List<int> SocketCamTypes = <int>[CaptureDeviceType.socketCamC820, CaptureDeviceType.socketCamC860];
