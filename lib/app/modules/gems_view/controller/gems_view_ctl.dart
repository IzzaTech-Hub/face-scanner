import 'package:face_scanner/app/modules/home/controller/home_view_ctl.dart';
import 'package:face_scanner/app/utills/gems_rate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GemsViewController extends GetxController {
  final count = 0.obs;
  int initialGems = 20;
  int hackCount = 0;
  // RxInt gems = 0.obs;
  bool? firstTime = false;
  HomeViewCtl homeViewCtl = Get.find();
  @override
  void onInit() {
    super.onInit();
  }

  increase_inter_gems() {
    HomeViewCtl homeViewCtl = Get.find();
    homeViewCtl.increaseGEMS(GEMS_RATE.INTER_INCREAES_GEMS_RATE);
  }

  increase_reward_gems() {
    HomeViewCtl homeViewCtl = Get.find();
    homeViewCtl.increaseGEMS(GEMS_RATE.REWARD_INCREAES_GEMS_RATE);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void hackMethod() {
    hackCount++;
    if (hackCount == 20) {
      homeViewCtl.increaseGEMS(100);
      EasyLoading.showSuccess("Activated");
      hackCount = 0;
    }
  }
}
