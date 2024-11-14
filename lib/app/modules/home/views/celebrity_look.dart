import 'package:cached_network_image/cached_network_image.dart';
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
                                    onTap: () async {
                                      await controller
                                          .pickImage(ImageSource.camera);
                                      Get.back();
                                    },
                                    child: _buildImageOption(
                                        Icons.camera_alt, 'Camera')),
                                GestureDetector(
                                    onTap: () async {
                                      await controller
                                          .pickImage(ImageSource.gallery);
                                      Get.back();
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
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //       top: SizeConfig.blockSizeVertical * 1,
                            //       right: SizeConfig.blockSizeHorizontal * 2),
                            //   child: Align(
                            //       alignment: Alignment.topRight,
                            //       child: Icon(
                            //         Icons.add_circle,
                            //         color: Colors.grey,
                            //       )),
                            // ),
                            Container(
                              height: SizeConfig.blockSizeVertical * 25,
                              width: SizeConfig.blockSizeHorizontal * 55,
                              child: Obx(
                                  () => controller.selectedImage.value != null
                                      ? Image.file(
                                          controller.selectedImage.value!,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.asset(
                                          AppImages.user,
                                          // scale: 3.5,
                                        )),
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
          controller.isTrue.value
              ? Container(
                  height: SizeConfig.blockSizeVertical * 6.5,
                  width: SizeConfig.blockSizeHorizontal * 70,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(
                          SizeConfig.blockSizeHorizontal * 4)),
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
              : Container(),
          verticalSpace(SizeConfig.blockSizeVertical * 2),
          Obx(() => controller.responseStatus.value == ResponseStatus.success
              ? Container(
                  height: SizeConfig.blockSizeVertical * 35,
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
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 1),
                        height: SizeConfig.blockSizeVertical * 18,
                        width: SizeConfig.blockSizeHorizontal * 40,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(
                                SizeConfig.blockSizeHorizontal * 4)),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: "${controller.imageUrl.value}",
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockSizeHorizontal * 6,
                                vertical: SizeConfig.blockSizeVertical * 6),
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      verticalSpace(SizeConfig.blockSizeVertical * 2),
                      Obx(() => controller.celebrity_match.value != null
                          ? Column(
                              children: [
                                bio_data("Name",
                                    "${controller.celebrity_match.value!.name}"),
                                bio_data("Match Rate",
                                    "${controller.celebrity_match.value!.matchPercentage}%"),
                                // bio_data("Date of birth", "${controller.celebrity_match.value!.name}"),
                                bio_data("Country",
                                    "${controller.celebrity_match.value!.country}"),
                                bio_data("Career",
                                    "${controller.celebrity_match.value!.profession}"),
                              ],
                            )
                          : Container()),
                    ],
                  ),
                )
              : Container())
        ],
      ),
    );
  }

  Widget bio_data(String text1, String text2) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockSizeHorizontal * 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 4,
                color: Colors.grey.shade600),
          ),
          Text(
            text2,
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 4,
                fontWeight: FontWeight.bold),
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
