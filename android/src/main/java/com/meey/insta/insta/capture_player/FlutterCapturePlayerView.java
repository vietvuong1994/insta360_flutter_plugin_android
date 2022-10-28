package com.meey.insta.insta.capture_player;

import static io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import static io.flutter.plugin.common.MethodChannel.Result;

import android.content.Context;
import android.view.View;
import android.widget.TextView;

import com.arashivision.sdkcamera.camera.InstaCameraManager;
import com.arashivision.sdkcamera.camera.callback.IPreviewStatusListener;
import com.arashivision.sdkmedia.player.capture.CaptureParamsBuilder;
import com.arashivision.sdkmedia.player.capture.InstaCapturePlayerView;
import com.arashivision.sdkmedia.player.config.InstaStabType;
import com.arashivision.sdkmedia.player.listener.PlayerViewListener;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class FlutterCapturePlayerView implements PlatformView, MethodCallHandler {
    private final InstaCapturePlayerView capturePlayer;
    private final MethodChannel methodChannel;

    FlutterCapturePlayerView(Context context, BinaryMessenger messenger, int id) {
        capturePlayer = new InstaCapturePlayerView(context);
        methodChannel = new MethodChannel(messenger, "plugins.meey.insta/capture_player_view_" + id);
        methodChannel.setMethodCallHandler(this);

    }

    @Override
    public View getView() {
        return capturePlayer;
    }

    @Override
    public void onMethodCall(MethodCall methodCall, Result result) {
        switch (methodCall.method) {
            case "switchNormalMode":
                switchNormalMode(result);
                break;
            case "switchFisheyeMode":
                switchFisheyeMode(result);
                break;
            case "switchPerspectiveMode":
                switchPerspectiveMode(result);
                break;
            case "isStabEnabled":
                isStabEnabled(result);
                break;
            case "setStabType":
                setStabType(methodCall, result);
                break;
            case "onInit":
                onInit(methodCall, result);
                break;
            case "play":
                play(result);
                break;
            case "dispose":
                dispose(result);
                break;
            case "stop":
                stop(result);
                break;
            default:
                result.notImplemented();
        }

    }

    private void switchNormalMode(Result result) {
        capturePlayer.switchNormalMode();
        result.success(null);
    }

    private void switchFisheyeMode(Result result) {
        capturePlayer.switchFisheyeMode();
        result.success(null);
    }

    private void switchPerspectiveMode(Result result) {
        capturePlayer.switchPerspectiveMode();
        result.success(null);
    }

    private void isStabEnabled(Result result) {
        capturePlayer.isStabEnabled();
        result.success(null);
    }

    private void setStabType(MethodCall methodCall, Result result) {
        int stabType = (int) methodCall.arguments;
        capturePlayer.setStabType(stabType);
        result.success(null);
    }



    private void play(Result result) {
        InstaCameraManager.getInstance().startPreviewStream();
        result.success(null);
    }

    private void stop(Result result) {
        InstaCameraManager.getInstance().closePreviewStream();
        result.success(null);
    }

    private void dispose(Result result) {
        InstaCameraManager.getInstance().setPreviewStatusChangedListener(null);
        InstaCameraManager.getInstance().closePreviewStream();
        capturePlayer.destroy();
        result.success(null);
    }

    private void onInit(MethodCall methodCall, Result result){
        PreviewStatusCallback callback = new PreviewStatusCallback(){
            @Override
            public void onOpening() {}

            @Override
            public void onOpened() {
                InstaCameraManager.getInstance().setStreamEncode();
                capturePlayer.setPlayerViewListener(new PlayerViewListener() {
                    @Override
                    public void onLoadingFinish() {
                        InstaCameraManager.getInstance().setPipeline(capturePlayer.getPipeline());
                    }

                    @Override
                    public void onReleaseCameraPipeline() {
                        InstaCameraManager.getInstance().setPipeline(null);
                    }
                });
                capturePlayer.prepare(createParams());
                capturePlayer.play();
                capturePlayer.setKeepScreenOn(true);
            }

            @Override
            public void onIdle() {
                capturePlayer.destroy();
                capturePlayer.setKeepScreenOn(false);
            }

            @Override
            public void onError() {

            }
        };
        IPreviewStatusListener listener = new PreviewStatusListener(callback);
        InstaCameraManager.getInstance().setPreviewStatusChangedListener(listener);
        result.success(null);
    }

    private CaptureParamsBuilder createParams() {
        CaptureParamsBuilder builder = new CaptureParamsBuilder()
                .setCameraType(InstaCameraManager.getInstance().getCameraType())
                .setMediaOffset(InstaCameraManager.getInstance().getMediaOffset())
                .setMediaOffsetV2(InstaCameraManager.getInstance().getMediaOffsetV2())
                .setMediaOffsetV3(InstaCameraManager.getInstance().getMediaOffsetV3())
                .setCameraSelfie(InstaCameraManager.getInstance().isCameraSelfie())
                .setGyroTimeStamp(InstaCameraManager.getInstance().getGyroTimeStamp())
                .setBatteryType(InstaCameraManager.getInstance().getBatteryType())
                .setStabType(getStabType(0))
                .setStabEnabled(true);
//        if (mCurrentResolution != null) {
//            builder.setResolutionParams(mCurrentResolution.width, mCurrentResolution.height, mCurrentResolution.fps);
//        }
//        if (mRbPlane.isChecked()) {
//            // 平铺模式
//            // Plane Mode
//            builder.setRenderModelType(CaptureParamsBuilder.RENDER_MODE_PLANE_STITCH)
//                    .setScreenRatio(2, 1);
//        } else {
//            // 普通模式
//            // Normal Mode
//            builder.setRenderModelType(CaptureParamsBuilder.RENDER_MODE_AUTO);
//        }
        return builder;
    }

    private int getStabType(int stabType) {
        switch (stabType) {
            case 0:
            default:
                return InstaStabType.STAB_TYPE_AUTO;
            case 1:
                return InstaStabType.STAB_TYPE_PANORAMA;
            case 2:
                return InstaStabType.STAB_TYPE_CALIBRATE_HORIZON;
            case 3:
                return InstaStabType.STAB_TYPE_FOOTAGE_MOTION_SMOOTH;
        }
    }

    @Override
    public void dispose() {}
}
