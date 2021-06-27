package com.example.native_perf
import android.content.Context
import android.util.Log
import android.view.View
import android.webkit.WebView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

class MyFlutterView(context: Context, messenger: BinaryMessenger, viewId: Int, args: Map<String, Any>?) : PlatformView {


    val webView: WebView= WebView(context)

    init {
        args?.also {
            webView.loadUrl(it["url"] as String)
        }

    }

    override fun getView(): View {

        return webView
    }

    override fun dispose() {
        webView.destroy()
    }
}