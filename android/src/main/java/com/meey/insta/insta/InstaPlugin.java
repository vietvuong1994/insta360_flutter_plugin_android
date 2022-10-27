package com.meey.insta.insta;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.util.Log;

import androidx.annotation.NonNull;

import com.arashivision.sdkcamera.InstaCameraSDK;
import com.arashivision.sdkcamera.camera.InstaCameraManager;
import com.arashivision.sdkcamera.camera.callback.ICameraChangedCallback;
import com.arashivision.sdkmedia.InstaMediaSDK;
import com.meey.insta.insta.activity.BleActivity;
import com.meey.insta.insta.activity.CameraFilesActivity;
import com.meey.insta.insta.activity.CaptureActivity;
import com.meey.insta.insta.activity.FullDemoActivity;
import com.meey.insta.insta.activity.FwUpgradeActivity;
import com.meey.insta.insta.activity.LiveActivity;
import com.meey.insta.insta.activity.MoreSettingActivity;
import com.meey.insta.insta.activity.OscActivity;
import com.meey.insta.insta.activity.PlayAndExportActivity;
import com.meey.insta.insta.activity.Preview2Activity;
import com.meey.insta.insta.activity.Preview3Activity;
import com.meey.insta.insta.activity.PreviewActivity;
import com.meey.insta.insta.activity.StitchActivity;
import com.meey.insta.insta.util.AssetsUtil;
import com.meey.insta.insta.util.CameraBindNetworkManager;
import com.meey.insta.insta.util.NetworkManager;

import java.io.File;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class InstaPlugin extends Application implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private static Activity activity;

  public static Context getInstance() {
    return activity.getApplicationContext();
  }

  @Override
  public void onCreate() {
    InstaCameraSDK.init(this);
    InstaMediaSDK.init(this);


//    if (InstaCameraManager.getInstance().getCameraConnectedType() != InstaCameraManager.CONNECT_TYPE_NONE) {
//      onCameraStatusChanged(true);
//    }
    super.onCreate();
  }



  @Override
  public void onConfigurationChanged(@NonNull Configuration newConfig) {

    super.onConfigurationChanged(newConfig);
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {

    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "insta");
    channel.setMethodCallHandler(this);

    ICameraChangedCallback cameraCallback = new CameraChangedCallback(new CameraListenerCallback () {
      @Override
      public void onCameraStatusChanged(boolean enabled) {
        Log.d("Log===", "onCameraStatusChanged");
        if(!enabled){
          CameraBindNetworkManager.getInstance().unbindNetwork();
          NetworkManager.getInstance().clearBindProcess();
        }
        channel.invokeMethod("camera_status_change", enabled);
      }

      @Override
      public void onCameraConnectError(int errorCode) {
        Log.d("Log===", "onCameraConnectError" + errorCode + channel);
        CameraBindNetworkManager.getInstance().unbindNetwork();
        channel.invokeMethod("camera_connect_error", errorCode);
      }

      @Override
      public void onCameraSDCardStateChanged(boolean enabled){
        Log.d("Log===", "onCameraSDCardStateChanged");
        channel.invokeMethod("camera_sdcard_state_change", enabled);
      }
    });
    InstaCameraManager.getInstance().registerCameraChangedCallback(cameraCallback);

//    copyHdrSourceFromAssets();
  }


  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      Intent intent = new Intent(activity, FullDemoActivity.class);
      activity.startActivity(intent);
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("fullDemo")) {
      activity.startActivity(new Intent(activity, FullDemoActivity.class));
      result.success("fullDemo");
    }  else if (call.method.equals("connectByWifi")) {
      CameraBindNetworkManager.getInstance().bindNetwork(errorCode -> {
        InstaCameraManager.getInstance().openCamera(InstaCameraManager.CONNECT_TYPE_WIFI);
        if(errorCode == CameraBindNetworkManager.ErrorCode.OK){
          result.success("Network connection success");
        } else {
          result.error("Error", "Network connection failed", "Network connection failed");
        }
      });
    } else if (call.method.equals("connectByUsb")) {
      InstaCameraManager.getInstance().openCamera(InstaCameraManager.CONNECT_TYPE_USB);
      result.success("connectByUsb");
    } else if (call.method.equals("connectByBle")) {
      activity.startActivity(new Intent(activity, BleActivity.class));
      result.success("connectByBle");
    } else if (call.method.equals("closeCamera")) {
      CameraBindNetworkManager.getInstance().unbindNetwork();
      InstaCameraManager.getInstance().closeCamera();
      result.success("closeCamera");
    } else if (call.method.equals("capture")) {
      activity.startActivity(new Intent(activity, CaptureActivity.class));
      result.success("capture");
    } else if (call.method.equals("preview")) {
      activity.startActivity(new Intent(activity, PreviewActivity.class));
      result.success("preview");
    } else if (call.method.equals("preview2")) {
      activity.startActivity(new Intent(activity, Preview2Activity.class));
      result.success("preview2");
    } else if (call.method.equals("preview3")) {
      activity.startActivity(new Intent(activity, Preview3Activity.class));
      result.success("preview3");
    } else if (call.method.equals("live")) {
      activity.startActivity(new Intent(activity, LiveActivity.class));
      result.success("live");
    } else if (call.method.equals("osc")) {
      activity.startActivity(new Intent(activity, OscActivity.class));
      result.success("osc");
    } else if (call.method.equals("listCameraFile")) {
      activity.startActivity(new Intent(activity, CameraFilesActivity.class));
      result.success("listCameraFile");
    } else if (call.method.equals("setting")) {
      activity.startActivity(new Intent(activity, MoreSettingActivity.class));
      result.success("setting");
    } else if (call.method.equals("play")) {
      PlayAndExportActivity.launchActivity(getInstance(), StitchActivity.PURE_SHOT_URLS);
      result.success("play");
    } else if (call.method.equals("stitch")) {
      activity.startActivity(new Intent(activity, StitchActivity.class));
      result.success("stitch");
    } else if (call.method.equals("firmwareUpgrade")) {
      activity.startActivity(new Intent(activity, FwUpgradeActivity.class));
      result.success("firmwareUpgrade");
    } else {
      result.notImplemented();
    }
  }

  private void copyHdrSourceFromAssets() {
    File dirHdr = new File(StitchActivity.HDR_COPY_DIR);
    if (!dirHdr.exists()) {
      AssetsUtil.copyFilesFromAssets(activity, "hdr_source", dirHdr.getAbsolutePath());
    }

    File dirPureShot = new File(StitchActivity.PURE_SHOT_COPY_DIR);
    if (!dirPureShot.exists()) {
      AssetsUtil.copyFilesFromAssets(activity, "pure_shot_source", dirPureShot.getAbsolutePath());
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
