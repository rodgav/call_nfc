package com.rsgmsolutions.call_nfc

import android.app.PendingIntent
import android.content.Intent
import android.nfc.NdefMessage
import android.nfc.NfcAdapter
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

private const val CHANNEL_NAME = "com.rsgmsolutions.call_nfc/card"

class MainActivity : FlutterActivity() {
    private var nfcCardChannel: MethodChannel? = null
    private val pendingIntent: PendingIntent by lazy {
        val intent = Intent(this, javaClass).apply {
            flags = Intent.FLAG_ACTIVITY_SINGLE_TOP
        }
        PendingIntent.getActivity(this, 0, intent, 0)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleNfcIntent(intent)
    }

    private fun handleNfcIntent(intent: Intent?) {
        intent?.let {
            if (NfcAdapter.ACTION_NDEF_DISCOVERED == it.action) {
                val rawMessages = it.getParcelableArrayExtra(NfcAdapter.EXTRA_NDEF_MESSAGES)
                if (rawMessages != null) {
                    val messages = rawMessages.map { it as NdefMessage }
                    val text = String(messages[0].records[0].payload, charset("UTF-8"))
                    nfcCardChannel?.invokeMethod("onCardRead", text)
                }
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        nfcCardChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NAME)
        nfcCardChannel?.setMethodCallHandler { _, _ ->
        }
    }

    override fun onResume() {
        super.onResume()
        handleNfcIntent(intent)
        val adapter = NfcAdapter.getDefaultAdapter(this)
        adapter?.enableForegroundDispatch(this, pendingIntent, null, null)
    }
}
