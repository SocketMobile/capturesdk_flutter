package com.capturesdk_flutter; // Replace with your Flutter app's package name

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel;

import com.socketmobile.capture.socketcam.client.CaptureExtension;
import com.socketmobile.capture.client.ConnectionState;

import com.socketmobile.capture.CaptureError;
import com.socketmobile.capture.troy.ExtensionScope;

import java.util.HashMap;
import java.util.Map;
import android.util.Log;

import android.os.Handler;
import android.os.Looper;
import com.capturesdk_flutter.CaptureService;
import com.capturesdk_flutter.CaptureStartResult;

public class CaptureModule implements FlutterPlugin, MethodChannel.MethodCallHandler {

    private static final String BASE_PACKAGE = "com.socketmobile.capture";
    private static final String SERVICE_APP_ID = "com.socketmobile.companion";
    private static final String BROADCAST_RECEIVER = BASE_PACKAGE + ".StartService";
    private static final String ACTION = BASE_PACKAGE + ".START_SERVICE";
    private CaptureExtension mCaptureExtension;
    private MethodChannel methodChannel;
    public Context context;
    public EventChannel eventChannel;
    public EventSink eventSink;

    private Handler mainHandler = new Handler(Looper.getMainLooper());

    public String getName() {
        return "capturesdk_flutter";
    }

    @Override
    public void onAttachedToEngine(FlutterPluginBinding flutterPluginBinding) {
        methodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "capturesdk_flutter_module");
        methodChannel.setMethodCallHandler(this);
        context = flutterPluginBinding.getApplicationContext();
        eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), "capturesdk_flutter_module/events");
        eventChannel.setStreamHandler(new EventChannel.StreamHandler() {
            public void onListen(Object arguments, EventChannel.EventSink eventSink) {
                // You can use the eventSink to send events to Dart
                CaptureModule.this.eventSink = eventSink;
            }

            public void onCancel(Object arguments) {
                // Clean up resources if needed
            }
        });
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "startSocketCamExtension":
                int clientHandle = call.argument("clientHandle");
                startSocketCamExtension(clientHandle);

                result.success(null);
                break;
            case "startCaptureService":
                Log.d("StartCaptureService", "IN NATIVE MODULE");
                startCaptureService(result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    public class SocketCamExtensionEvent {
        String message;
        int status;

        public SocketCamExtensionEvent(String message, int status) {
            this.message = message;
            this.status = status;
        }
    }

    @Override
    public void onDetachedFromEngine(FlutterPluginBinding binding) {
        methodChannel.setMethodCallHandler(null);
    }

    public void triggerEvent(SocketCamExtensionEvent ev) {
        Map<String, Object> eventData = new HashMap<>();
        eventData.put("message", ev.message);
        eventData.put("status", ev.status);

        if (eventSink != null) {
            Log.d("eventSink MESSAGE: ", ev.message);
            Log.d("eventSink status: ", String.valueOf(ev.status));
            eventSink.success(eventData);
        }
    }

    public void startSocketCamExtension(int clientHandle) {
        Log.d("STARTING EXTENSION: ", String.valueOf(clientHandle));
        mCaptureExtension = new CaptureExtension.Builder()
                .setContext(context)
                .setClientHandle(clientHandle)
                .setExtensionScope(ExtensionScope.LOCAL)
                .setListener(mListener)
                .build();
        mCaptureExtension.start();
    }

    public void startCaptureService(MethodChannel.Result result) {
        try {
            CaptureStartResult serviceStarted = CaptureService.start(context);
            if (serviceStarted.code > -1) {
                result.success(serviceStarted.message);
            } else {
                result.success("Could not start capture service. Code: " + serviceStarted.code);
            }
        } catch (Exception e) {
            result.error("CAPTURE_SERVICE_ERROR", "Error starting capture service", e.getMessage());
        }
    }

    private void createExtensionEventAndTrigger(String message, int status) {
        SocketCamExtensionEvent ev = new SocketCamExtensionEvent(message, status);
        triggerEvent(ev);
    }

    private void createExtensionEventAndTriggerOnMainThread(final String message, final int status) {
        mainHandler.post(new Runnable() {
            @Override
            public void run() {
                createExtensionEventAndTrigger(message, status);
            }
        });
    }

    private CaptureExtension.Listener mListener = new CaptureExtension.Listener() {
        @Override
        public void onExtensionStateChanged(ConnectionState connectionState) {
            switch (connectionState.intValue()) {
                case ConnectionState.READY:
                    Log.d("SocketCam", "SocketCam is ready");
                    createExtensionEventAndTriggerOnMainThread("READY", 2);
                    break;
                case ConnectionState.DISCONNECTED:
                    createExtensionEventAndTriggerOnMainThread("DISCONNECTED", 0);
                    break;
                case ConnectionState.CONNECTING:
                    createExtensionEventAndTriggerOnMainThread("CONNECTING", 1);
                default:
                    break;
            }
        }

        @Override
        public void onError(CaptureError error) {
            Log.d("onError", "ERROR" + error.getCode());
            createExtensionEventAndTrigger("SocketCamExtension ERROR " + error, -1000);
        }
    };

    private Intent getStartIntent() {
        return new Intent(ACTION)
                .setComponent(new ComponentName(SERVICE_APP_ID, BROADCAST_RECEIVER));
    }
}