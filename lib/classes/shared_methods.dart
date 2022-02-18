import 'package:flutter/services.dart';

import '../capture_flutter_beta.dart';

/// Helper function to determine which type a dynamic value should be.
typifyValue(val, type) {
  dynamic _typifiedValue;
  if (val != null) {
    switch (type) {
      case CaptureEventTypes.string:
        _typifiedValue = val;
        break;
      case CaptureEventTypes.deviceInfo:
        _typifiedValue = DeviceInfo(val['name'], val['guid'], val['type']);
        break;
      case CaptureEventTypes.decodedData:
        _typifiedValue = DecodedData(val['id'], val['name'], val['data']);
        break;
    }
  } else {
    return CaptureException(SktErrors.ESKT_NOTAVAILABLE, 'type is unavailable',
        'type conversion', 'Platform Exception');
  }
  return _typifiedValue;
}

/// Converting a platform exception to a generic CaptureException.
convertFromPlatformException(PlatformException exception, method, type) {
  throw CaptureException(int.parse(exception.code),
      exception.message ?? 'No Message', method, type);
}

/// Helper for determining which property switch to use
propertySwitchStatement(prop, finalVal, isFromProperty) {
  if (isFromProperty) {
    return toCapturePropertySwitch(prop, finalVal);
  } else {
    return toPropertySwitch(prop, finalVal);
  }
}

/// Helper for determining which property should be assigned to the value (used in response) property.
toCapturePropertySwitch(prop, finalVal) {
  switch (finalVal.type) {
    case CapturePropertyTypes.dataSource:
      finalVal.value = prop.dataSource;
      break;
    case CapturePropertyTypes.array:
      finalVal.value = prop.arrayValue;
      break;
    case CapturePropertyTypes.string:
      finalVal.value = prop.stringValue;
      break;
    case CapturePropertyTypes.byte:
      finalVal.value = prop.byteValue;
      break;
    default:
      finalVal.value = {};
  }
  return finalVal;
}

/// Helper for determining which property generic value (from response) should be assigned to.
toPropertySwitch(prop, finalVal) {
  dynamic val = prop.value;

  switch (prop.type) {
    case CapturePropertyTypes.dataSource:
      finalVal.dataSource = val;
      break;
    case CapturePropertyTypes.array:
      finalVal.arrayValue = val;
      break;
    case CapturePropertyTypes.string:
      finalVal.stringValue = val;
      break;
    case CapturePropertyTypes.byte:
      finalVal.byte = val;
      break;
  }

  return finalVal;
}
