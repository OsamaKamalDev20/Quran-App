// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ui/Quran%20App/screens/quran_sajda_detail_page.dart';
import 'package:flutter_ui/Quran%20App/utils/colors.dart';
import 'package:http/http.dart' as http;

import '../models/quran_sajda_model.dart';

class QuranSajda extends StatefulWidget {
  const QuranSajda({super.key});

  @override
  State<QuranSajda> createState() => _QuranSajdaState();
}

class _QuranSajdaState extends State<QuranSajda> {
  List<Ayah> arabicSajda = [];
  List<Ayah> englishSajda = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchQuranSajda();
  }

  Future<void> fetchQuranSajda() async {
    try {
      final results = await Future.wait([
        http.get(Uri.parse('https://api.alquran.cloud/v1/sajda/quran-uthmani')),
        http.get(Uri.parse('https://api.alquran.cloud/v1/sajda/en.asad')),
      ]);

      for (var response in results) {
        if (response.statusCode != 200) {
          throw Exception('Failed to load Sajda data');
        }
      }

      final arabicData = json.decode(results[0].body);
      final englishData = json.decode(results[1].body);

      setState(() {
        arabicSajda = (arabicData['data']['ayahs'] as List)
            .map((ayah) => Ayah.fromJson(ayah))
            .toList();

        englishSajda = (englishData['data']['ayahs'] as List)
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
      body: _buildQuranSajdaBody(),
    );
  }

  Widget _buildQuranSajdaBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: primaryGreen),
      );
    }
    if (errorMessage.isNotEmpty) {
      return Center(child: Text("Unable to fetched quran sajda"));
    }
    return ListView.builder(
      itemCount: arabicSajda.length,
      itemBuilder: (context, index) {
        final arabic = arabicSajda[index];
        final english = englishSajda[index];

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
                      builder: (_) => QuranSajdaDetailPage(
                        arabicSajda: arabic,
                        englishSajda: english,
                      ),
                    ),
                  );
                },

                leading: Stack(
                  alignment: Alignment.center,
                  children: [
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        accentGold,
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
                        color: primaryGreen,
                        fontSize: 14.5,
                        fontWeight: .w700,
                      ),
                    ),
                  ],
                ),

                title: Text(
                  arabic.surah.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: .w700,
                    color: arabicText,
                  ),
                ),

                subtitle: Text(
                  arabic.surah.englishNameTranslation,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: .w500,
                    color: translationText,
                  ),
                ),
              ),

              Align(
                alignment: .bottomRight,
                child: Padding(
                  padding: const .only(right: 10),
                  child: Text(
                    "Ayah ${arabic.numberInSurah} of ${arabic.surah.numberOfAyahs}",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: .w600,
                      color: accentGold,
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
