package com.capturesdk_flutter; // Replace with your Flutter app's package name

import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.fragment.app.FragmentActivity;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

import com.socketmobile.capture.socketcam.client.CaptureExtension;
import com.socketmobile.capture.socketcam.view.SocketCamFragment;
import com.socketmobile.capture.client.ConnectionState;

import com.socketmobile.capture.CaptureError;
import com.socketmobile.capture.troy.ExtensionScope;

import java.util.HashMap;
import java.util.Map;
import android.util.Log;

import android.os.Handler;
import android.os.Looper;

/**
 * Flutter plugin module for Socket Mobile CaptureSDK on Android.
 *
 * This module manages the CaptureExtension lifecycle and provides the bridge
 * between the Flutter Dart layer and the native SocketCam SDK.
 *
 * <h3>Full-screen mode (default)</h3>
 * The extension is built WITHOUT a CustomViewListener. When the user triggers
 * SocketCam via {@code setTrigger(Trigger.start)}, the SDK opens its own
 * full-screen camera Activity. No Flutter PlatformView is needed.
 *
 * <h3>Custom view mode (advanced)</h3>
 * To embed the camera preview inside your own Flutter layout, the extension
 * must be built WITH a CustomViewListener. This is mutually exclusive with
 * full-screen mode because CaptureExtension is a singleton — the first
 * {@code build()} call locks in the configuration for the process lifetime.
 *
 * To enable custom view mode:
 * <ol>
 *   <li>In {@link #buildAndStartExtension()}, add
 *       {@code .setCustomViewListener(mCustomViewListener)} to the builder.</li>
 *   <li>In the Dart layer, mount a {@code SocketCamView} widget — this creates
 *       a PlatformView whose container receives the SocketCamFragment.</li>
 *   <li>The {@code onViewReady(handle)} callback provides the handle needed
 *       by {@code SocketCamFragment.newInstance(handle, false)}.</li>
 *   <li>Call {@code setTrigger(Trigger.start)} on the device to start scanning
 *       inside the embedded fragment.</li>
 * </ol>
 *
 * See the commented-out custom view code below for the full implementation.
 */
public class CaptureModule implements FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {

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

    private int storedClientHandle = 0;

    // --- Custom view support (uncomment for custom view mode) ---
    // private FragmentActivity activity;
    // private Integer customViewHandle = null;
    // private FrameLayout socketCamContainer;

    public String getName() {
        return "capturesdk_flutter";
    }

    // --- ActivityAware ---

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        // Uncomment for custom view mode — needed for FragmentManager access:
        // Activity raw = binding.getActivity();
        // if (raw instanceof FragmentActivity) {
        //     activity = (FragmentActivity) raw;
        // }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        // activity = null;
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        // Activity raw = binding.getActivity();
        // if (raw instanceof FragmentActivity) {
        //     activity = (FragmentActivity) raw;
        // }
    }

    @Override
    public void onDetachedFromActivity() {
        // activity = null;
    }

    // --- FlutterPlugin ---

    @Override
    public void onAttachedToEngine(FlutterPluginBinding flutterPluginBinding) {
        methodChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "capturesdk_flutter_module");
        methodChannel.setMethodCallHandler(this);
        context = flutterPluginBinding.getApplicationContext();
        eventChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), "capturesdk_flutter_module/events");
        eventChannel.setStreamHandler(new EventChannel.StreamHandler() {
            public void onListen(Object arguments, EventChannel.EventSink eventSink) {
                CaptureModule.this.eventSink = eventSink;
            }

            public void onCancel(Object arguments) {
            }
        });

        // Register the PlatformView factory for custom view mode.
        // This is harmless in full-screen mode — the factory is registered
        // but never instantiated since no SocketCamView widget is mounted.
        flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(
            "com.socketmobile.capturesdk/socket_cam_view",
            new SocketCamViewFactory(this)
        );
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "startSocketCamExtension":
                int clientHandle = call.argument("clientHandle");
                startSocketCamExtension(clientHandle);
                result.success(null);
                break;
            case "stopSocketCamExtension":
                stopSocketCamExtension();
                result.success(null);
                break;
            case "startCaptureService":
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
            eventSink.success(eventData);
        }
    }

    // --- Extension lifecycle ---

    public void startSocketCamExtension(int clientHandle) {
        storedClientHandle = clientHandle;
        buildAndStartExtension();
    }

    /**
     * Builds and starts the CaptureExtension.
     *
     * IMPORTANT: CaptureExtension is a singleton — the first build() call
     * determines the configuration for the entire process lifetime. Subsequent
     * build() calls return the existing instance and ignore new builder settings.
     *
     * Full-screen mode: built WITHOUT CustomViewListener.
     * Custom view mode: built WITH CustomViewListener (see class Javadoc).
     */
    private void buildAndStartExtension() {
        Log.d("SocketCam", "Building extension: handle=" + storedClientHandle);
        CaptureExtension.Builder builder = new CaptureExtension.Builder()
                .setContext(context)
                .setClientHandle(storedClientHandle)
                .setExtensionScope(ExtensionScope.LOCAL)
                .setListener(mListener);
        // --- Custom view mode: uncomment to enable embedded camera preview ---
        // builder.setCustomViewListener(mCustomViewListener);
        mCaptureExtension = builder.build();
        mCaptureExtension.start();
    }

    public void stopSocketCamExtension() {
        if (mCaptureExtension != null) {
            Log.d("SocketCam", "Stopping CaptureExtension");
            mCaptureExtension.stop();
            mCaptureExtension = null;
        }
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

    // --- Event helpers ---

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

    // --- Listeners ---

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

    // --- Custom view listener (uncomment for custom view mode) ---
    //
    // When the extension is built with CustomViewListener, the SDK calls
    // onViewReady() once during startup with the handle required to create
    // a SocketCamFragment. This handle must be stored and reused — it is
    // only provided once per extension lifetime (singleton).
    //
    // private CaptureExtension.CustomViewListener mCustomViewListener =
    //         new CaptureExtension.CustomViewListener() {
    //     @Override
    //     public void onViewReady(int handle) {
    //         Log.d("SocketCam", "CustomView onViewReady, handle: " + handle);
    //         customViewHandle = handle;
    //         mainHandler.post(() -> showSocketCamFragment());
    //         createExtensionEventAndTriggerOnMainThread("READY", 2);
    //     }
    // };

    // --- Custom view fragment management (uncomment for custom view mode) ---
    //
    // void setSocketCamContainer(FrameLayout container, Context viewContext) {
    //     socketCamContainer = container;
    //     if (activity == null && viewContext instanceof FragmentActivity) {
    //         activity = (FragmentActivity) viewContext;
    //     }
    //     showSocketCamFragment();
    // }
    //
    // void clearSocketCamContainer(FrameLayout container) {
    //     if (socketCamContainer == container) {
    //         socketCamContainer = null;
    //     }
    // }
    //
    // private void showSocketCamFragment() {
    //     if (activity == null || socketCamContainer == null || customViewHandle == null) {
    //         return;
    //     }
    //     socketCamContainer.setId(android.view.View.generateViewId());
    //     SocketCamFragment fragment = SocketCamFragment.newInstance(customViewHandle, false);
    //     activity.getSupportFragmentManager()
    //             .beginTransaction()
    //             .replace(socketCamContainer.getId(), fragment)
    //             .runOnCommit(() -> {
    //                 android.view.View fragmentView = fragment.getView();
    //                 if (fragmentView != null) {
    //                     fragmentView.setLayoutParams(new FrameLayout.LayoutParams(
    //                             FrameLayout.LayoutParams.MATCH_PARENT,
    //                             FrameLayout.LayoutParams.MATCH_PARENT));
    //                 }
    //             })
    //             .commitAllowingStateLoss();
    // }

    private Intent getStartIntent() {
        return new Intent(ACTION)
                .setComponent(new ComponentName(SERVICE_APP_ID, BROADCAST_RECEIVER));
    }

    // --- SocketCamView PlatformView support ---
    // Used by custom view mode. The factory is always registered but only
    // instantiated when a SocketCamView widget is mounted in Flutter.

    private static class SocketCamViewFactory extends PlatformViewFactory {
        private final CaptureModule module;

        SocketCamViewFactory(CaptureModule module) {
            super(StandardMessageCodec.INSTANCE);
            this.module = module;
        }

        @Override
        public PlatformView create(Context context, int viewId, Object args) {
            return new SocketCamPlatformView(context, module);
        }
    }

    private static class SocketCamPlatformView implements PlatformView {
        private final FrameLayout view;
        private final CaptureModule module;

        SocketCamPlatformView(Context context, CaptureModule module) {
            this.module = module;
            view = new FrameLayout(context);
            view.setLayoutParams(new FrameLayout.LayoutParams(
                    FrameLayout.LayoutParams.MATCH_PARENT,
                    FrameLayout.LayoutParams.MATCH_PARENT));
            view.setClipChildren(true);
            view.setClipToPadding(true);
            // Uncomment for custom view mode:
            // module.setSocketCamContainer(view, context);
        }

        @Override
        public android.view.View getView() {
            return view;
        }

        @Override
        public void dispose() {
            // Uncomment for custom view mode:
            // module.clearSocketCamContainer(view);
        }
    }
}
