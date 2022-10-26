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

  @override
  Future<String?> getFullDemo() async {
    final result = await methodChannel.invokeMethod<String>('fullDemo');
    return result;
  }

  @override
  Future<String?> connectByWifi() async {
    final result = await methodChannel.invokeMethod<String>('connectByWifi');
    return result;
  }

  @override
  Future<String?> connectByUsb() async {
    final result = await methodChannel.invokeMethod<String>('connectByUsb');
    return result;
  }

  @override
  Future<String?> connectByBle() async {
    final result = await methodChannel.invokeMethod<String>('connectByBle');
    return result;
  }

  @override
  Future<String?> closeCamera() async {
    final result = await methodChannel.invokeMethod<String>('closeCamera');
    return result;
  }

  @override
  Future<String?> capture() async {
    final result = await methodChannel.invokeMethod<String>('capture');
    return result;
  }

  @override
  Future<String?> getPreview() async {
    final result = await methodChannel.invokeMethod<String>('preview');
    return result;
  }

  @override
  Future<String?> getPreview2() async{
    final result = await methodChannel.invokeMethod<String>('preview2');
    return result;
  }

  @override
  Future<String?> getPreview3() async{
    final result = await methodChannel.invokeMethod<String>('preview3');
    return result;
  }

  @override
  Future<String?> getLive() async{
    final result = await methodChannel.invokeMethod<String>('live');
    return result;
  }

  @override
  Future<String?> getOsc() async{
    final result = await methodChannel.invokeMethod<String>('osc');
    return result;
  }

  @override
  Future<String?> getSetting() async{
    final result = await methodChannel.invokeMethod<String>('setting');
    return result;
  }
}
