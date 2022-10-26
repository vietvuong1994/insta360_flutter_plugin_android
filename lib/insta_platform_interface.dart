import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'insta_method_channel.dart';

abstract class InstaPlatform extends PlatformInterface {
  /// Constructs a InstaPlatform.
  InstaPlatform() : super(token: _token);

  static final Object _token = Object();

  static InstaPlatform _instance = MethodChannelInsta();

  /// The default instance of [InstaPlatform] to use.
  ///
  /// Defaults to [MethodChannelInsta].
  static InstaPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [InstaPlatform] when
  /// they register themselves.
  static set instance(InstaPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getFullDemo() {
    throw UnimplementedError('getFullDemo() has not been implemented.');
  }

  Future<String?> connectByWifi() {
    throw UnimplementedError('connectByWifi() has not been implemented.');
  }

  Future<String?> connectByUsb() {
    throw UnimplementedError('connectByUsb() has not been implemented.');
  }

  Future<String?> connectByBle() {
    throw UnimplementedError('connectByBle() has not been implemented.');
  }

  Future<String?> closeCamera() {
    throw UnimplementedError('closeCamera() has not been implemented.');
  }

  Future<String?> capture() {
    throw UnimplementedError('capture() has not been implemented.');
  }

  Future<String?> getPreview() {
    throw UnimplementedError('getPreview() has not been implemented.');
  }

  Future<String?> getPreview2() {
    throw UnimplementedError('getPreview2() has not been implemented.');
  }

  Future<String?> getPreview3() {
    throw UnimplementedError('getPreview3() has not been implemented.');
  }

  Future<String?> getLive() {
    throw UnimplementedError('getLive() has not been implemented.');
  }

  Future<String?> getOsc() {
    throw UnimplementedError('getOsc() has not been implemented.');
  }

  Future<String?> getSetting() {
    throw UnimplementedError('getSetting() has not been implemented.');
  }
}
