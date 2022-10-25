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
}
