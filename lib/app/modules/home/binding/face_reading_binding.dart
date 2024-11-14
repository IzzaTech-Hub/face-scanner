import 'package:face_scanner/app/modules/home/controller/face_reading_ctl.dart';
import 'package:get/get.dart';

class FaceReadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FaceReadingCtl());
  }
}
