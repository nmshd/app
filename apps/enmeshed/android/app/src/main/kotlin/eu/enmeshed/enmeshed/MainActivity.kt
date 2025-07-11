package eu.enmeshed.app

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    init {
        System.loadLibrary("cal_flutter_plugin")
    }
}
