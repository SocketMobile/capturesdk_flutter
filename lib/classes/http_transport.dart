// ignore_for_file: avoid_dynamic_calls

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../capturesdk.dart';
import 'capture_result.dart';
import 'jrpc_error.dart';

/// Main transport for establishing and making requests on Android.
/// utilizing json rpc as well as Websockets to establish channel.
class HttpTransport extends Transport {
  HttpTransport(this.logger, [this.isWeb]);
  String? host;
  bool? isWeb;
  Logger? logger;
  String hostWebsocket = '';
  WebSocketChannel? websocket;
  void Function(dynamic, int)? onEventNotification;
  int rpcId = 1;
  int? _clientHandle;

  @override

  /// Piggyback Capture's openClient and use parameters and interfaces unique to http connections
  /// Implement JSON Rpc protocols.
  Future<int> openClient(
      String host, AppInfo appInfo, Function notification) async {
    final JRpcRequest jsonRpc =
        JRpcRequest(id: _getJsonRpcId(), method: 'openclient', params: appInfo);

    final RegExp exp = RegExp(r'(http|ftp|https):');
    this.host = '$host/Capture/v1/api';
    hostWebsocket = host.replaceAll(exp, 'ws:');

    onEventNotification = notification as void Function(dynamic p1, int p2)?;

    try {
      final JRpcResponse response = await sendRequest(jsonRpc);
      final CaptureResult? result = response.captureResult;
      if (result != null) {
        return result.handle;
      } else {
        throw CaptureException(SktErrors.ESKT_NOERROR, 'No error.');
      }
    } on CaptureException {
      rethrow;
    } catch (ex) {
      throw CaptureException(SktErrors.ESKT_COMMUNICATIONERROR,
          'There was an error during communication.', ex.toString());
    }
  }

  @override

  /// Piggyback Capture's openDevice and use parameters and interfaces unique to http connections
  /// Implement JSON Rpc protocols.
  Future<int> openDevice(int clientHandle, String guid) async {
    final JRpcRequest openRequest = JRpcRequest(
        id: _getJsonRpcId(),
        method: 'opendevice',
        params: Params(handle: clientHandle, guid: guid));

    try {
      final JRpcResponse response = await sendRequest(openRequest);
      return response.captureResult?.handle ??
          (throw Exception('Invalid JSON RPC response'));
    } on CaptureException {
      rethrow;
    } catch (ex) {
      throw CaptureException(SktErrors.ESKT_UNABLEOPENDEVICE, 'Unble to open CaptureSDK device.', ex.toString());
    }
  }

  @override

  /// Piggyback Capture's close and use parameters and interfaces unique to http connections
  /// Implement JSON Rpc protocols.
  Future<int> close(int handle) async {
    final JRpcRequest closeRequest = JRpcRequest(
        id: _getJsonRpcId(), method: 'close', params: Params(handle: handle));

    try {
      await sendRequest(closeRequest);
      return SktErrors.ESKT_NOERROR;
    } on CaptureException {
      rethrow;
    } catch (e) {
      throw CaptureException(SktErrors.ESKT_UNABLEDEINITIALIZE,
          'The object cannot be un-initialized', e.toString());
    }
  }

  @override

  /// Piggyback Capture's getProperty and use parameters and interfaces unique to http connections
  /// Implement JSON Rpc protocols.
  Future<CaptureProperty> getProperty(
      int clientOrDeviceHandle, CaptureProperty property) async {
    final Map<String, dynamic> newParams =
        Params(handle: clientOrDeviceHandle, property: property).toJson();
    final JRpcRequest getRequest = JRpcRequest(
        id: _getJsonRpcId(), method: 'getproperty', params: newParams);

    try {
      final JRpcResponse response = await sendRequest(getRequest);
      final CaptureResult? result = response.captureResult;
      if (clientOrDeviceHandle != result?.handle) {
        throw CaptureException(
            SktErrors.ESKT_INVALIDHANDLE,
            'The provided handle is invalid',
            'The response handle does not match with the handle of the request');
      }
      return result?.property ??
          (throw Exception('Missing property in response'));
    } on CaptureException {
      rethrow;
    } catch (e) {
      throw CaptureException(SktErrors.ESKT_NOTHINGTOLISTEN, 'Unable to send setProperty.', e.toString());
    }
  }

  @override

  /// Piggyback Capture's setProperty and use parameters and interfaces unique to http connections
  /// Implement JSON Rpc protocols.
  Future<CaptureProperty> setProperty(
      int clientOrDeviceHandle, CaptureProperty property) async {
    final Params newParams =
        Params(handle: clientOrDeviceHandle, property: property);

    final JRpcRequest setRequest = JRpcRequest(
        id: _getJsonRpcId(), method: 'setproperty', params: newParams);

    try {
      final JRpcResponse response = await sendRequest(setRequest);
      final CaptureResult? result = response.captureResult;
      if (clientOrDeviceHandle != result?.handle) {
        throw CaptureException(
            SktErrors.ESKT_INVALIDHANDLE,
            'The provided handle is invalid',
            'The response handle does not match with the handle of the request');
      }
      return result?.property ??
          (throw Exception('Missing property in response'));
    } on CaptureException {
      rethrow;
    } catch (e) {
      throw CaptureException(SktErrors.ESKT_NOTHINGTOLISTEN, 'Unable to send setProperty.', e.toString());
    }
  }

  /// Helper function for constructing, validating and handling various HTTP requests for capture.
  Future<JRpcResponse> sendRequest(JRpcRequest request) async {
    final String uriString = host ?? '';
    final Uri uri = Uri.parse(uriString);
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json'
    };

    // ignore: prefer_function_declarations_over_variables
    Future<JRpcResponse> helper(JRpcRequest jsonRpc) async {
      try {
        final String jsonRpcString = json.encode(jsonRpc.toJson());
        logger?.log('${jsonRpc.method} =>', jsonRpcString);
        final Response res =
            await post(uri, headers: headers, body: jsonRpcString);
        final Map<String, dynamic> jsonResponse =
            json.decode(res.body) as Map<String, dynamic>;
        final JRpcResponse jrpcResponse = JRpcResponse.fromJson(jsonResponse);
        final JRpcError? error = jrpcResponse.error;
        if (error != null) {
          throw CaptureException(error.code, error.message);
        } else {
          return jrpcResponse;
        }
        // ignore: unused_catch_clause
      } on CaptureException catch (err) {
        rethrow;
      } catch (err) {
        throw CaptureException(SktErrors.ESKT_COMMUNICATIONERROR,
            'There was an error during communication.', err.toString());
      }
    }

    final JRpcResponse response = await helper(request);

    logger?.log('${request.method} <=', json.encode(response.toString()));

    if (request.method == 'openclient') {
      final CaptureResult? openResult = response.captureResult;
      if (openResult == null) {
        throw Exception('Unexpected response');
      }
      _clientHandle = openResult.handle;
      openWebSocket();
    }
    return response;
  }

  /// Opens a websocket for receiving Capture events.
  ///
  /// After each received event, re-sends `waitforcaptureevent` so the server
  /// delivers the next one (long-polling protocol).
  void openWebSocket() {
    websocket = WebSocketChannel.connect(Uri.parse(hostWebsocket));
    logger?.log('websocket =>', 'open attempt');
    _sendWaitForEvent();
    websocket!.stream.listen(
      (dynamic message) {
        logger?.log('receiving something through the websocket:', message);
        final Map<String, dynamic> jsonRes =
            json.decode(message as String) as Map<String, dynamic>;
        final JRpcResponse response = JRpcResponse.fromJson(jsonRes);
        final CaptureResult? result = response.captureResult;
        final CaptureEvent? event = result?.event;
        if (event != null) {
          notification(event, result?.handle);
        } else if (jsonRes['error'] != null) {
          logger!.log('Error in listener',
              '${jsonRes['error']['code']}: ${jsonRes['error']['message']}');
          final CaptureException err = CaptureException(
              jsonRes['error']['code'] as int,
              jsonRes['error']['message'] as String);
          notification(err, 00000);
        } else {
          logger?.log('websocket =>', 'No result returned');
        }
      },
      onDone: () {
        logger?.log('websocket =>', 'websocket closed!');
      },
      onError: (dynamic error) {
        final CaptureException err;
        if (error is WebSocketChannelException) {
          err = CaptureException(
            SktErrors.ESKT_SERVICENOTCOMMUNICATING,
            'WebSocket channel error: ${error.message}',
          );
        } else {
          err = CaptureException(
            SktErrors.ESKT_SERVICENOTCOMMUNICATING,
            'Service is unable to communicate',
          );
        }
        notification(err);
      },
    );
  }

  void _sendWaitForEvent() {
    if (websocket == null || _clientHandle == null) {
      return;
    }
    final Map<String, dynamic> waitForEvent = JRpcRequest(
      id: '1',
      method: 'waitforcaptureevent',
      params: Params(handle: _clientHandle!),
    ).toJson();
    websocket!.sink.add(json.encode(waitForEvent));
  }

  /// Helper for generating new id for new json rpc instance.
  String _getJsonRpcId() {
    if (rpcId < 999) {
      rpcId++;
    } else {
      rpcId = 1;
    }
    return rpcId.toString();
  }

  /// Function to attach passed onEventNotification to websocket channel listener.
  dynamic notification(dynamic event, [int? handle]) {
    final void Function(dynamic, int)? func = onEventNotification;
    if (func != null) {
      final int hand = handle ?? event.handle as int;
      func(event, hand);
    } else {
      throw CaptureException(SktErrors.ESKT_EVENTNOTCREATED,
          'please provide function for this.onEventNotification.');
    }
  }
}
