package com.pixher.android

import android.net.Uri
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import com.google.android.gms.tasks.Task
import com.google.mlkit.vision.common.InputImage
import com.google.mlkit.vision.label.ImageLabel
import com.google.mlkit.vision.label.ImageLabeling
import com.google.mlkit.vision.label.defaults.ImageLabelerOptions
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {

    private val CHANNEL = "flutter.native/helper"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        MethodChannel(flutterEngine.dartExecutor,CHANNEL).setMethodCallHandler{
                call,result ->
            val labels = ArrayList<String>()
            val uri = call.argument<String>("uri")
            if (call.method=="fetchLabels" && uri!=null){
                fetchLabels(Uri.parse(uri))
                    .addOnSuccessListener {
                        for (label in it) {
                            val text = label.text
                            val confidence = label.confidence
                            val index = label.index
                            labels.add(text)
                        }
                        result.success(labels)
                    }.addOnCanceledListener {
                        result.error("Empty", "No Label found", null)
                    }
            }
        }
    }

    private fun fetchLabels(uri: Uri): Task<List<ImageLabel>> {
        val image: InputImage = InputImage.fromFilePath(context, uri)
        val options = ImageLabelerOptions.Builder()
            .setConfidenceThreshold(0.7f)
            .build()
        val labeler = ImageLabeling.getClient(options)
        return labeler.process(image)
    }
}
