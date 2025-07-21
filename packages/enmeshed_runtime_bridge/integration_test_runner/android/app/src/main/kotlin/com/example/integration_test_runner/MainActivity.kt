package com.example.integration_test_runner

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    init {
        System.loadLibrary("cal_flutter_plugin")
    }
}
