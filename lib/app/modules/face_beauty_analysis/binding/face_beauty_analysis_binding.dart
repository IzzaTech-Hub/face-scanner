import 'package:face_scanner/app/modules/face_beauty_analysis/controller/face_beauty_analysis_ctl.dart';
import 'package:get/get.dart';

class FaceBeautyAnalysisBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FaceBeautyAnalysisCtl());
  }
}
