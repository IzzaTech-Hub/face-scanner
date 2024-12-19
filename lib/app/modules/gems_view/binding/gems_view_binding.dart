import 'package:face_scanner/app/modules/gems_view/controller/gems_view_ctl.dart';
import 'package:get/get.dart';

class GemsViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GemsViewController());
  }
}
