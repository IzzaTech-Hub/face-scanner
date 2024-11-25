import 'package:face_scanner/app/modules/face_beauty_analysis/controller/face_beauty_analysis_ctl.dart';
import 'package:face_scanner/app/modules/home/views/helping_widgets/circular_graph.dart';
import 'package:face_scanner/app/utills/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
                      backgroundColor: Colors.teal,
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
              height: SizeConfig.blockSizeVertical * 50,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Graph(
                            size: SizeConfig.blockSizeVertical * 25,
                            color: Colors.amber,
                            progress: 0.5,
                          ),
                          Container(
                            height: SizeConfig.blockSizeVertical * 20,
                            width: SizeConfig.blockSizeHorizontal * 33,
                            decoration: BoxDecoration(
                                color: Colors.teal.shade100,
                                shape: BoxShape.circle),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Beauty Score",
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeHorizontal * 4),
                                ),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "6.76",
                                          style: TextStyle(
                                              fontSize: SizeConfig
                                                      .blockSizeHorizontal *
                                                  8,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                        text: " /10",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.blockSizeHorizontal *
                                                    4,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            simple_text("Gender"),
                            bold_text("${controller.gender.value}"),
                            simple_text("Age"),
                            bold_text("${controller.age.value}"),
                            simple_text("Glass"),
                            bold_text("${controller.glass.value}")
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          simple_text("Smile"),
                          bold_text("${controller.smile.value}%"),
                          simple_text("Ethnicity"),
                          bold_text("${controller.ethnicity.value}"),
                          simple_text("Face Quality"),
                          bold_text("${controller.face_quality.value}%")
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 3,
                        vertical: SizeConfig.blockSizeVertical * 3),
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 4),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
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
