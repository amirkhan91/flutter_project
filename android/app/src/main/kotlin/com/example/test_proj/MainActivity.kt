import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Pass SDK version to Dart code
        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, "app_channel")
            .setMethodCallHandler { call, result ->
                if (call.method == "getSdkVersion") {
                    result.success(Build.VERSION.SDK_INT)
                } else {
                    result.notImplemented()
                }
            }
    }
}
