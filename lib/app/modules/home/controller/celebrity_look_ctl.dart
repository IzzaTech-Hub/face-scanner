import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:face_scanner/app/data/celebrity_match.dart';
import 'package:face_scanner/app/services/api_service.dart';
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

  RxBool isTrue = false.obs;

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
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      // model: 'gemini-1.5-flash',
      apiKey: "AIzaSyD4cCpD7lP-Q9raPF59L8npR8H5NF3pLIo",
      generationConfig: GenerationConfig(
        temperature: 0.5,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 250,
        responseMimeType: 'text/plain',
      ),
    );

    String celebrityType =
        "Top 50 youtuber  from the region of Person in image";

// You are an advanced facial analysis expert with expertise in detailed celebrity resemblance. Given an image, your task is to analyze the facial features and identify the celebrity with the closest resemblance. Consider details like facial structure, hairstyle, eye shape, skin tone, and expression for accuracy. Respond only in JSON format, following the structure below:

    final prompt = '''

You are an advance level facial analysis expert. You will be given an image of a person. you will have to extract the facial features of the person in image and on the basis of these features, try and find celebrity from $celebrityType who has closest resemblance with these facial features. Respond only in JSON format, following the structure below:
{
    "name": "<string>",                   // Celebrity's full name
    "country": "<string>",                // Celebrity's country of origin
    "profession": "<string>",             // Celebrity's primary profession
    "match_percentage": "<float>",        // Similarity score between 1 and 100
    "description": "<string>"             // Specific features that align with the celebrity, like face shape, eyes, jawline, eyebrows, etc.
}

Note: Provide your response only in JSON format, starting with { and ending with }.
''';

    log("Prompt: $prompt");
    Uint8List imageBytes = await imgFile.readAsBytes();
    final content = [
      Content.multi([TextPart(prompt), DataPart('image/jpeg', imageBytes)]),
    ];

    try {
      final response = await model.generateContent(content);
      log("Response ${response.text}");
      Map<String, dynamic> jsonMap = jsonDecode(response.text ?? '');
      log("jsonMap ${jsonMap}");
      celebrity_match.value = CelebrityMatch.fromJson(jsonMap);
      imageUrl.value =
          await APIService().fetchImageUrl(celebrity_match.value!.name) ?? "";

      log("Image Url: ${imageUrl.value ?? ''}");
      responseStatus.value = ResponseStatus.success;
    } on Exception catch (e) {
      responseStatus.value = ResponseStatus.failed;
      showErrorDialog(Get.context!, e.toString());

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

enum ResponseStatus { idle, success, failed, progress }
