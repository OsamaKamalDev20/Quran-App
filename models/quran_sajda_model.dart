// To parse this JSON data, do
//
//     final quranSajdaModel = quranSajdaModelFromJson(jsonString);

import 'dart:convert';

QuranSajdaModel quranSajdaModelFromJson(String str) =>
    QuranSajdaModel.fromJson(json.decode(str));

String quranSajdaModelToJson(QuranSajdaModel data) =>
    json.encode(data.toJson());

class QuranSajdaModel {
  int code;
  String status;
  Data data;

  QuranSajdaModel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory QuranSajdaModel.fromJson(Map<String, dynamic> json) =>
      QuranSajdaModel(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  List<Ayah> ayahs;
  Edition edition;

  Data({required this.ayahs, required this.edition});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    ayahs: List<Ayah>.from(json["ayahs"].map((x) => Ayah.fromJson(x))),
    edition: Edition.fromJson(json["edition"]),
  );

  Map<String, dynamic> toJson() => {
    "ayahs": List<dynamic>.from(ayahs.map((x) => x.toJson())),
    "edition": edition.toJson(),
  };
}

class Ayah {
  int number;
  String text;
  Surah surah;
  int numberInSurah;
  int juz;
  int manzil;
  int page;
  int ruku;
  int hizbQuarter;
  Sajda sajda;

  Ayah({
    required this.number,
    required this.text,
    required this.surah,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) => Ayah(
    number: json["number"],
    text: json["text"],
    surah: Surah.fromJson(json["surah"]),
    numberInSurah: json["numberInSurah"],
    juz: json["juz"],
    manzil: json["manzil"],
    page: json["page"],
    ruku: json["ruku"],
    hizbQuarter: json["hizbQuarter"],
    sajda: Sajda.fromJson(json["sajda"]),
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "text": text,
    "surah": surah.toJson(),
    "numberInSurah": numberInSurah,
    "juz": juz,
    "manzil": manzil,
    "page": page,
    "ruku": ruku,
    "hizbQuarter": hizbQuarter,
    "sajda": sajda.toJson(),
  };
}

class Sajda {
  int id;
  bool recommended;
  bool obligatory;

  Sajda({
    required this.id,
    required this.recommended,
    required this.obligatory,
  });

  factory Sajda.fromJson(Map<String, dynamic> json) => Sajda(
    id: json["id"],
    recommended: json["recommended"],
    obligatory: json["obligatory"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "recommended": recommended,
    "obligatory": obligatory,
  };
}

class Surah {
  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  RevelationType revelationType;
  int numberOfAyahs;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.numberOfAyahs,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
    number: json["number"],
    name: json["name"],
    englishName: json["englishName"],
    englishNameTranslation: json["englishNameTranslation"],
    revelationType: revelationTypeValues.map[json["revelationType"]]!,
    numberOfAyahs: json["numberOfAyahs"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "name": name,
    "englishName": englishName,
    "englishNameTranslation": englishNameTranslation,
    "revelationType": revelationTypeValues.reverse[revelationType],
    "numberOfAyahs": numberOfAyahs,
  };
}

enum RevelationType { MECCAN, MEDINAN }

final revelationTypeValues = EnumValues({
  "Meccan": RevelationType.MECCAN,
  "Medinan": RevelationType.MEDINAN,
});

class Edition {
  String identifier;
  String language;
  String name;
  String englishName;
  String format;
  String type;
  String direction;

  Edition({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
    required this.format,
    required this.type,
    required this.direction,
  });

  factory Edition.fromJson(Map<String, dynamic> json) => Edition(
    identifier: json["identifier"],
    language: json["language"],
    name: json["name"],
    englishName: json["englishName"],
    format: json["format"],
    type: json["type"],
    direction: json["direction"],
  );

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "language": language,
    "name": name,
    "englishName": englishName,
    "format": format,
    "type": type,
    "direction": direction,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
