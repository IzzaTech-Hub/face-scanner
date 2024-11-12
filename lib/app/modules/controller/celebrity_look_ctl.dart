import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class CelebrityLookCtl extends GetxController {
  var selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

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
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      // model: 'gemini-1.5-flash',
      apiKey: "AIzaSyD4cCpD7lP-Q9raPF59L8npR8H5NF3pLIo",
      generationConfig: GenerationConfig(
        temperature: 0.3,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 250,
        responseMimeType: 'text/plain',
      ),
    );

    final prompt = '''
Your are an expert face analyzer. You will be given an image you will have to detect which celebrity best resembles to the person appear in image you have to give your response in following json format.

{
     "name": "<string>",\n
     "country": "<string>",\n
     "profession": "<string>",\n
     "match_percentage": "<float>",  Range(1,100)
     "description": "<string>", (describe in what expect the person match to the celebrity. like beard, lips jaw line, eyes, hair, eye brows etc)

     
}

Note: dont give me any text or disclaimer or note your response should start from { bracket of json structure and end with } json bracket
''';

    log("Prompt: $prompt");
    Uint8List imageBytes = await imgFile.readAsBytes();
    final content = [
      Content.multi([TextPart(prompt), DataPart('image/jpeg', imageBytes)]),
    ];

    final response = await model.generateContent(content);
    log("Response ${response.text}");
    Map<String, dynamic> jsonMap = jsonDecode(response.text ?? '');
    log("jsonMap ${jsonMap}");
  }
}
