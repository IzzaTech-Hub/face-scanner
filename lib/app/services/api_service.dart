import 'dart:convert';
import 'dart:developer';
import 'package:face_scanner/app/utills/rc_variables.dart';
import 'package:http/http.dart' as http;

class APIService {
  // Private constructor
  APIService._privateConstructor();

  // The single instance of APIService
  static final APIService _instance = APIService._privateConstructor();

  // Factory constructor to return the same instance
  factory APIService() {
    return _instance;
  }

  // API credentials
  // final String apiKey = "AIzaSyB-bJtmzJNUJug6k1kIvkbDb1f0MhkYcuI";
  // final String cx = "f040e1d0e21e74322";
  final String baseUrl = "https://www.googleapis.com/customsearch/v1";

  // Fetch image URL method
  Future<String?> fetchImageUrl(String query) async {
    final url = Uri.parse(
        "$baseUrl?q=$query&cx=${RCVariables.customeSearchcx}&key=${RCVariables.customeSearchKey}&searchType=image");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data["items"];
        log("Custome Search Items: ${items}");

        if (items != null && items.isNotEmpty) {
          for (var item in items) {
            final imageUrl = item["link"];
            if (_isImageLink(imageUrl)) {
              return imageUrl;
            }
          }
          print("No valid image links found.");
          return null;
        } else {
          print("No images found for the query.");
          return null;
        }
      } else {
        print("Failed to fetch images. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error fetching image URL: $e");
      return null;
    }
  }

  bool _isImageLink(String url) {
    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif'];
    final excludedKeywords = ['instagram', 'facebook', 'twitter', 'linkedin'];

    // Check if URL ends with a valid image extension
    bool hasValidExtension =
        imageExtensions.any((ext) => url.toLowerCase().endsWith(ext));

    // Check if URL contains any excluded keywords
    bool containsExcludedKeywords =
        excludedKeywords.any((keyword) => url.toLowerCase().contains(keyword));

    return hasValidExtension && !containsExcludedKeywords;
  }
}
