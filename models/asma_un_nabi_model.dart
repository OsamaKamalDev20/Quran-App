class AsmaaUnNabiModel {
  final int id;
  final String arabic;
  final String transliteration;
  final String translation;
  final String meaning;

  AsmaaUnNabiModel({
    required this.id,
    required this.arabic,
    required this.transliteration,
    required this.translation,
    required this.meaning,
  });

  factory AsmaaUnNabiModel.fromJson(Map<String, dynamic> json) {
    return AsmaaUnNabiModel(
      id: json['id'],
      arabic: json['arabic'],
      transliteration: json['transliteration'],
      translation: json['translation'],
      meaning: json['meaning'],
    );
  }
}
