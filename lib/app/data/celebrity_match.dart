class CelebrityMatch {
  final String name;
  final String country;
  final String profession;
  final String matchPercentage;
  final String description;

  CelebrityMatch({
    required this.name,
    required this.country,
    required this.profession,
    required this.matchPercentage,
    required this.description,
  });

  // Factory method to create a CelebrityMatch instance from JSON
  factory CelebrityMatch.fromJson(Map<String, dynamic> json) {
    return CelebrityMatch(
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      profession: json['profession'] ?? '',
      matchPercentage: (json['match_percentage'] ?? '').toString(),
      description: json['description'] ?? '',
    );
  }

  // Method to convert a CelebrityMatch instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': country,
      'profession': profession,
      'match_percentage': matchPercentage,
      'description': description,
    };
  }
}
