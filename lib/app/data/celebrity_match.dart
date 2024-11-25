class CelebrityMatch {
  final String celebrityName;
  final String country;
  final String profession;
  final String matchPercentage;
  final String description;

  CelebrityMatch({
    required this.celebrityName,
    required this.country,
    required this.profession,
    required this.matchPercentage,
    required this.description,
  });

  // Factory method to create a CelebrityMatch instance from JSON
  factory CelebrityMatch.fromJson(Map<String, dynamic> json) {
    return CelebrityMatch(
      celebrityName: json['celebrityName'] ?? '',
      country: json['country'] ?? '',
      profession: json['profession'] ?? '',
      matchPercentage: (json['match_percentage'] ?? '').toString(),
      description: json['description'] ?? '',
    );
  }

  // Method to convert a CelebrityMatch instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'celebrityName': celebrityName,
      'country': country,
      'profession': profession,
      'match_percentage': matchPercentage,
      'description': description,
    };
  }
}
