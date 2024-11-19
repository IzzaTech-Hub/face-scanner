import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TempController extends GetxController {
  //TODO: Implement TempController

  var selectedImage1 = Rx<File?>(null);
  var selectedImage2 = Rx<File?>(null);
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> pickImage1(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage1.value = File(pickedFile.path);
    }
  }

  Future<void> pickImage2(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage2.value = File(pickedFile.path);
    }
  }
}
