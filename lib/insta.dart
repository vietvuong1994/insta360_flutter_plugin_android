
import 'insta_platform_interface.dart';

class Insta {
  Future<String?> getPlatformVersion() {
    return InstaPlatform.instance.getPlatformVersion();
  }
}
