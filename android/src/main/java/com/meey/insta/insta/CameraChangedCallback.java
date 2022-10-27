package com.meey.insta.insta;

import com.arashivision.sdkcamera.camera.callback.ICameraChangedCallback;

public class CameraChangedCallback implements ICameraChangedCallback {

    CameraListenerCallback callBack;

    public CameraChangedCallback(CameraListenerCallback  callBack) {
        this.callBack = callBack;
    }

    @Override
    public void onCameraStatusChanged(boolean enabled) {
        callBack.onCameraStatusChanged(enabled);
    }

    @Override
    public void onCameraConnectError(int errorCode) {
        callBack.onCameraConnectError(errorCode);
    }

    @Override
    public void onCameraSDCardStateChanged(boolean enabled) {
        callBack.onCameraSDCardStateChanged(enabled);
    }


}
