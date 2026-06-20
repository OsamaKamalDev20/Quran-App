// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/quran_juz_model.dart';
import '../utils/colors.dart';
import 'quran_juz_detail_page.dart';

class QuranJuz extends StatefulWidget {
  const QuranJuz({super.key});

  @override
  State<QuranJuz> createState() => _QuranJuzState();
}

class _QuranJuzState extends State<QuranJuz> {
  List<Ayah> arabicJuz = [];
  List<Ayah> englishJuz = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchQuranJuz();
  }

  Future<void> fetchQuranJuz() async {
    try {
      final results = await Future.wait([
        http.get(
          Uri.parse('https://api.alquran.cloud/v1/juz/30/quran-uthmani'),
        ),
        http.get(Uri.parse('https://api.alquran.cloud/v1/juz/30/en.asad')),
      ]);

      for (var response in results) {
        if (response.statusCode != 200) {
          throw Exception('Failed to load Juz data');
        }
      }

      final arabicData = json.decode(results[0].body);
      final englishData = json.decode(results[1].body);

      setState(() {
        arabicJuz = (arabicData['data']['ayahs'] as List)
            .map((ayah) => Ayah.fromJson(ayah))
            .toList();

        englishJuz = (englishData['data']['ayahs'] as List)
            .map((ayah) => Ayah.fromJson(ayah))
            .toList();

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBackground,
      body: _buildQuranJuzBody(),
    );
  }

  Widget _buildQuranJuzBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: primaryGreen),
      );
    }
    if (errorMessage.isNotEmpty) {
      return Center(child: Text("Unable to fetched quran juz"));
    }

    return ListView.builder(
      itemCount: arabicJuz.length,
      itemBuilder: (context, index) {
        final arabic = arabicJuz[index];
        final english = englishJuz[index];

        return Container(
          margin: const .symmetric(vertical: 8),
          padding: const .symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: textColor,
            borderRadius: .circular(8),
            border: .all(color: primaryGreen.withOpacity(.5), width: 1),
            boxShadow: [
              BoxShadow(
                color: accentGold.withOpacity(.06),
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
                      builder: (_) => QuranJuzDetailPage(
                        arabicJuz: arabic,
                        englishJuz: english,
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
                      "${arabic.surah.number}",
                      style: const TextStyle(
                        color: accentGold,
                        fontSize: 14.5,
                        fontWeight: .w700,
                      ),
                    ),
                  ],
                ),

                title: Text(
                  arabic.text,
                  textAlign: .right,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: .w700,
                    color: arabicText,
                  ),
                ),

                subtitle: Text(
                  "${arabic.surah.name} (${arabic.surah.number})",
                  textAlign: .right,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: .w600,
                    color: accentGold,
                  ),
                ),
              ),
              Align(
                alignment: .bottomRight,
                child: Padding(
                  padding: const .only(right: 10),
                  child: Text(
                    "${english.numberInSurah} Ayah",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: .w600,
                      color: primaryGreen,
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
