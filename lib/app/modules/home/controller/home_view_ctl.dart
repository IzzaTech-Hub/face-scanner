import 'package:face_scanner/app/utills/gems_rate.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewCtl extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  increaseGEMS(int increase) async {
    print("value: $increase");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    GEMS_RATE.remianingGems.value = GEMS_RATE.remianingGems.value + increase;
    await prefs.setInt('gems', GEMS_RATE.remianingGems.value);
    print("inters");
    getGems();
  }

  decreaseGEMS(int decrease) async {
    print("value: $decrease");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    GEMS_RATE.remianingGems.value = GEMS_RATE.remianingGems.value - decrease;
    if (GEMS_RATE.remianingGems.value < 0) {
      GEMS_RATE.remianingGems.value = 0;
      await prefs.setInt('gems', GEMS_RATE.remianingGems.value);
    } else {
      await prefs.setInt('gems', GEMS_RATE.remianingGems.value);
    }
  }

  Future<int> getGems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (kDebugMode) {
      GEMS_RATE.remianingGems.value = prefs.getInt('gems') ?? 100;
    } else {
      GEMS_RATE.remianingGems.value =
          prefs.getInt('gems') ?? GEMS_RATE.FREE_GEMS;
    }
    print("GEMS value: ${GEMS_RATE.remianingGems.value}");
    return GEMS_RATE.remianingGems.value;
  }
}
