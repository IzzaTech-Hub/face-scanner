import 'package:face_scanner/app/modules/beauty_score/controller/beauty_score_ctl.dart';
import 'package:face_scanner/app/routes/app_pages.dart';
import 'package:face_scanner/app/utills/colors.dart';
import 'package:face_scanner/app/utills/images.dart';
import 'package:face_scanner/app/utills/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BeautyScore extends GetView<BeautyScoreCtl> {
  const BeautyScore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Beauty Score",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: Row(
        children: [
          Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      left_beauty(context),
                      right_beauty(context),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    // Check if images are picked before navigating
                    if (controller.selectedImage1.value != null &&
                        controller.selectedImage2.value != null) {
                      await controller.compareImages();

                      Get.toNamed(
                        Routes.BEAUTYSCORERESULT,
                        // arguments can be passed here if needed
                      );
                    } else {
                      // Show an error message
                      Get.snackbar(
                        "Error",
                        "Please select both images before comparing.",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: SizeConfig.blockSizeVertical * 45,
                    ),
                    height: SizeConfig.blockSizeVertical * 7.5,
                    width: SizeConfig.blockSizeHorizontal * 80,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(
                        SizeConfig.blockSizeHorizontal * 4,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Compare",
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget left_beauty(BuildContext context) {
    return Obx(
      () => Positioned(
        left: SizeConfig.blockSizeHorizontal * 5,
        top: SizeConfig.blockSizeVertical * 10,
        child: Transform.rotate(
          angle: -0.3,
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    await controller
                                        .pickImage1(ImageSource.camera);

                                    Get.back();
                                    // Get.to(() => scanner_method());
                                  },
                                  child: _buildImageOption(
                                      Icons.camera_alt, 'Camera')),
                              GestureDetector(
                                  onTap: () async {
                                    await controller
                                        .pickImage1(ImageSource.gallery);
                                    Get.back();
                                    // Get.to(() => scanner_method());
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
              height: SizeConfig.blockSizeVertical * 23,
              width: SizeConfig.blockSizeHorizontal * 45,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400, // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 10, // Blur radius
                      offset: Offset(0, 5), // Offset in x and y direction
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      SizeConfig.blockSizeHorizontal * 13)),
              child: Stack(
                children: [
                  controller.selectedImage1.value != null
                      ? Container()
                      : Positioned(
                          left: SizeConfig.blockSizeHorizontal * 35,
                          top: SizeConfig.blockSizeVertical * 3,
                          child: Icon(
                            Icons.add_circle,
                            color: Colors.grey,
                          )),
                  controller.selectedImage1.value != null
                      ? Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.blockSizeHorizontal * 13),
                              border:
                                  Border.all(color: Colors.white, width: 3)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.blockSizeHorizontal * 13),
                            child: Image.file(
                              controller.selectedImage1.value!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : Positioned(
                          top: SizeConfig.blockSizeVertical * 3.5,
                          left: SizeConfig.blockSizeHorizontal * 6,
                          child: Image.asset(
                            AppImages.user,
                            height: SizeConfig.blockSizeVertical * 15,
                            width: SizeConfig.blockSizeHorizontal * 32,
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget right_beauty(BuildContext context) {
    return Obx(
      () => Positioned(
        left: SizeConfig.blockSizeHorizontal * 54,
        top: SizeConfig.blockSizeVertical * 3.5,
        child: Transform.rotate(
          angle: 0.3,
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    await controller
                                        .pickImage2(ImageSource.camera);
                                    Get.back();
                                    // Get.to(() => scanner_method());
                                  },
                                  child: _buildImageOption(
                                      Icons.camera_alt, 'Camera')),
                              GestureDetector(
                                  onTap: () async {
                                    await controller
                                        .pickImage2(ImageSource.gallery);
                                    Get.back();
                                    // Get.to(() => scanner_method());
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
              height: SizeConfig.blockSizeVertical * 23,
              width: SizeConfig.blockSizeHorizontal * 45,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400, // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 10, // Blur radius
                      offset: Offset(0, 5), // Offset in x and y direction
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      SizeConfig.blockSizeHorizontal * 13)),
              child: Stack(
                children: [
                  controller.selectedImage2.value != null
                      ? Container()
                      : Positioned(
                          left: SizeConfig.blockSizeHorizontal * 35,
                          top: SizeConfig.blockSizeVertical * 3,
                          child: Icon(
                            Icons.add_circle,
                            color: Colors.grey,
                          )),
                  controller.selectedImage2.value != null
                      ? Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.blockSizeHorizontal * 13),
                              border:
                                  Border.all(color: Colors.white, width: 3)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.blockSizeHorizontal * 13),
                            child: Image.file(
                              controller.selectedImage2.value!,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : Positioned(
                          top: SizeConfig.blockSizeVertical * 3.5,
                          left: SizeConfig.blockSizeHorizontal * 6,
                          child: Image.asset(
                            AppImages.user,
                            height: SizeConfig.blockSizeVertical * 15,
                            width: SizeConfig.blockSizeHorizontal * 32,
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
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
