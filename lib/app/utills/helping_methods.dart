import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HelpingMethods {
  // Private constructor
  HelpingMethods._privateConstructor();

  // Singleton instance
  static final HelpingMethods _instance = HelpingMethods._privateConstructor();

  // Getter for the singleton instance
  static HelpingMethods get instance => _instance;

  void ShowNoGemsToast() {
    Fluttertoast.showToast(
      msg: "Not enough gems. Please earn or purchase more.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  // Method to show a toast message
  // void showToast({
  //   required String message,
  //   Color backgroundColor = Colors.red,
  //   Color textColor = Colors.white,
  //   ToastGravity gravity = ToastGravity.BOTTOM,
  //   int fontSize = 16,
  //   Toast toastLength = Toast.LENGTH_SHORT,
  // }) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: toastLength,
  //     gravity: gravity,
  //     backgroundColor: backgroundColor,
  //     textColor: textColor,
  //     fontSize: fontSize.toDouble(),
  //   );
  // }
}
