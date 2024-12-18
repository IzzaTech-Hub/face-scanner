import 'package:face_scanner/app/modules/setting/controller/settings_view_ctl.dart';
import 'package:get/get.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingsCTL());
  }
}
