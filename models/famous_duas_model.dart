class FamousDuas {
  final String id;
  final String category;
  final String title;
  final String arabic;
  final String translation;

  FamousDuas({
    required this.id,
    required this.category,
    required this.title,
    required this.arabic,
    required this.translation,
  });

  factory FamousDuas.fromJson(Map<String, dynamic> json) {
    return FamousDuas(
      id: json['id'],
      category: json['category'],
      title: json['title'],
      arabic: json['arabic'],
      translation: json['translation'],
    );
  }
}
