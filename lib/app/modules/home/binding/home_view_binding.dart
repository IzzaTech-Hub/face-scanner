import 'package:face_scanner/app/modules/home/controller/home_view_ctl.dart';
import 'package:get/get.dart';

class HomeViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeViewCtl());
  }
}
