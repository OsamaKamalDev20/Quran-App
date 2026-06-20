// To parse this JSON data, do
//
//     final surahModel = surahModelFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

SurahModel surahModelFromJson(String str) =>
    SurahModel.fromJson(json.decode(str));

String surahModelToJson(SurahModel data) => json.encode(data.toJson());

class SurahModel {
  int code;
  String status;
  List<Datum> data;

  SurahModel({required this.code, required this.status, required this.data});

  factory SurahModel.fromJson(Map<String, dynamic> json) => SurahModel(
    code: json["code"],
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  int numberOfAyahs;
  RevelationType revelationType;

  Datum({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    number: json["number"],
    name: json["name"],
    englishName: json["englishName"],
    englishNameTranslation: json["englishNameTranslation"],
    numberOfAyahs: json["numberOfAyahs"],
    revelationType: revelationTypeValues.map[json["revelationType"]]!,
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "name": name,
    "englishName": englishName,
    "englishNameTranslation": englishNameTranslation,
    "numberOfAyahs": numberOfAyahs,
    "revelationType": revelationTypeValues.reverse[revelationType],
  };
}

enum RevelationType { MECCAN, MEDINAN }

final revelationTypeValues = EnumValues({
  "Meccan": RevelationType.MECCAN,
  "Medinan": RevelationType.MEDINAN,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
