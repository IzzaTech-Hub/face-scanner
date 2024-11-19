import 'package:face_scanner/app/modules/home/controller/beauty_score_ctl.dart';
import 'package:get/get.dart';

class BeautyScoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BeautyScoreCtl());
  }
}
