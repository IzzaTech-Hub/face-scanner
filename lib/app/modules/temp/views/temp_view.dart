import 'package:face_scanner/app/utills/images.dart';
import 'package:face_scanner/app/utills/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/temp_controller.dart';

class TempView extends GetView<TempController> {
  const TempView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beauty Score'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          verticalSpace(SizeConfig.blockSizeVertical * 2),
          Stack(
            children: [_leftImage(), _rightImage()],
          )
        ],
      ),
    );
  }

  Center _leftImage() {
    return Center(
      child: Transform.translate(
        offset: Offset(-60, 0), // Adjust the position (left by 20 pixels)
        child: Transform.rotate(
          angle: -0.2, // Rotate slightly to the left (in radians)
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 50,
            height: SizeConfig.blockSizeHorizontal * 50,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: Get.context!,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Choose Image',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                        onTap: () async {
                                          await controller
                                              .pickImage1(ImageSource.camera);
                                          Get.back();

                                          // Get.to(() => ScannerWidget());
                                        },
                                        child: _buildImageOption(
                                            Icons.camera_alt, 'Camera')),
                                    GestureDetector(
                                        onTap: () async {
                                          await controller
                                              .pickImage1(ImageSource.gallery);
                                          Get.back();

                                          // Get.to(() => ScannerWidget());
                                        },
                                        child: _buildImageOption(
                                            Icons.image, 'Gallery')),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 55,
                    height: SizeConfig.blockSizeHorizontal * 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(70),
                    ),
                    child: Obx(() => controller.selectedImage1.value != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(
                                70), // Match container's borderRadius
                            child: Image.file(
                              controller.selectedImage1.value!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          )
                        : _noImageMethod()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _rightImage() {
    return Center(
      child: Transform.translate(
        offset: Offset(60, 0), // Adjust the position (left by 20 pixels)
        child: Transform.rotate(
          angle: 0.2, // Rotate slightly to the left (in radians)
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 50,
            height: SizeConfig.blockSizeHorizontal * 50,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: Get.context!,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Choose Image',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                        onTap: () async {
                                          await controller
                                              .pickImage2(ImageSource.camera);
                                          Get.back();

                                          // Get.to(() => ScannerWidget());
                                        },
                                        child: _buildImageOption(
                                            Icons.camera_alt, 'Camera')),
                                    GestureDetector(
                                        onTap: () async {
                                          await controller
                                              .pickImage2(ImageSource.gallery);
                                          Get.back();

                                          // Get.to(() => ScannerWidget());
                                        },
                                        child: _buildImageOption(
                                            Icons.image, 'Gallery')),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 55,
                    height: SizeConfig.blockSizeHorizontal * 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(70),
                    ),
                    child: Obx(() => controller.selectedImage2.value != null
                        ? Container(
                            margin: EdgeInsets.all(5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  70), // Match container's borderRadius
                              child: Image.file(
                                controller.selectedImage2.value!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        : _noImageMethod()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack _noImageMethod() {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 5,
              vertical: SizeConfig.blockSizeHorizontal * 10),
          child: Align(
              alignment: Alignment.topRight,
              child: Icon(
                CupertinoIcons.add_circled_solid,
                color: Colors.grey,
              )),
        ),
        Container(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 3,
                vertical: SizeConfig.blockSizeVertical * 2),
            child: Image.asset(AppImages.user))
      ],
    );
  }

  Widget _buildImageOption(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon,
            color: Colors.green, size: SizeConfig.blockSizeHorizontal * 10),
        verticalSpace(SizeConfig.blockSizeVertical * 1),
        Text(label,
            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 3.5)),
      ],
    );
  }
}
