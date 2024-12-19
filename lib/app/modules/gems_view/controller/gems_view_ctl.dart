import 'package:face_scanner/app/utills/gems_rate.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GemsViewController extends GetxController {
  final count = 0.obs;
  int initialGems = 20;
  RxInt gems = 0.obs;
  bool? firstTime = false;
  @override
  void onInit() {
    super.onInit();
  }

  increase_inter_gems() {
    increaseGEMS(GEMS_RATE.INTER_INCREAES_GEMS_RATE);
  }

  increase_reward_gems() {
    increaseGEMS(GEMS_RATE.REWARD_INCREAES_GEMS_RATE);
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

  increaseGEMS(int increase) async {
    print("value: $increase");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    gems.value = gems.value + increase;
    await prefs.setInt('gems', gems.value);
    print("inters");
    getGems();
  }

  decreaseGEMS(int decrease) async {
    print("value: $decrease");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    gems.value = gems.value - decrease;
    if (gems.value < 0) {
      gems.value = 0;
      await prefs.setInt('gems', gems.value);
    } else {
      await prefs.setInt('gems', gems.value);
    }
  }

   Future<int> getGems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (kDebugMode) {
      gems.value = prefs.getInt('gems') ?? 100;
    } else {
      gems.value = prefs.getInt('gems') ?? GEMS_RATE.FREE_GEMS;
    }
    print("GEMS value: ${gems.value}");
    return gems.value;
  }

}
