package com.example.example; // Replace with your app's package name

import com.capturesdk_flutter.CaptureModule; // import CaptureModule Native Modules
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterActivity {

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        // Add CAPTUREMODULE plugin instance
        flutterEngine.getPlugins().add(new CaptureModule(getApplicationContext()));
    }

}