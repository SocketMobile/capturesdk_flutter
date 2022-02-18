// ignore_for_file: unnecessary_this
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../capture_flutter_beta.dart';

/// Main transport for establishing and making requests on Android.
/// utilizing json rpc as well as Websockets to establish channel.
class HttpTransport extends Transport {
  String? host;
  bool? isWeb;
  Logger? logger;
  String hostWebsocket = '';
  WebSocketChannel? websocket;
  Function? onEventNotification;
  int rpcId = 1;

  HttpTransport(this.logger, [this.isWeb]);

  @override
  /// Piggyback Capture's openClient and use parameters and interfaces unique to http connections
  /// Implement JSON Rpc protocols.
  Future<int> openClient(
      String host, AppInfo appInfo, Function notification) async {
    var jsonRpc = JRpcRequest(this._getJsonRpcId(), 'openclient', appInfo);

    RegExp exp = RegExp(r'(http|ftp|https):');
    this.host = host + '/Capture/v1/api';
    this.hostWebsocket = host.replaceAll(exp, 'ws:');

    this.onEventNotification = notification;

    try {
      JRpcResponse response = await this.sendRequest(jsonRpc);
      dynamic r = json.decode(response.result);
      if (r['result'] != null && r['result']['handle'] != null) {
        return r['result']['handle'];
      } else {
        throw CaptureException(SktErrors.ESKT_NOERROR, "No error.");
      }
    } on CaptureException {
      rethrow;
    } catch (ex) {
      throw CaptureException(-32602, 'Something went wrong.', ex.toString());
    }
  }

  @override
  /// Piggyback Capture's openDevice and use parameters and interfaces unique to http connections
  /// Implement JSON Rpc protocols.
  Future<int> openDevice(int? clientHandle, String guid) async {
    JRpcRequest openRequest = JRpcRequest(
        this._getJsonRpcId(), 'opendevice', Params(clientHandle, guid: guid));

    try {
      JRpcResponse response = await this.sendRequest(openRequest);
      dynamic r = json.decode(response.result);
      var fin = r['result'];
      return fin['handle'];
    } on CaptureException {
      rethrow;
    } catch (ex) {
      throw CaptureException(-32602, 'Something went wrong.', ex.toString());
    }
  }

  @override
  /// Piggyback Capture's close and use parameters and interfaces unique to http connections
  /// Implement JSON Rpc protocols.
  Future<int> close(int? handle) async {
    JRpcRequest closeRequest =
        JRpcRequest(this._getJsonRpcId(), 'close', Params(handle));

    try {
      await this.sendRequest(closeRequest);
      return SktErrors.ESKT_NOERROR;
    } on CaptureException {
      rethrow;
    } catch (e) {
      throw CaptureException(-32602, 'Something went wrong.', e.toString());
    }
  }

  @override
  /// Piggyback Capture's getProperty and use parameters and interfaces unique to http connections
  /// Implement JSON Rpc protocols.
  Future<CaptureProperty> getProperty(
      int? clientOrDeviceHandle, CaptureProperty property) async {
    var newParams =
        Params(clientOrDeviceHandle, property: property.toJson()).toJson();
    var getRequest =
        JRpcRequest(this._getJsonRpcId(), 'getproperty', newParams);

    try {
      dynamic response = await this.sendRequest(getRequest);
      Map<String, dynamic> res =
          json.decode(response.toJson()['result'])['result'];
      if (clientOrDeviceHandle != res['handle']) {
        throw CaptureException(
            SktErrors.ESKT_INVALIDHANDLE,
            'The provided handle is invalid',
            'The response handle does not match with the handle of the request');
      }
      return CaptureProperty(res['property']['id'], res['property']['type'],
          res['property']['value']);
    } on CaptureException {
      rethrow;
    } catch (e) {
      throw CaptureException(-32602, 'Something went wrong.', e.toString());
    }
  }

  @override
  /// Piggyback Capture's setProperty and use parameters and interfaces unique to http connections
  /// Implement JSON Rpc protocols.
  Future<CaptureProperty> setProperty(
      int? clientOrDeviceHandle, CaptureProperty property) async {
    Params newParams =
        Params(clientOrDeviceHandle, property: property.toJson());

    var setRequest =
        JRpcRequest(this._getJsonRpcId(), 'setproperty', newParams.toJson());

    try {
      dynamic response = await this.sendRequest(setRequest);
      Map<String, dynamic> res =
          json.decode(response.toJson()['result'])['result'];
      if (clientOrDeviceHandle != res['handle']) {
        throw CaptureException(
            SktErrors.ESKT_INVALIDHANDLE,
            'The provided handle is invalid',
            'The response handle does not match with the handle of the request');
      }
      return CaptureProperty(res['property']['id'], res['property']['type'],
          res['property']['value']);
    } on CaptureException {
      rethrow;
    } catch (e) {
      throw CaptureException(-32602, 'Something went wrong.', e.toString());
    }
  }

  /// Helper function for constructing, validating and handling various HTTP requests for capture.
  Future sendRequest(JRpcRequest request) async {
    String uriString = this.host ?? '';
    final uri = Uri.parse(uriString);
    final headers = {'Content-Type': 'application/json'};

    // ignore: prefer_function_declarations_over_variables
    Future helper(JRpcRequest jsonRpc) async {
      try {
        String jsonRpcString = json.encode(jsonRpc.toJson());
        logger!.log(jsonRpc.method.toString() + ' =>', jsonRpcString);
        Response res = await post(uri, headers: headers, body: jsonRpcString);
        dynamic err = json.decode(res.body)['error'];
        if (err != null) {
          throw CaptureException(err['code'], err['message'] ?? 'no message');
        } else {
          return JRpcResponse(1, res.body);
        }
      } catch (err) {
        throw CaptureException(-2100, 'Something went wrong.', err.toString());
      }
    }

    JRpcResponse response = await helper(request);

    logger!.log(
        request.method.toString() + ' <=', json.encode(response.toString()));

    if (request.method == 'openclient') {
      /// we want to start the web service here if we can
      this.openWebSocket((event) {
        if (response.runtimeType == JRpcResponse) {
          /// send a waitForEvent
          if (response.result != null) {
            dynamic r = json.decode(response.result);
            int handle = r['result']['handle'];
            Map<String, dynamic> waitForEvent =
                JRpcRequest(1, 'waitforcaptureevent', Params(handle)).toJson();
            String waitForEventString = json.encode(waitForEvent);
            //use sink.add to send data to server
            this.websocket!.sink.add(waitForEventString);
          }
          return;
        }
      });
    }
    return response;
  }
  /// Function used to implement instance of WebSocketChannel to create a stream for capture library to use and stay connected to.
  /// Helps to maintain network for capture notifications.
  /// Since this is over HTTP we use websocket. For iOS there is no need to establish websockets since we connect to the iOS service.
  openWebSocket(void Function(dynamic event) callback) {
    this.websocket = WebSocketChannel.connect(Uri.parse(this.hostWebsocket));
    this.logger!.log('websocket =>', 'open attempt');
    callback(this.websocket);
    this.websocket!.stream.listen(
      (dynamic message) {
        this.logger!.log('receiving something through the websocket:', message);
        Map jsonRes = json.decode(message);
        if (jsonRes['result'] != null && jsonRes['result']['event'] != null) {
          int handle = jsonRes['result']['handle'];
          int type = jsonRes['result']['event']['type'];
          int id = jsonRes['result']['event']['id'];
          dynamic value =
              typifyValue(jsonRes['result']['event']['value'], type);
          CaptureEvent evt = CaptureEvent(id, type, value, handle);
          this.notification(evt);
        } else if (jsonRes['error'] != null) {
          this.logger!.log('Error in listener', jsonRes['error']);
        } else {
          this.logger!.log('Uh oh =>', 'No result returned');
        }
      },
      onDone: () {
        this.logger!.log('websocket =>', 'websocket closed!');
      },
      onError: (error) {
        if (error.hashCode == 1006) {
          CaptureException err = CaptureException(
              error.hashCode.toInt(), 'Websocket cannot communicate');
          this.notification(err);
        } else {
          CaptureException err = CaptureException(
              SktErrors.ESKT_SERVICENOTCOMMUNICATING,
              'Service is unable to communicate');
          this.notification(err);
        }
      },
    );
  }

  /// Helper for generating new id for new json rpc instance.
  _getJsonRpcId() {
    if (this.rpcId < 999) {
      return this.rpcId++;
    } else {
      return this.rpcId = 1;
    }
  }

  /// Function to attach passed onEventNotification to websocket channel listener.
  notification(dynamic event, [int? handle]) {
    if (this.onEventNotification != null) {
      var func = this.onEventNotification as Function;
      if (event.runtimeType != CaptureException) {
        int hand = handle ?? event.handle;
        func(event, hand);
      } else {
        return event;
      }
    } else {
      throw CaptureException(SktErrors.ESKT_EVENTNOTCREATED,
          'please provide function for this.onEventNotification.');
    }
  }
}
