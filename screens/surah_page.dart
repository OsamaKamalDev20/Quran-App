// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ui/Quran%20App/models/surah_model.dart';
import 'package:flutter_ui/Quran%20App/screens/surah_detail_page.dart';
import 'package:flutter_ui/Quran%20App/utils/colors.dart';
import 'package:http/http.dart' as http;

class QuranSurah extends StatefulWidget {
  const QuranSurah({super.key});

  @override
  State<QuranSurah> createState() => _QuranSurahState();
}

class _QuranSurahState extends State<QuranSurah> {
  List<Datum> surahList = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchSurah();
  }

  Future<void> fetchSurah() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.alquran.cloud/v1/surah'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['code'] == 200) {
          List<dynamic> surahsJson = data['data'];
          setState(() {
            surahList = surahsJson.map((json) => Datum.fromJson(json)).toList();
            isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load surah');
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: warmBackground, body: _buildSurahBody());
  }

  Widget _buildSurahBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: primaryGreen),
      );
    }
    if (errorMessage.isNotEmpty) {
      return Center(child: Text("Unable to fetched surah"));
    }
    return ListView.builder(
      itemCount: surahList.length,
      itemBuilder: (context, index) {
        final surah = surahList[index];
        return Container(
          margin: const .symmetric(vertical: 8),
          padding: const .symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: textColor,
            borderRadius: .circular(8),
            border: .all(color: accentGold.withOpacity(.5), width: 1),
            boxShadow: [
              BoxShadow(
                color: primaryGreen.withOpacity(.06),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),

          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurahDetailPage(
                        surahName: surah.name,
                        numberOfAyahs: surah.numberOfAyahs,
                        englishNameTranslation: surah.englishNameTranslation,
                        revelationType: surah.revelationType.name,
                        surahNumber: surah.number,
                      ),
                    ),
                  );
                },
                leading: Stack(
                  alignment: Alignment.center,
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        primaryGreen,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        "assets/images/quran/star_icon.png",
                        width: 50,
                        height: 50,
                        fit: .cover,
                      ),
                    ),
                    Text(
                      surah.number.toString(),
                      style: const TextStyle(
                        color: accentGold,
                        fontSize: 16,
                        fontWeight: .w600,
                      ),
                    ),
                  ],
                ),
                title: Text(
                  surah.englishName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: .w600,
                    color: arabicText,
                  ),
                ),
                subtitle: Text(
                  surah.revelationType.name,
                  style: TextStyle(
                    fontSize: 13,
                    // fontWeight: .w500,
                    color: translationText,
                  ),
                ),
                trailing: Text(
                  surah.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: .bold,
                    color: primaryGreen,
                  ),
                ),
              ),
              Align(
                alignment: .bottomRight,
                child: Padding(
                  padding: const .only(right: 10),
                  child: Text(
                    "${surah.numberOfAyahs} Ayahs",
                    style: TextStyle(
                      fontSize: 14,
                      color: accentGold,
                      fontWeight: .w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
