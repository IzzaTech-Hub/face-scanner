import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BeautyScoreCtl extends GetxController {
  var selectedImage1 = Rx<File?>(null);
  var selectedImage2 = Rx<File?>(null);
  Rx<bool> isScanning = false.obs;

  RxInt winner = 1.obs;
  RxInt percentage1 = 70.obs;
  RxInt percentage2 = 30.obs;

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

  Future<void> pickImage1(ImageSource source) async {
    final ImagePicker picker1 = ImagePicker();
    final pickedFile = await picker1.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage1.value = File(pickedFile.path);
    }
  }

  Future<void> pickImage2(ImageSource source) async {
    final ImagePicker picker2 = ImagePicker();
    final pickedFile = await picker2.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage2.value = File(pickedFile.path);
    }
  }
}
