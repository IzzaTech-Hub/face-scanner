import 'package:get/get.dart';

class BeautyAnalysis {
  final double score;
  final String gender;
  final String smile;
  final String age;
  final String ethnicity;
  final bool glass;
  final String faceQuality;
  final String face_description;

  BeautyAnalysis({
    required this.ethnicity,
    required this.glass,
    required this.score,
    required this.gender,
    required this.smile,
    required this.age,
    required this.faceQuality,
    required this.face_description,
  });

  // Factory method to create a FaceBeautyAnalysis instance from JSON
  factory BeautyAnalysis.fromJson(Map<String, dynamic> json) {
    return BeautyAnalysis(
      score: (json['score'] ?? 0.0).toDouble(),
      gender: json['gender'] ?? '',
      smile: (json['smile'] ?? '').toString(),
      age: (json['age'] ?? '').toString(),
      // ethnicity: json['ethnicity'] ?? '',
      // glass: json['glass'] ?? '',
      faceQuality: (json['face_quality'] ?? '').toString(),

      ethnicity: (json['ethnicity'] ?? '').toString(),
      glass: (json['glass'] ?? false),
      face_description: (json['face_description'] ?? '').toString(),
    );
  }

  // Method to convert a FaceBeautyAnalysis instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'gender': gender,
      'smile': smile,
      'age': age,
      'ethnicity': ethnicity,
      'glass': glass,
      'face_quality': faceQuality,
      'face_description': face_description,
    };
  }
}
