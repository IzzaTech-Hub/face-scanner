import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:face_scanner/app/data/response_status.dart';
import 'package:face_scanner/app/utills/rc_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class FaceReadingCtl extends GetxController
    with GetSingleTickerProviderStateMixin {
  var selectedImage = Rx<File?>(null);
  RxInt selectedIndex = 0.obs;
  Rx<bool> isScanning = false.obs;
  Rx<ResponseStatus> responseStatus = ResponseStatus.idle.obs;

  late AnimationController animationController;

  Map<String, dynamic>? featureMap;
  RxString selectedFeature = "".obs;
  RxString eyebrows = "".obs;
  RxString face = "".obs;
  RxString lips = "".obs;
  RxString eyes = "".obs;
  RxString nose = "".obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Repeat the scanning line animation
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      log("Picked Image");
      startScanningImage(selectedImage.value!);
    }
  }

  Future<void> startScanningImage(File imgFile) async {
    log("Started Scanning the image..");
    responseStatus.value = ResponseStatus.progress;

    final SystemInstruction =
        ''' You are an advance level facial analysis expert. You will be given an image of a person.
    Your task is to give features details of facial parts of the person face.
    For Example for lips your response will look like this:
    Example: This Lips, often associated with being reserved and quit. People with this trait are often reserved and thoughtful.
    they often choose each word they say and only speak when necessary. Howeer, when they speak, their words often bring great value and influence.
   
''';
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      // model: 'gemini-1.5-flash',
      apiKey: RCVariables.GeminiAPIKey,
      generationConfig: GenerationConfig(
        temperature: 0.5,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 500,
        responseMimeType: 'application/json',
        responseSchema: Schema(
          SchemaType.object,
          enumValues: [],
          requiredProperties: ["face", "lips", "nose", "eyes", "eyebrows"],
          properties: {
            "face": Schema(
              SchemaType.string,
            ),
            "lips": Schema(
              SchemaType.string,
            ),
            "nose": Schema(
              SchemaType.string,
            ),
            "eyes": Schema(
              SchemaType.string,
            ),
            "eyebrows": Schema(
              SchemaType.string,
            ),
          },
        ),
      ),
      systemInstruction: Content.system(SystemInstruction),
    );

//     final prompt =
//         ''' You are an advance level facial analysis expert. You will be given an image of a person.
//     Your task is to give features details of facial parts of the person face.
//     For Example for lips your response will look like this:
//     Example: This Lips, often associated with being reserved and quit. People with this trait are often reserved and thoughtful.
//     they often choose each word they say and only speak when necessary. Howeer, when they speak, their words often bring great value and influence.

// ''';

    Uint8List imageBytes = await imgFile.readAsBytes();
    final content = [
      Content.multi(
          [TextPart("Get Features"), DataPart('image/jpeg', imageBytes)]),
    ];

    try {
      final response = await model.generateContent(content);
      log("Response ${response.text}");
      Map<String, dynamic> jsonMap = jsonDecode(response.text ?? '');
      featureMap = jsonMap;
      eyebrows.value = featureMap!['eyebrows'];
      face.value = featureMap!['face'];
      lips.value = featureMap!['lips'];
      nose.value = featureMap!['nose'];
      eyes.value = featureMap!['eyes'];
      selectedFeature.value = face.value;
      Get.back();
      responseStatus.value = ResponseStatus.success;

      log("jsonMap ${jsonMap}");
    } on Exception catch (e) {
      Get.back();
      // showErrorDialog(
      //     Get.context!, "Something went wrong. Please try again later");
      responseStatus.value = ResponseStatus.failed;

      log("Error ${e.toString()}");

      // TODO
    }
  }

  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // void startScanning() {
  //   isScanning.value = true;
  //   scanningProgress.value = 0;
  //   Timer.periodic(Duration(seconds: 1), (timer) {
  //     if (scanningProgress.value < 100) {
  //       scanningProgress.value += 10;
  //     } else {
  //       timer.cancel();
  //       isScanning.value = false;
  //     }
  //   });
  // }

  void changeTabIndex(int index) {
    selectedIndex.value = index;

    if (index == 0) {
      selectedFeature.value = face.value;
    } else if (index == 1) {
      selectedFeature.value = lips.value;
    } else if (index == 2) {
      selectedFeature.value = eyes.value;
    } else if (index == 3) {
      selectedFeature.value = nose.value;
    } else if (index == 4) {
      selectedFeature.value = eyebrows.value;
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
