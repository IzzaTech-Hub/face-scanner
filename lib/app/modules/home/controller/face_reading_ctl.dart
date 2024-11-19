import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FaceReadingCtl extends GetxController
    with GetSingleTickerProviderStateMixin {
  var selectedImage = Rx<File?>(null);
  RxInt selectedIndex = 0.obs;
  Rx<bool> isScanning = false.obs;

  late AnimationController animationController;
  var scanningProgress = 0.obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Repeat the scanning line animation
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  void startScanning() {
    isScanning.value = true;
    scanningProgress.value = 0;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (scanningProgress.value < 100) {
        scanningProgress.value += 10;
      } else {
        timer.cancel();
        isScanning.value = false;
      }
    });
  }

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
