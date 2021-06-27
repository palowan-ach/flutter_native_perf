package com.example.native_perf

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "ssoChannel"
    private var name:String = ""
    private lateinit var _result: MethodChannel.Result

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "startSSO") {
                _result = result
                startNewActivity()
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if(requestCode == 1){
            if (resultCode == RESULT_OK){
                name = data?.getStringExtra("name").toString()
                _result.success(name)
            }
        }
    }


    private fun startNewActivity() {
        val intent = Intent(this, SSOActivity().javaClass)
        startActivityForResult(intent,1);
    }

}
