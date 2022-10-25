import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'insta_platform_interface.dart';

/// An implementation of [InstaPlatform] that uses method channels.
class MethodChannelInsta extends InstaPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('insta');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
