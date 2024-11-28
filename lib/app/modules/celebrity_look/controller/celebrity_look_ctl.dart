import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:face_scanner/app/data/celebrity_match.dart';
import 'package:face_scanner/app/data/response_status.dart';
import 'package:face_scanner/app/services/api_service.dart';
import 'package:face_scanner/app/utills/rc_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class CelebrityLookCtl extends GetxController {
  var selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Rx<CelebrityMatch?> celebrity_match = Rx<CelebrityMatch?>(null);
  RxString imageUrl = "".obs;
  Rx<ResponseStatus> responseStatus = ResponseStatus.idle.obs;
  // Rx<ResponseStatus> responseStatus = ResponseStatus.progress.obs;

  RxBool isTrue = false.obs;

  RxString selectedOption = "Top 100 social media influencers".obs;

  RxList<String> options = [
    "Top 100 social media influencers",
    "Top 100 best football players",
    "Richest people in the World",
    "Top 100 Beauty Women",
    "Top 100 Handsome Men",
    "Bodybuilder in the World",
    "Supermodels in the World",
    "Contemporary basketballer",
    "Top Asian influencers",
  ].obs;

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

      sendImageToGoogleAI(selectedImage.value!);
    }
  }

  Future<void> sendImageToGoogleAI(File imgFile) async {
    responseStatus.value = ResponseStatus.progress;

    String celebrityType = selectedOption.value;

    final SystemInstruction =
        '''You are an advanced-level facial analysis expert. You will be given an image of a person. Based on the facial features of the person in the image, analyze and find a celebrity from the category "$celebrityType" with the closest resemblance to these facial features. 
Consider the following when making a match:
1. Regional diversity: Ensure the match aligns with the region or cultural group.
2. Profession alignment: Focus on the specific category of celebrities mentioned.

Respond only in JSON format, following the structure below:
{
    "name": "<string>",                   // Celebrity's full name
    "country": "<string>",                // Celebrity's country of origin
    "profession": "<string>",             // Celebrity's primary profession
    "match_percentage": "<float>",        // Similarity score between 1 and 100
    "description": "<string>"             // Specific features that align with the celebrity, like face shape, eyes, jawline, eyebrows, etc.
}
''';

    final model = GenerativeModel(
      // model: 'gemini-1.5-pro',
      model: 'gemini-1.5-flash',
      apiKey: RCVariables.GeminiAPIKey,
      generationConfig: GenerationConfig(
        temperature: 0.8,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 500,
        responseMimeType: 'application/json',
        responseSchema: Schema(
          SchemaType.object,
          enumValues: [],
          requiredProperties: [
            "celebrityName",
            "country",
            "profession",
            "match_percentage",
            "description"
          ],
          properties: {
            "celebrityName": Schema(
              SchemaType.string,
            ),
            "country": Schema(
              SchemaType.string,
            ),
            "profession": Schema(
              SchemaType.string,
            ),
            "match_percentage": Schema(
              SchemaType.integer,
            ),
            "description": Schema(
              SchemaType.string,
            ),
          },
        ),
      ),
      systemInstruction: Content.system(SystemInstruction),
    );

    // log("Prompt: $prompt");
    Uint8List imageBytes = await imgFile.readAsBytes();
    final content = [
      Content.multi([
        TextPart("Get Matched Clebrity"),
        DataPart('image/jpeg', imageBytes)
      ]),
    ];

    try {
      final response = await model.generateContent(content);
      log("Response ${response.text}");
      Map<String, dynamic> jsonMap = jsonDecode(response.text ?? '');
      log("jsonMap ${jsonMap}");
      celebrity_match.value = CelebrityMatch.fromJson(jsonMap);
      imageUrl.value = await APIService()
              .fetchImageUrl(celebrity_match.value!.celebrityName) ??
          "";

      log("Image Url: ${imageUrl.value ?? ''}");
      responseStatus.value = ResponseStatus.success;
    } on Exception catch (e) {
      responseStatus.value = ResponseStatus.failed;
      // showErrorDialog(Get.context!, e.toString());
      log("Celebrity Error: ${e.toString()}");

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
}
