import 'package:face_scanner/app/data/response_status.dart';
import 'package:face_scanner/app/modules/face_beauty_analysis/controller/face_beauty_analysis_ctl.dart';
import 'package:face_scanner/app/modules/home/views/helping_widgets/circular_graph.dart';
import 'package:face_scanner/app/modules/home/views/helping_widgets/gems_widget.dart';
import 'package:face_scanner/app/routes/app_pages.dart';
import 'package:face_scanner/app/utills/colors.dart';
import 'package:face_scanner/app/utills/gems_rate.dart';
import 'package:face_scanner/app/utills/helping_methods.dart';
import 'package:face_scanner/app/utills/images.dart';
import 'package:face_scanner/app/utills/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class FaceBeautyAnalysis extends GetView<FaceBeautyAnalysisCtl> {
  const FaceBeautyAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Face Beauty Analysis",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new_rounded)),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 2),
            child: gems_widget(),
          )

          // GestureDetector(
          //   onTap: () {
          //     Get.toNamed(Routes.GEMSVIEW);
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(
          //         horizontal: SizeConfig.blockSizeHorizontal * 2),
          //     child: Image.asset(
          //       AppImages.gems,
          //       height: SizeConfig.blockSizeVertical * 3,
          //     ),
          //   ),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => Stack(
                children: [
                  controller.selectedImage.value != null
                      ? Container(
                          width: double.infinity,
                          height: 300,
                          child: Image.file(
                            controller.selectedImage.value!,
                            fit: BoxFit.fill,
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          height: 300,
                          decoration:
                              BoxDecoration(color: Colors.grey.shade200),
                          child: Center(
                            child: Text(
                              "Add Image",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ),
                        ),
                  Positioned(
                    right: 16.0,
                    bottom: 16.0,
                    child: FloatingActionButton(
                      onPressed: () {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                            onTap: () async {
                                              await controller.pickImage(
                                                  ImageSource.camera);
                                              Get.back();
                                              // Get.to(() => scanner_method());
                                            },
                                            child: _buildImageOption(
                                                Icons.camera_alt, 'Camera')),
                                        GestureDetector(
                                            onTap: () async {
                                              await controller.pickImage(
                                                  ImageSource.gallery);
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(SizeConfig.blockSizeVertical * 1),
            Obx(() => controller.selectedImage.value != null &&
                    controller.responseStatus.value == ResponseStatus.idle
                ? GestureDetector(
                    onTap: () {
                      if (GEMS_RATE.remianingGems.value >=
                          GEMS_RATE.FaceBeautyGems) {
                        controller.sendImageToGoogleAI(
                            controller.selectedImage.value!);
                      } else {
                        // Show a toast message for insufficient gems
                        HelpingMethods.instance.ShowNoGemsToast();
                        Get.toNamed(Routes.GEMSVIEW);
                      }
                      // controller
                      //     .sendImageToGoogleAI(controller.selectedImage.value!);
                    },
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 6.5,
                      width: SizeConfig.blockSizeHorizontal * 70,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColorShade400,
                          borderRadius: BorderRadius.circular(
                              SizeConfig.blockSizeHorizontal * 4)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Analyze Beauty ",
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal * 5,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Row(
                              children: [
                                Text(
                                  "(${GEMS_RATE.FaceBeautyGems} x ",
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 5,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Image.asset(
                                  AppImages.gems,
                                  height: SizeConfig.blockSizeVertical * 2.5,
                                ),
                                Text(
                                  ")",
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 5,
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Container()),
            Obx(() {
              switch (controller.responseStatus.value) {
                case ResponseStatus.success:
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 3),
                      // height: SizeConfig.blockSizeVertical * 50,
                      width: SizeConfig.screenWidth,
                      color: Colors.white,
                      child: Column(
                        children: [
                          // Row with Graph and List
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Graph on the left
                              Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Graph(
                                      size: SizeConfig.blockSizeVertical * 25,
                                      color: AppColors.primaryColor,
                                      progress: controller
                                              .beauty_analysis.value!.score *
                                          0.1,
                                    ),
                                    Container(
                                      height: SizeConfig.blockSizeVertical * 20,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 33,
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryColorShade100,
                                          shape: BoxShape.circle),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Beauty Score",
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                    text:
                                                        "${controller.beauty_analysis.value!.score}",
                                                    style: TextStyle(
                                                        fontSize: SizeConfig
                                                                .blockSizeHorizontal *
                                                            8,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                  text: " /10",
                                                  style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeHorizontal *
                                                        4,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // List on the right
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  bold_text("Gender"),
                                  simple_text(
                                      "${controller.beauty_analysis.value!.gender}"),
                                  bold_text("Age"),
                                  simple_text(
                                      "${controller.beauty_analysis.value!.age}"),
                                  bold_text("Glasses"),
                                  simple_text(
                                      "${controller.beauty_analysis.value!.glass ? "Yes" : "No"}"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  bold_text("Smile"),
                                  simple_text(
                                      "${controller.beauty_analysis.value!.smile}%"),
                                  bold_text("Ethnicity"),
                                  simple_text(
                                      "${controller.beauty_analysis.value!.ethnicity}"),
                                  bold_text("Face Quality"),
                                  simple_text(
                                      "${controller.beauty_analysis.value!.faceQuality}%"),
                                ],
                              ),
                            ],
                          ),
                          // Dummy Text below
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.blockSizeHorizontal * 3,
                              vertical: SizeConfig.blockSizeVertical * 3,
                            ),
                            child: Text(
                              "${controller.beauty_analysis.value!.face_description}",
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeHorizontal * 4),
                              textAlign: TextAlign.left,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              if (GEMS_RATE.remianingGems.value >=
                                  GEMS_RATE.FaceBeautyGems) {
                                controller.sendImageToGoogleAI(
                                    controller.selectedImage.value!);
                              } else {
                                // Show a toast message for insufficient gems
                                HelpingMethods.instance.ShowNoGemsToast();
                                Get.toNamed(Routes.GEMSVIEW);
                              }
                              // controller.sendImageToGoogleAI(
                              //     controller.selectedImage.value!);
                            },
                            child: Container(
                              height: SizeConfig.blockSizeVertical * 6.5,
                              width: SizeConfig.blockSizeHorizontal * 70,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColorShade400,
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.blockSizeHorizontal * 4)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Try Again ",
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "(${GEMS_RATE.FaceBeautyGems} x ",
                                          style: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5,
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Image.asset(
                                          AppImages.gems,
                                          height: SizeConfig.blockSizeVertical *
                                              2.5,
                                        ),
                                        Text(
                                          ")",
                                          style: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5,
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );

                // Shimmer effect
                case ResponseStatus.progress:
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 3),
                      height: SizeConfig.blockSizeVertical * 50,
                      width: SizeConfig.screenWidth,
                      color: Colors.white,
                      child: Column(
                        children: [
                          // Row with Graph and List
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Graph on the left
                              Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      direction: ShimmerDirection.btt,
                                      child: Graph(
                                        size: SizeConfig.blockSizeVertical * 25,
                                        color: AppColors.primaryColor,
                                        progress: 0.5,
                                        // controller
                                        //         .beauty_analysis.value!.score *
                                        //     0.1,
                                      ),
                                    ),
                                    Container(
                                      height: SizeConfig.blockSizeVertical * 20,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 33,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Beauty Score",
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: "",
                                                    // "${controller.beauty_analysis.value!.score}",
                                                    style: TextStyle(
                                                        fontSize: SizeConfig
                                                                .blockSizeHorizontal *
                                                            8,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                  text: " /10",
                                                  style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .blockSizeHorizontal *
                                                          4,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // List on the right
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  bold_text("Gender"),
                                  shimmer_effect(
                                      SizeConfig.blockSizeHorizontal * 10),
                                  bold_text("Age"),
                                  shimmer_effect(
                                    SizeConfig.blockSizeHorizontal * 6,
                                  ),
                                  bold_text("Glasses"),
                                  shimmer_effect(
                                    SizeConfig.blockSizeHorizontal * 10,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  bold_text("Smile"),
                                  shimmer_effect(
                                    SizeConfig.blockSizeHorizontal * 9,
                                  ),
                                  bold_text("Ethnicity"),
                                  shimmer_effect(
                                    SizeConfig.blockSizeHorizontal * 13,
                                  ),
                                  bold_text("Face Quality"),
                                  shimmer_effect(
                                    SizeConfig.blockSizeHorizontal * 19,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Dummy Text below
                          Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockSizeHorizontal * 3,
                                vertical: SizeConfig.blockSizeVertical * 4.5,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  shimmer_effect(
                                      SizeConfig.blockSizeHorizontal * 90),
                                  verticalSpace(
                                      SizeConfig.blockSizeVertical * 1),
                                  shimmer_effect(
                                      SizeConfig.blockSizeHorizontal * 85),
                                  verticalSpace(
                                      SizeConfig.blockSizeVertical * 1),
                                  shimmer_effect(
                                      SizeConfig.blockSizeHorizontal *
                                          75), // Shorter line
                                  verticalSpace(
                                      SizeConfig.blockSizeVertical * 1),
                                  shimmer_effect(
                                      SizeConfig.blockSizeHorizontal * 88),
                                  verticalSpace(
                                      SizeConfig.blockSizeVertical * 1),
                                  shimmer_effect(
                                      SizeConfig.blockSizeHorizontal *
                                          78), // Shorter line
                                  verticalSpace(
                                      SizeConfig.blockSizeVertical * 1),
                                  shimmer_effect(
                                      SizeConfig.blockSizeHorizontal * 80),
                                  verticalSpace(
                                      SizeConfig.blockSizeVertical * 1),
                                  shimmer_effect(
                                      SizeConfig.blockSizeHorizontal *
                                          55), // Much shorter line
                                ],
                              )),
                        ],
                      ),
                    ),
                  );
                // Center(
                //   child: Shimmer.fromColors(
                //     baseColor: Colors.grey.shade300,
                //     highlightColor: Colors.grey.shade100,
                //     child: Container(
                //       height: SizeConfig.blockSizeVertical * 50,
                //       width: SizeConfig.screenWidth,
                //       decoration: BoxDecoration(color: Colors.white),
                //     ),
                //   ),
                // );
                case ResponseStatus.failed:
                  return Center(
                    child: Text(
                      "Failed to load data",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  );
                case ResponseStatus.idle:
                  return Container(); // Add idle state handling if needed
                default:
                  return Container();
              }
            }),
          ],
        ),
      ),
    );
  }

  Shimmer shimmer_effect(double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: SizeConfig.blockSizeVertical * 1,
        width: width,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4)),
      ),
    );
  }

  Text bold_text(String bold_text_1) {
    return Text(
      bold_text_1,
      style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 3.5,
          fontWeight: FontWeight.bold),
    );
  }

  Text simple_text(String simple_text_1) {
    return Text(
      simple_text_1,
      style: TextStyle(
          fontSize: SizeConfig.blockSizeHorizontal * 3.5,
          fontStyle: FontStyle.italic),
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

  // Widget scanner_method() {
  //   return GetX<FaceReadingCtl>(
  //     builder: (controller) {
  //       return Container(
  //         height: SizeConfig.screenHeight,
  //         width: SizeConfig.screenWidth,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             // Circular frame with the image inside
  //             Stack(
  //               alignment: Alignment.center,
  //               children: [
  //                 DottedBorder(
  //                   borderType: BorderType.Circle,
  //                   color: Colors.greenAccent,
  //                   strokeWidth: 2,
  //                   dashPattern: [6, 3],
  //                   child: Container(
  //                     width: 200,
  //                     height: 200,
  //                   ),
  //                 ),
  //                 CircleAvatar(
  //                   radius: 95,
  //                   backgroundColor: Colors.white,
  //                   backgroundImage: controller.selectedImage.value != null
  //                       ? FileImage(controller.selectedImage.value!)
  //                       : null,
  //                 ),
  //                 Positioned(
  //                   top: 0,
  //                   left: 0,
  //                   child: Container(
  //                     width: SizeConfig.blockSizeHorizontal * 10,
  //                     height: SizeConfig.blockSizeVertical * 5,
  //                     decoration: BoxDecoration(
  //                       border: Border(
  //                         top: BorderSide(color: Colors.greenAccent, width: 4),
  //                         left: BorderSide(color: Colors.greenAccent, width: 4),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Positioned(
  //                   top: 0,
  //                   right: 0,
  //                   child: Container(
  //                     width: SizeConfig.blockSizeHorizontal * 10,
  //                     height: SizeConfig.blockSizeVertical * 5,
  //                     decoration: BoxDecoration(
  //                       border: Border(
  //                         top: BorderSide(color: Colors.greenAccent, width: 4),
  //                         right:
  //                             BorderSide(color: Colors.greenAccent, width: 4),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Positioned(
  //                   bottom: 0,
  //                   left: 0,
  //                   child: Container(
  //                     width: SizeConfig.blockSizeHorizontal * 10,
  //                     height: SizeConfig.blockSizeVertical * 5,
  //                     decoration: BoxDecoration(
  //                       border: Border(
  //                         bottom:
  //                             BorderSide(color: Colors.greenAccent, width: 4),
  //                         left: BorderSide(color: Colors.greenAccent, width: 4),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Positioned(
  //                   bottom: 0,
  //                   right: 0,
  //                   child: Container(
  //                     width: SizeConfig.blockSizeHorizontal * 10,
  //                     height: SizeConfig.blockSizeVertical * 5,
  //                     decoration: BoxDecoration(
  //                       border: Border(
  //                         bottom:
  //                             BorderSide(color: Colors.greenAccent, width: 4),
  //                         right:
  //                             BorderSide(color: Colors.greenAccent, width: 4),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 // Scanning line with animation
  //                 Positioned(
  //                   top: controller.animationController.value * 180,
  //                   child: Container(
  //                     width: 180,
  //                     height: 2,
  //                     color: Colors.greenAccent,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 30),
  //             Text(
  //               'SCANNING...',
  //               style: TextStyle(
  //                 color: Colors.greenAccent,
  //                 fontSize: 24,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             // Progress bar with animation
  //             Container(
  //               width: 250,
  //               height: 20,
  //               decoration: BoxDecoration(
  //                 border: Border.all(color: Colors.greenAccent),
  //                 borderRadius: BorderRadius.circular(5),
  //               ),
  //               child: Row(
  //                 children: List.generate(20, (index) {
  //                   return Expanded(
  //                     child: Container(
  //                       margin: EdgeInsets.symmetric(horizontal: 1),
  //                       color: index < (controller.scanningProgress.value ~/ 5)
  //                           ? Colors.greenAccent
  //                           : Colors.black,
  //                     ),
  //                   );
  //                 }),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
