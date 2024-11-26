package com.umair.beacons_plugin_example

import com.umair.beacons_plugin.BeaconsPlugin;
import io.flutter.embedding.android.FlutterActivity;
import android.nfc.NfcAdapter;
import android.content.Intent;
import android.app.PendingIntent;


class MainActivity : FlutterActivity(){

    override fun onPause() {
        super.onPause()

        //Start Background service to scan BLE devices
       BeaconsPlugin.startBackgroundService(this)

//        val nfcAdapter: NfcAdapter = NfcAdapter.getDefaultAdapter(this) ?: return
//        nfcAdapter.disableForegroundDispatch(this)
    }

    override fun onResume() {
        super.onResume()

        //Stop Background service, app is in foreground
    BeaconsPlugin.stopBackgroundService(this)

//        val nfcAdapter: NfcAdapter = NfcAdapter.getDefaultAdapter(this)
//        val intent = Intent(this, MainActivity::class)
//        intent.setFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP)
//        val pendingIntent: PendingIntent = PendingIntent.getActivities(this, 0, arrayOf<Intent>(intent), 0)
//        if (nfcAdapter == null) return
//        val techList = arrayOf<Array<String>>()
//        nfcAdapter.enableForegroundDispatch(this, pendingIntent, null, null)
    }
}
