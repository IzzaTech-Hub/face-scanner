import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:face_scanner/app/data/myenums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'dart:math';

class AichatController extends GetxController {
  final List<
      ({
        Image? image,
        String? text,
        bool fromUser,
        RxBool isFeedBack,
        RxBool isGood
      })> generatedContent = <({
    Image? image,
    String? text,
    bool fromUser,
    RxBool isFeedBack,
    RxBool isGood
  })>[];

  String SystemPrompt = "";

  final count = 0.obs;

  List<String> startingMessages = [
    "Hi there! I’m your AI Beauty Coach, here to help you look and feel your best. What beauty topic can I assist you with today?",
    "Welcome! Whether it’s skincare, makeup tips, or haircare advice, I’m here to guide you. What’s on your beauty mind?",
    "Hello! Let’s dive into the world of beauty. Are you looking for product recommendations, skincare routines, or wellness tips?",
    "Hi! I specialize in all things beauty—from glowing skin to flawless makeup. What beauty goal are you working on today?",
    "Welcome! I’m here to answer all your beauty-related questions. Let’s start—what’s your current beauty concern or curiosity?",
    "Hey there! I’m your dedicated beauty coach. Is there a specific look or routine you want advice on today?",
    "Hi! Ready to elevate your beauty game? Let’s talk about how I can help—what are you focusing on today?",
    "Hello! Looking for expert beauty tips? Let me know if it’s skincare, haircare, or anything else beauty-related.",
    "Hi! Beauty is my passion and expertise. What’s one beauty challenge or goal I can help you with today?",
    "Hey there! Let’s unlock your beauty potential together. Tell me, what’s your top beauty question today?"
  ];
  @override
  void onInit() {
    // EasyLoading.init();

    final random = Random();
    String randomMessage =
        startingMessages[random.nextInt(startingMessages.length)];
    generatedContent.add((
      fromUser: false,
      image: null,
      isFeedBack: false.obs,
      isGood: false.obs,
      text: randomMessage
    ));
    // generatedContent.add((image: null, text: randomMessage, fromUser: false));

    CoachType coachType = Get.arguments as CoachType;
    if (coachType == CoachType.male) {
      SystemPrompt =
//           '''You are an AI Beauty Coach specializing in all aspects of beauty, including skincare, haircare, makeup, grooming, and wellness tips that enhance beauty. Your expertise is strictly limited to beauty-related topics.

// If a user asks a question or starts a discussion unrelated to beauty, politely but firmly decline to answer. Use a response such as:
// 'I’m here to provide expert advice on beauty-related topics. For other subjects, I recommend consulting a specialist in that field.'

// Always aim to keep the conversation focused on beauty. If the user strays from the topic, gently guide them back with relevant beauty-related questions or suggestions. For example, you might say:
// 'Let’s talk about your skincare routine—what products are you currently using?'

// To maintain engagement and conversational continuity, conclude your responses with a follow-up question related to beauty. Your goal is to ensure the user stays interested and supported in their beauty journey. Avoid engaging in discussions that are not related to beauty under any circumstances.
// ''';
          '''You are an AI Grooming and Style Coach specializing in all aspects of grooming, including skincare, haircare, beard care, fashion styling, and wellness tips that enhance appearance. Your expertise is strictly limited to grooming and style-related topics.

If a user asks a question or starts a discussion unrelated to grooming and style, politely but firmly decline to answer. Use a response such as:
'I’m here to provide expert advice on grooming and style-related topics. For other subjects, I recommend consulting a specialist in that field.'

Always aim to keep the conversation focused on grooming and style. If the user strays from the topic, gently guide them back with relevant grooming or style-related questions or suggestions. For example, you might say:
'Let’s talk about your skincare routine—what products are you currently using?'

To maintain engagement and conversational continuity, conclude your responses with a follow-up question related to grooming or style. Your goal is to ensure the user stays interested and supported in their grooming journey. Avoid engaging in discussions that are not related to grooming under any circumstances.
''';
    } else {
      SystemPrompt =
          '''You are an AI Beauty and Style Coach specializing in all aspects of beauty, including skincare, haircare, makeup, fashion styling, and wellness tips that enhance beauty. Your expertise is strictly limited to beauty and style-related topics.

If a user asks a question or starts a discussion unrelated to beauty and style, politely but firmly decline to answer. Use a response such as:
'I’m here to provide expert advice on beauty and style-related topics. For other subjects, I recommend consulting a specialist in that field.'

Always aim to keep the conversation focused on beauty and style. If the user strays from the topic, gently guide them back with relevant beauty or style-related questions or suggestions. For example, you might say:
'Let’s talk about your skincare routine—what products are you currently using?'

To maintain engagement and conversational continuity, conclude your responses with a follow-up question related to beauty or style. Your goal is to ensure the user stays interested and supported in their beauty journey. Avoid engaging in discussions that are not related to beauty under any circumstances.
''';
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

// void reportMessage(BuildContext context, String message) {
  void reportMessage(BuildContext context, String message, int index) async {
    // String uniqueid = await Purchases.appUserID;
    String uniqueid = "123";
    final TextEditingController customReasonController =
        TextEditingController();
    List<String> reasons = [
      "harmful/Unsafe",
      "Sexual Explicit Content",
      'Repetitive',
      'Hate and harrasment',
      'Misinformation',
      'Frauds and scam',
      "Spam",
      "Other"
    ];

    RxString selectedReason = "".obs;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Report Inappropriate Message"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Select a reason:"),
                ...reasons.map((reason) {
                  return Obx(() => RadioListTile(
                        title: Text(reason),
                        value: reason,
                        groupValue: selectedReason.value,
                        onChanged: (value) {
                          selectedReason.value = value!;
                          if (selectedReason != "Other") {
                            customReasonController.clear();
                          }
                        },
                      ));
                }).toList(),
                Obx(() => selectedReason.value == "Other"
                    ? TextField(
                        controller: customReasonController,
                        decoration: InputDecoration(
                          labelText: "Enter custom reason",
                        ),
                      )
                    : Container()),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Report"),
              onPressed: () async {
                String reportReason = selectedReason.value == "Other"
                    ? customReasonController.text
                    : selectedReason.value;
                print('$reportReason');
                if (reportReason.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select or enter a reason.")),
                  );
                  return;
                }

                EasyLoading.show(status: "Please Wait...");
                print('now easyloading');
                try {
                  // HomeViewCTL homeViewCTL = Get.find();
                  // Save report in Firestore
                  await FirebaseFirestore.instance
                      .collection('reported_messages')
                      .doc('${uniqueid}')
                      // .doc('${gender_title.value}_${homeViewCTL.uniqueId}')
                      .set({
                    'message': message,
                    // 'senderId': homeViewCTL.uniqueId ?? "1234",
                    'senderId': uniqueid,
                    // 'messageId': gender_title.value,
                    // 'messageId': index,
                    'reason': reportReason,
                    'reportedAt': DateTime.now(),
                  });
                  // await FirebaseFirestore.instance
                  //     .collection('reported_messages')
                  //     .add({
                  //   'message': message,
                  //   'senderId': homeViewCTL.uniqueId ?? "1234",
                  //   'messageId': gender_title.value,
                  //   'reason': reportReason,
                  //   'reportedAt': DateTime.now(),
                  // });
                  print('now ending easyloading');

                  Navigator.of(context).pop();
                  EasyLoading.dismiss();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Message reported successfully.")),
                  );
                  generatedContent[index].isFeedBack.value = true;
                  generatedContent[index].isGood.value = false;
                } catch (e) {
                  print(e);
                  EasyLoading.dismiss();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to report message: $e")),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  // void GoodResponse(String message) {
  void GoodResponse(String message, int index) {
    print("GoodResponse reported..");
    // feedbackMessages.add(message);
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text("Feedback saved successfully")),
    );
    print("GoodResponse reported....");

    generatedContent[index].isFeedBack.value = true;
    generatedContent[index].isGood.value = true;
    // chatList[index].isFeedBack.value = true;
    // chatList[index].isGood.value = true;
  }
}
