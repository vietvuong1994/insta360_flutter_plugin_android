package com.meey.insta.insta;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import com.arashivision.sdkcamera.InstaCameraSDK;
import com.arashivision.sdkmedia.InstaMediaSDK;
import com.meey.insta.insta.activity.FullDemoActivity;
import com.meey.insta.insta.activity.StitchActivity;
import com.meey.insta.insta.activity.TestActivity;
import com.meey.insta.insta.util.AssetsUtil;

import java.io.File;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** InstaPlugin */
public class InstaPlugin extends Application implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Activity activity;
  private static Context context;

  public static Context getInstance() {
    return context;
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {

    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "insta");
    channel.setMethodCallHandler(this);
//    context = flutterPluginBinding.getApplicationContext();

    // Init SDK
    InstaCameraSDK.init(this);
    InstaMediaSDK.init(this);

    // Copy sample pictures from assets to local
    copyHdrSourceFromAssets();
  }


  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
//    Log.e("Quan123---",context.toString());
    if (call.method.equals("getPlatformVersion")) {
      Intent intent = new Intent(context, FullDemoActivity.class);
      intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
      startActivity(intent);
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else {
      result.notImplemented();
    }
  }

  private void copyHdrSourceFromAssets() {
    File dirHdr = new File(StitchActivity.HDR_COPY_DIR);
    if (!dirHdr.exists()) {
      AssetsUtil.copyFilesFromAssets(context, "hdr_source", dirHdr.getAbsolutePath());
    }

    File dirPureShot = new File(StitchActivity.PURE_SHOT_COPY_DIR);
    if (!dirPureShot.exists()) {
      AssetsUtil.copyFilesFromAssets(context, "pure_shot_source", dirPureShot.getAbsolutePath());
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {

  }
}
