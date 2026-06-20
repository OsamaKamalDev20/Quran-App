class AsmaUlHusnaModel {
  final int id;
  final String arabic;
  final String transliteration;
  final String translation;
  final String meaning;

  AsmaUlHusnaModel({
    required this.id,
    required this.arabic,
    required this.transliteration,
    required this.translation,
    required this.meaning,
  });

  factory AsmaUlHusnaModel.fromJson(Map<String, dynamic> json) {
    return AsmaUlHusnaModel(
      id: json['id'],
      arabic: json['arabic'],
      transliteration: json['transliteration'],
      translation: json['translation'],
      meaning: json['meaning'],
    );
  }
}
