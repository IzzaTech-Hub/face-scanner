import 'package:face_scanner/app/modules/splash_screen/controller/splash_screen_ctl.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
