import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FaceBeautyAnalysisCtl extends GetxController {
  var selectedImage = Rx<File?>(null);
  RxInt selectedIndex = 0.obs;
  Rx<bool> isScanning = false.obs;
  RxString score = "6.76".obs;
  RxString gender = "Male".obs;
  RxString smile = "6".obs;
  RxString age = "26".obs;
  RxString ethnicity = "-".obs;
  RxString glass = "None".obs;
  RxString face_quality = "64".obs;
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

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      log("Picked Image");
      // startScanningImage(selectedImage.value!);
    }
  }
}
