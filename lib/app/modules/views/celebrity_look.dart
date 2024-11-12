import 'package:dotted_border/dotted_border.dart';
import 'package:face_scanner/app/modules/controller/celebrity_look_ctl.dart';
import 'package:face_scanner/app/utills/images.dart';
import 'package:face_scanner/app/utills/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CelebrityLook extends GetView<CelebrityLookCtl> {
  const CelebrityLook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Look like a Celebrity",
          style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 5,
              fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new_rounded)),
        actions: [Icon(Icons.question_mark_rounded)],
      ),
      body: Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.blockSizeHorizontal * 3)),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Choose Image',
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            verticalSpace(SizeConfig.blockSizeVertical * 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      controller.pickImage(ImageSource.camera);
                                    },
                                    child: _buildImageOption(
                                        Icons.camera_alt, 'Camera')),
                                GestureDetector(
                                    onTap: () {
                                      controller.pickImage(ImageSource.gallery);
                                    },
                                    child: _buildImageOption(
                                        Icons.image, 'Gallery')),
                                // GestureDetector(
                                //     onTap: () {},
                                //     child: _buildImageOption(
                                //         Icons.face, 'Models')),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                height: SizeConfig.blockSizeVertical * 42,
                width: SizeConfig.blockSizeHorizontal * 70,
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
                        SizeConfig.blockSizeHorizontal * 6)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DottedBorder(
                      strokeWidth: 1,
                      borderType: BorderType.RRect,
                      strokeCap: StrokeCap.round,
                      dashPattern: [6, 1, 8, 11],
                      color: Colors.grey,
                      child: Container(
                        height: SizeConfig.blockSizeVertical * 25,
                        width: SizeConfig.blockSizeHorizontal * 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.blockSizeHorizontal * 2)),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 1,
                                  right: SizeConfig.blockSizeHorizontal * 2),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.add_circle,
                                    color: Colors.grey,
                                  )),
                            ),
                            Image.asset(
                              AppImages.user,
                              scale: 3.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "with",
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 4,
                          color: Colors.grey),
                    ),
                    Container(
                      height: SizeConfig.blockSizeVertical * 5,
                      width: SizeConfig.blockSizeHorizontal * 60,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(
                              SizeConfig.blockSizeHorizontal * 4)),
                      child: Center(
                        child: Text(
                          "Top 100 social media influencers",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 3.3,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          verticalSpace(SizeConfig.blockSizeVertical * 5),
          Container(
            height: SizeConfig.blockSizeVertical * 6.5,
            width: SizeConfig.blockSizeHorizontal * 70,
            decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius:
                    BorderRadius.circular(SizeConfig.blockSizeHorizontal * 4)),
            child: Center(
              child: Text(
                "SEARCH",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 5,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          )
        ],
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
