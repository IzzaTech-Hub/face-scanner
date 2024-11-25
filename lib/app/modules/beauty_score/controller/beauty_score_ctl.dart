import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:face_scanner/app/data/response_status.dart';
import 'package:face_scanner/app/modules/home/views/helping_widgets/dualscanning_widget.dart';
import 'package:face_scanner/app/utills/rc_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class BeautyScoreCtl extends GetxController {
  var selectedImage1 = Rx<File?>(null);
  var selectedImage2 = Rx<File?>(null);
  Rx<bool> isScanning = false.obs;

  RxInt winner = 1.obs;
  // RxInt percentage1 = 0.obs;
  // RxInt percentage2 = 0.obs;
  RxDouble score1 = 0.0.obs;
  RxDouble score2 = 0.0.obs;

  Rx<ResponseStatus> responseStatus = ResponseStatus.idle.obs;

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

  Future<void> pickImage1(ImageSource source) async {
    final ImagePicker picker1 = ImagePicker();
    final pickedFile = await picker1.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage1.value = File(pickedFile.path);
    }
  }

  Future<void> pickImage2(ImageSource source) async {
    final ImagePicker picker2 = ImagePicker();
    final pickedFile = await picker2.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage2.value = File(pickedFile.path);
    }
  }

  Future<void> compareImages() async {
    Get.to(() => DualScannerWidget(
        image1: selectedImage1.value!, image2: selectedImage2.value!));
    log("Compare Started...");
    log("Comparing image1...");
    score1.value = await scanImage(selectedImage1.value!);
    await Future.delayed(Duration(seconds: 2));
    log("Comparing image2...");

    score2.value = await scanImage(selectedImage2.value!);
    if (score1.value > score2.value) {
      winner.value = 1;
    } else {
      winner.value = 2;
    }
    Get.back();

    log("Score1: $score1   Score2: $score2");
  }

  Future<double> scanImage(File imgFile) async {
    responseStatus.value = ResponseStatus.progress;

    double result = 0.0;

    final SystemInstruction =
        ''' You are a highly skilled face analysis expert specializing in evaluating facial aesthetics and beauty. Your role is to analyze faces based on specific features, including eyes, lips, hair, overall style, nose, eyebrows, eyelashes, cheeks, chin, and other prominent attributes. Using this analysis, provide a beauty score on a scale of 1 to 10, with 10 being exceptionally beautiful.

              Guidelines:
          Evaluate each facial feature individually and give total average scale for beauty.

          Eyes: Shape, symmetry, and overall expressiveness.
          Lips: Fullness, shape, and balance with the rest of the face.
          Hair: Texture, style, and how it complements the facial structure.
          Style: Grooming and the overall impression created by the person’s look.
          Nose: Proportion, alignment, and symmetry.
          Eyebrows: Shape, density, and their contribution to facial expression.
          Eyelashes: Length, fullness, and their impact on eye appeal.
          Cheeks: Bone structure, prominence, and softness.
          Chin: Shape, symmetry, and how well it balances the face.
          Combine the feature scores to calculate an overall beauty score.
''';

    final model = GenerativeModel(
      model: 'gemini-1.5-pro',
      // model: 'gemini-1.5-flash',
      apiKey: RCVariables.GeminiAPIKey,
      generationConfig: GenerationConfig(
        temperature: 0.5,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 10,
        responseMimeType: 'application/json',
        responseSchema: Schema(
          SchemaType.object,
          enumValues: [],
          requiredProperties: ["score"],
          properties: {
            "score": Schema(
              SchemaType.number,
            ),
          },
        ),
      ),

      systemInstruction: Content.system(SystemInstruction),
    );

    Uint8List imageBytes = await imgFile.readAsBytes();
    final content = [
      Content.multi([
        TextPart("Get Score in Scale 1-10 like 7.8"),
        DataPart('image/jpeg', imageBytes)
      ]),
    ];

    try {
      final response = await model.generateContent(content);
      log("Response ${response.text}");
      Map<String, dynamic> jsonMap = jsonDecode(response.text ?? '');
      // final tokens = await model.countTokens(content);
      // log("Total Tokens: ${tokens.totalTokens}");
      return jsonMap["score"];
    } on Exception catch (e) {
      showErrorDialog(
          Get.context!, "Something went wrong. Please try again later");

      log("Error ${e.toString()}");
    }

    return result;
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
}
