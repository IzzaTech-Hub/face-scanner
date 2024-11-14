import 'package:face_scanner/app/modules/home/controller/celebrity_look_ctl.dart';
import 'package:get/get.dart';

class CelebrityLookBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CelebrityLookCtl());
  }
}
