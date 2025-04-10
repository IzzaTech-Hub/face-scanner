import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:face_scanner/app/data/beauty_analysis.dart';
import 'package:face_scanner/app/data/response_status.dart';
import 'package:face_scanner/app/modules/home/controller/home_view_ctl.dart';
import 'package:face_scanner/app/services/api_service.dart';
import 'package:face_scanner/app/utills/gems_rate.dart';
import 'package:face_scanner/app/utills/rc_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class FaceBeautyAnalysisCtl extends GetxController {
  var selectedImage = Rx<File?>(null);
  RxInt selectedIndex = 0.obs;
  Rx<bool> isScanning = false.obs;
  // RxString score = "6.76".obs;
  // RxString gender = "Male".obs;
  // RxString smile = "6".obs;
  // RxString age = "26".obs;
  // RxString ethnicity = "-".obs;
  // RxString glass = "None".obs;
  // RxString face_quality = "64".obs;

  Rx<BeautyAnalysis?> beauty_analysis = Rx<BeautyAnalysis?>(null);
  // RxString imageUrl = "".obs;
  Rx<ResponseStatus> responseStatus = ResponseStatus.idle.obs;
  // Rx<ResponseStatus> responseStatus = ResponseStatus.progress.obs;
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
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      log("Picked Image");
      responseStatus.value = ResponseStatus.idle;

      // startScanningImage(selectedImage.value!);
      // sendImageToGoogleAI(selectedImage.value!);
    }
  }

  Future<void> sendImageToGoogleAI(File imgFile) async {
    responseStatus.value = ResponseStatus.progress;

    String celebrityType =
        "Top 50 youtuber  from the region of Person in image";

    final SystemInstruction =
        ''' You are an advance level facial analysis expert. You will be given an image of a person. 
          You will have to analyze the image and give score and detect other features as given in json schema.


{
"score" : "<float>",                // Beauty Score out of 10.  consider overall facial features of the person while giving the score
   "gender" : <string>,            // Gender
   "smile" : "<int>",             // smile  how much person is smiling.
   "age" : "<int>",              // age
   "ethnicity" : "<String>",     // Ethnicity   
   "glass" : "<bool>",       // Glass  check if wearing glasses or not
  "face_quality" : "<number>",   // Face quality. get the overall quality of the face  in percentage
    "face_description":  "<string>"   // Write 30-50 words describing overall best features in the face and negative features that causes to deduct score and quality of face.
}
''';

    final model = GenerativeModel(
      // model: RCVariables.geminiModel,
      model: RCVariables.geminiModel,
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
          requiredProperties: [
            "score",
            "gender",
            "smile",
            "age",
            "ethnicity",
            "glass",
            "face_description",
            "face_quality",
          ],
          properties: {
            "score": Schema(
              SchemaType.number,
            ),
            "gender": Schema(
              SchemaType.string,
            ),
            "smile": Schema(
              SchemaType.number,
            ),
            "age": Schema(
              SchemaType.integer,
            ),
            "ethnicity": Schema(
              SchemaType.string,
            ),
            "glass": Schema(
              SchemaType.boolean,
            ),
            "face_quality": Schema(
              SchemaType.integer,
            ),
            "face_description": Schema(
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
        TextPart("Get Beauty Analysis"),
        DataPart('image/jpeg', imageBytes)
      ]),
    ];

    try {
      final response = await model.generateContent(content);
      log("Response ${response.text}");
      Map<String, dynamic> jsonMap = jsonDecode(response.text ?? '');
      log("jsonMap ${jsonMap}");
      beauty_analysis.value = BeautyAnalysis.fromJson(jsonMap);

      responseStatus.value = ResponseStatus.success;

      HomeViewCtl homeViewCtl = Get.find();
      homeViewCtl.decreaseGEMS(GEMS_RATE.FaceBeautyGems);
    } on Exception catch (e) {
      responseStatus.value = ResponseStatus.failed;
      // showErrorDialog(Get.context!, e.toString());
      log("FaceBeauty Error: ${e.toString()}");

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
