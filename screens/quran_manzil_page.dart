// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/quran_manzil_model.dart';
import '../utils/colors.dart';
import 'quran_manzil_detail_page.dart';

class QuranManzil extends StatefulWidget {
  const QuranManzil({super.key});

  @override
  State<QuranManzil> createState() => _QuranManzilState();
}

class _QuranManzilState extends State<QuranManzil> {
  List<Ayah> arabicManzil = [];
  List<Ayah> englishManzil = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchQuranManzil();
  }

  Future<void> fetchQuranManzil() async {
    try {
      final results = await Future.wait([
        http.get(
          Uri.parse('https://api.alquran.cloud/v1/manzil/7/quran-uthmani'),
        ),
        http.get(Uri.parse('https://api.alquran.cloud/v1/manzil/7/en.asad')),
      ]);

      for (var response in results) {
        if (response.statusCode != 200) {
          throw Exception('Failed to load Manzil data');
        }
      }

      final arabicData = json.decode(results[0].body);
      final englishData = json.decode(results[1].body);

      setState(() {
        arabicManzil = (arabicData['data']['ayahs'] as List)
            .map((ayah) => Ayah.fromJson(ayah))
            .toList();

        englishManzil = (englishData['data']['ayahs'] as List)
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
      body: _buildQuranManzilBody(),
    );
  }

  Widget _buildQuranManzilBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: primaryGreen),
      );
    }
    if (errorMessage.isNotEmpty) {
      return Center(child: Text("Unable to fetched quran juz"));
    }
    return ListView.builder(
      itemCount: arabicManzil.length,
      itemBuilder: (context, index) {
        final arabic = arabicManzil[index];
        final english = englishManzil[index];

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
                      builder: (_) => QuranManzilDetailPage(
                        arabicManzil: arabic,
                        englishManzil: english,
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
                  arabic.text,
                  textAlign: .right,
                  style: TextStyle(
                    fontSize: 18,
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
                    color: primaryGreen,
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
