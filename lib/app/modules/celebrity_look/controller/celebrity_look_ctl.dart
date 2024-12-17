import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:face_scanner/app/data/celebrity_lists.dart';
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
        '''You are trained to tell a sketch artist about the sketch detail of the image provided. you have to eloborate everything so a sketch artist can draw the exact sketch of the person.
        you have to tell the details of each facial part and their shapes, color. also tell about hair. with or without glasses, beard etc.

        also tell if a person is male or female
      
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
            "sketchDetails",
          ],
          properties: {
            "sketchDetails": Schema(
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

      await sketchToCelebrity(jsonMap.toString());
      // celebrity_match.value = CelebrityMatch.fromJson(jsonMap);
      // imageUrl.value = await APIService()
      //         .fetchImageUrl(celebrity_match.value!.celebrityName) ??
      //     "";

      log("Image Url: ${imageUrl.value}");
      responseStatus.value = ResponseStatus.success;
    } on Exception catch (e) {
      responseStatus.value = ResponseStatus.failed;
      // showErrorDialog(Get.context!, e.toString());
      log("Celebrity Error: ${e.toString()}");

      // TODO
    }
  }

  Future<void> sketchToCelebrity(String sketchDetails) async {
    String list = '';

    // if (selectedOption.value == 'Top 100 social media influencers') {
    //   list = top100Influencers.toString();
    // }
    if (selectedOption.value == 'Top 100 social media influencers') {
      list = top100Influencers.toString();
    } else if (selectedOption.value == 'Top 100 best football players') {
      list = top100FootballPlayers.toString();
    } else if (selectedOption.value == 'Richest people in the World') {
      list = richestPeople.toString();
    } else if (selectedOption.value == 'Top 100 Beauty Women') {
      list = top100BeautyWomen.toString();
    } else if (selectedOption.value == 'Top 100 Handsome Men') {
      list = top100HandsomeMen.toString();
    } else if (selectedOption.value == 'Bodybuilder in the World') {
      list = topBodybuilders.toString();
    } else if (selectedOption.value == 'Supermodels in the World') {
      list = supermodelsInWorld.toString();
    } else if (selectedOption.value == 'Contemporary basketballer') {
      list = contemporaryBasketballers.toString();
    } else if (selectedOption.value == 'Top Asian influencers') {
      list = topAsianInfluencers.toString();
    }

    // Future<void> sendImageToGoogleAI(File imgFile) async {
//     Sting sketchDetails = '''
//   The subject appears to be a male with dark brown to black hair that is short and slightly messy, not neatly combed.  The hair is thick and appears to have a natural wave or texture to it.  It's slightly longer on top than on the sides. He has a full, well-groomed beard that is also dark brown to black. The beard is slightly longer on the cheeks and chin, giving it a somewhat rounded shape.  His eyebrows are dark and relatively thick, with a slightly arched shape. His eyes are dark brown, and his nose is medium-sized with a straight bridge. His lips are medium-full and appear to be a natural pinkish-brown tone. His skin tone is medium brown. His facial structure is somewhat angular, with a strong jawline. He is wearing a dark-colored, possibly dark green or gray, jacket or coat. The jacket appears to be made of a somewhat textured material. The overall expression in the image is neutral to slightly serious
// ''';
    responseStatus.value = ResponseStatus.progress;

    String celebrityType = selectedOption.value;

    final SystemInstruction =
        '''You are an advanced-level facial analysis expert. You will be given Sketch Details of a person. Based on the facial features of the person in the detail, analyze and find a celebrity from the category "$celebrityType" with the closest resemblance to these facial features.
        Sketch Details: $sketchDetails


Consider the following when making a match:
- look for the similar hair style type
- look for the similar eyes , eyebrows , lips
- look for the similar face shape like oval, round etc
- keep in mind the gender suggested in sketch do not tell opposite gender personality in response
- proess and list all matched personalities and select which fit the best
- do not tell same functionality for every person
- Regional diversity: Ensure the match aligns with the region or cultural group.
- Profession alignment: Focus on the specific category of celebrities mentioned.


Look for the celebrity from following Celebrity List:  ${list}

Respond only in JSON format, following the structure below:
{
    "name": "<string>",                   // Celebrity's full name
    "country": "<string>",                // Celebrity's country of origin
    "profession": "<string>",             // Celebrity's primary profession
    "match_percentage": "<float>",        // Similarity score between 1 and 100
    "description": "<string>"             // Specific features that align with the celebrity, like face shape, eyes, jawline, eyebrows, etc.
    "otherCelebrities": "<List of String>"             // List all other matched celebrities as well atleast 3
}
''';

    final model = GenerativeModel(
      // model: 'gemini-1.5-pro',
      model: 'gemini-1.5-flash',
      apiKey: RCVariables.GeminiAPIKey,
      generationConfig: GenerationConfig(
        temperature: 0.1,
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
            "description",
            "otherCelebrities"
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
            "otherCelebrities":
                Schema(SchemaType.array, items: Schema(SchemaType.string)),
          },
        ),
      ),
      systemInstruction: Content.system(SystemInstruction),
    );

    // log("Prompt: $prompt");
    // Uint8List imageBytes = await imgFile.readAsBytes();
    final content = [
      Content.multi([
        TextPart("Get Matched Clebrity"),
        // DataPart('image/jpeg', imageBytes)
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

      log("Image Url: ${imageUrl.value}");
      responseStatus.value = ResponseStatus.success;
    } on Exception catch (e) {
      responseStatus.value = ResponseStatus.failed;
      // showErrorDialog(Get.context!, e.toString());
      log("Celebrity Error: ${e.toString()}");

      // TODO
    }
  }

  //? Old Class
//   Future<void> sendImageToGoogleAI(File imgFile) async {
//     responseStatus.value = ResponseStatus.progress;

//     String celebrityType = selectedOption.value;

//     final SystemInstruction =
//         '''You are an advanced-level facial analysis expert. You will be given an image of a person. Based on the facial features of the person in the image, analyze and find a celebrity from the category "$celebrityType" with the closest resemblance to these facial features.
// Consider the following when making a match:
// - look for the similar hair style type
// - look for the similar eyes , eyebrows , lips
// - look for the similar face shape like oval, round etc
// - proess and list all matched personalities and select which fit the best
// - do not tell same functionality for every person
// - Regional diversity: Ensure the match aligns with the region or cultural group.
// - Profession alignment: Focus on the specific category of celebrities mentioned.

// Respond only in JSON format, following the structure below:
// {
//     "name": "<string>",                   // Celebrity's full name
//     "country": "<string>",                // Celebrity's country of origin
//     "profession": "<string>",             // Celebrity's primary profession
//     "match_percentage": "<float>",        // Similarity score between 1 and 100
//     "description": "<string>"             // Specific features that align with the celebrity, like face shape, eyes, jawline, eyebrows, etc.
//     "otherCelebrities": "<List of String>"             // List all other matched celebrities as well atleast 3
// }
// ''';

//     final model = GenerativeModel(
//       // model: 'gemini-1.5-pro',
//       model: 'gemini-1.5-flash',
//       apiKey: RCVariables.GeminiAPIKey,
//       generationConfig: GenerationConfig(
//         temperature: 0.1,
//         topK: 40,
//         topP: 0.95,
//         maxOutputTokens: 500,
//         responseMimeType: 'application/json',
//         responseSchema: Schema(
//           SchemaType.object,
//           enumValues: [],
//           requiredProperties: [
//             "celebrityName",
//             "country",
//             "profession",
//             "match_percentage",
//             "description",
//             "otherCelebrities"
//           ],
//           properties: {
//             "celebrityName": Schema(
//               SchemaType.string,
//             ),
//             "country": Schema(
//               SchemaType.string,
//             ),
//             "profession": Schema(
//               SchemaType.string,
//             ),
//             "match_percentage": Schema(
//               SchemaType.integer,
//             ),
//             "description": Schema(
//               SchemaType.string,
//             ),
//             "otherCelebrities":
//                 Schema(SchemaType.array, items: Schema(SchemaType.string)),
//           },
//         ),
//       ),
//       systemInstruction: Content.system(SystemInstruction),
//     );

//     // log("Prompt: $prompt");
//     Uint8List imageBytes = await imgFile.readAsBytes();
//     final content = [
//       Content.multi([
//         TextPart("Get Matched Clebrity"),
//         DataPart('image/jpeg', imageBytes)
//       ]),
//     ];

//     try {
//       final response = await model.generateContent(content);
//       log("Response ${response.text}");
//       Map<String, dynamic> jsonMap = jsonDecode(response.text ?? '');
//       log("jsonMap ${jsonMap}");
//       celebrity_match.value = CelebrityMatch.fromJson(jsonMap);
//       imageUrl.value = await APIService()
//               .fetchImageUrl(celebrity_match.value!.celebrityName) ??
//           "";

//       log("Image Url: ${imageUrl.value}");
//       responseStatus.value = ResponseStatus.success;
//     } on Exception catch (e) {
//       responseStatus.value = ResponseStatus.failed;
//       // showErrorDialog(Get.context!, e.toString());
//       log("Celebrity Error: ${e.toString()}");

//       // TODO
//     }
//   }

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
