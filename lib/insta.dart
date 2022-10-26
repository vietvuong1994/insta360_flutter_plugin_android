
import 'insta_platform_interface.dart';

class Insta {
  Future<String?> getPlatformVersion() {
    return InstaPlatform.instance.getPlatformVersion();
  }

  Future<String?> getFullDemo() {
    return InstaPlatform.instance.getFullDemo();
  }

  Future<String?> connectByWifi() {
    return InstaPlatform.instance.connectByWifi();
  }

  Future<String?> connectByUsb() {
    return InstaPlatform.instance.connectByUsb();
  }

  Future<String?> connectByBle() {
    return InstaPlatform.instance.connectByBle();
  }

  Future<String?> closeCamera() {
    return InstaPlatform.instance.closeCamera();
  }

  Future<String?> capture() {
    return InstaPlatform.instance.capture();
  }
  
  Future<String?> getPreview() {
    return InstaPlatform.instance.getPreview();
  }

  Future<String?> getPreview2() {
    return InstaPlatform.instance.getPreview2();
  }

  Future<String?> getPreview3() {
    return InstaPlatform.instance.getPreview3();
  }

  Future<String?> getLive() {
    return InstaPlatform.instance.getLive();
  }

  Future<String?> getOsc() {
    return InstaPlatform.instance.getOsc();
  }

  Future<String?> getSetting() {
    return InstaPlatform.instance.getSetting();
  }
}
