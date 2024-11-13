import 'package:face_scanner/app/modules/controller/face_reading_ctl.dart';
import 'package:face_scanner/app/utills/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FaceReading extends GetView<FaceReadingCtl> {
  const FaceReading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.centerRight,
        child: FloatingActionButton(
          onPressed: () {
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
                                child:
                                    _buildImageOption(Icons.image, 'Gallery')),
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
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(SizeConfig.blockSizeHorizontal * 8)),
          backgroundColor: Colors.teal,
          child: Icon(
            Icons.add_photo_alternate_outlined,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Face Reading",
          style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 5,
              fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: Column(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.blockSizeVertical * 45,
            decoration: BoxDecoration(color: Colors.grey.shade200),
            child: Center(
              child: Text(
                "Add Image",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                    color: Colors.grey),
              ),
            ),
          ),
          verticalSpace(SizeConfig.blockSizeVertical * 2),
          Container(
            height: SizeConfig.blockSizeVertical * 40,
            width: SizeConfig.blockSizeHorizontal * 92,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(SizeConfig.blockSizeHorizontal * 4)),
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
              child: Text(
                "Definition. A paragraph is a group of related sentences that support one main idea. In general, paragraphs consist of three parts: the topic sentence, body sentences, and the concluding or the bridge sentence to the next paragraph or section of the paper.",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4,
                    color: Colors.black),
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
