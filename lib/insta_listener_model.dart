class InstaListenerModel {
  Function(bool)? onCameraStatusChanged;
  Function(int)? onCameraConnectError;
  Function(bool)? onCameraSDCardStateChanged;

  InstaListenerModel({
    this.onCameraSDCardStateChanged,
    this.onCameraStatusChanged,
    this.onCameraConnectError,
  });
}
