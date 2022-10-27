package com.meey.insta.insta;

public interface CameraListenerCallback {

    void onCameraStatusChanged(boolean enabled);

    void onCameraConnectError(int errorCode);

    void onCameraSDCardStateChanged(boolean enabled);
}
