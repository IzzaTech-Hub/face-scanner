import 'package:get/get.dart';

class BeautyAnalysis {
  final double score;
  final String gender;
  final String smile;
  final String age;
  // final String ethnicity;
  // final String glass;
  final String faceQuality;

  BeautyAnalysis({
    required double score,
    required String gender,
    required String smile,
    required String age,
    // required String ethnicity,
    // required String glass,
    required String faceQuality,
  })  : score = score,
        gender = gender,
        smile = smile,
        age = age,
        // ethnicity = ethnicity.obs,
        // glass = glass.obs,
        faceQuality = faceQuality;

  // Factory method to create a FaceBeautyAnalysis instance from JSON
  factory BeautyAnalysis.fromJson(Map<String, dynamic> json) {
    return BeautyAnalysis(
      score: (json['score'] ?? 0.0),
      gender: json['gender'] ?? '',
      smile: (json['smile'] ?? '').toString(),
      age: (json['age'] ?? '').toString(),
      // ethnicity: json['ethnicity'] ?? '',
      // glass: json['glass'] ?? '',
      faceQuality: (json['face_quality'] ?? '').toString(),
    );
  }

  // Method to convert a FaceBeautyAnalysis instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'gender': gender,
      'smile': smile,
      'age': age,
      // 'ethnicity': ethnicity,
      // 'glass': glass,
      'face_quality': faceQuality,
    };
  }
}
