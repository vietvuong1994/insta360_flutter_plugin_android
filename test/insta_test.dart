import 'package:flutter_test/flutter_test.dart';
import 'package:insta/insta.dart';
import 'package:insta/insta_platform_interface.dart';
import 'package:insta/insta_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockInstaPlatform
    with MockPlatformInterfaceMixin
    implements InstaPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final InstaPlatform initialPlatform = InstaPlatform.instance;

  test('$MethodChannelInsta is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelInsta>());
  });

  test('getPlatformVersion', () async {
    Insta instaPlugin = Insta();
    MockInstaPlatform fakePlatform = MockInstaPlatform();
    InstaPlatform.instance = fakePlatform;

    expect(await instaPlugin.getPlatformVersion(), '42');
  });
}
