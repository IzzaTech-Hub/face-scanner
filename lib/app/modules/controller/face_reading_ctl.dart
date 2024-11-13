import 'dart:io';

import 'package:face_scanner/app/utills/images.dart';
import 'package:face_scanner/app/utills/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FaceReadingCtl extends GetxController {
  var selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

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
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      Get.dialog(
        Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(color: Colors.white),
          child: AlertDialog(
            title: Text(''),
            backgroundColor: Colors.white,
            content: Stack(
              children: [
                Container(
                  height: SizeConfig.blockSizeVertical * 35,
                  width: SizeConfig.blockSizeHorizontal * 70,
                  decoration: BoxDecoration(),
                  child: Image.asset(
                    AppImages.scanner,
                    color: Colors.teal,
                  ),
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          ),
        ),
      );
    }
  }
}
