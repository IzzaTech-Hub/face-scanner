import 'package:face_scanner/app/modules/celebrity_look/controller/celebrity_look_ctl.dart';
import 'package:get/get.dart';

class CelebrityLookBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CelebrityLookCtl());
  }
}
