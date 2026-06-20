// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ui/Quran%20App/utils/colors.dart';
import 'package:http/http.dart' as http;

import '../models/surah_details_model.dart';

class SurahDetailPage extends StatefulWidget {
  final int surahNumber, numberOfAyahs;
  final String surahName, englishNameTranslation, revelationType;

  const SurahDetailPage({
    super.key,
    required this.surahName,
    required this.surahNumber,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  @override
  State<SurahDetailPage> createState() => _SurahDetailPageState();
}

class _SurahDetailPageState extends State<SurahDetailPage> {
  List<Ayah> arabicAyahs = [];
  List<Ayah> englishAyahs = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchBothQuran();
  }

  Future<void> fetchBothQuran() async {
    try {
      final results = await Future.wait([
        http.get(Uri.parse('https://api.alquran.cloud/v1/quran/quran-uthmani')),
        http.get(Uri.parse('https://api.alquran.cloud/v1/quran/en.asad')),
      ]);

      for (var response in results) {
        if (response.statusCode != 200) {
          throw Exception('Failed to load Quran data');
        }
      }

      final arabicData = json.decode(results[0].body);
      final englishData = json.decode(results[1].body);

      if (arabicData['code'] != 200 || englishData['code'] != 200) {
        throw Exception('API returned error status');
      }

      final arabicSurah = arabicData['data']['surahs'].firstWhere(
        (s) => s['number'] == widget.surahNumber,
      );
      final englishSurah = englishData['data']['surahs'].firstWhere(
        (s) => s['number'] == widget.surahNumber,
      );

      setState(() {
        arabicAyahs = (arabicSurah['ayahs'] as List)
            .map((ayah) => Ayah.fromJson(ayah))
            .toList();
        englishAyahs = (englishSurah['ayahs'] as List)
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
      appBar: AppBar(
        iconTheme: const IconThemeData(color: accentGold),
        toolbarHeight: 80,
        backgroundColor: primaryGreen,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          "${widget.surahNumber}: ${widget.surahName}",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: .bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildSurahDetailsBody(),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const .all(15.0),
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: primaryGreen,
                  content: Text("Start Reading ${widget.surahName}"),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: accentGold,
              foregroundColor: Colors.white,
              padding: const .symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: .circular(10)),
            ),
            icon: const Icon(Icons.menu_book_rounded, size: 20),
            label: const Text(
              "Read Now",
              style: TextStyle(fontSize: 20, fontWeight: .w600),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSurahDetailsBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: primaryGreen),
      );
    }
    if (errorMessage.isNotEmpty) {
      return Center(
        child: Text(
          "Unable to fetch surah",
          style: TextStyle(color: translationText),
        ),
      );
    }

    // ✅ Fix 2: CustomScrollView se Column + ListView ka layout issue fix hua
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // ── Header Card ──
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                // About the surah
                Container(
                  margin: const .all(15),
                  // padding: const .symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: textColor,
                    borderRadius: .circular(10),
                    border: .all(color: accentGold.withOpacity(0.5), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: primaryGreen.withOpacity(0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      "About Surah ${widget.surahName}",
                      style: TextStyle(
                        fontWeight: .w600,
                        color: primaryGreen,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      "Surah ${widget.surahName} (${widget.englishNameTranslation}) is the ${widget.surahNumber} chapter of the Holy Quran. It is ${widget.revelationType} surah and consists of ${widget.numberOfAyahs} ayahs.",
                      // textAlign: .justify,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: .normal,
                        color: translationText,
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: const .all(15),
                  padding: const .symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: textColor,
                    borderRadius: .circular(10),
                    border: .all(color: accentGold.withOpacity(0.5), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: primaryGreen.withOpacity(0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: .center,
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        widget.surahName,
                        style: const TextStyle(
                          fontSize: 30,
                          color: primaryGreen,
                          fontWeight: .w700,
                        ),
                      ),
                      Text(
                        widget.englishNameTranslation,
                        style: const TextStyle(
                          fontSize: 20,
                          color: accentGold,
                          fontWeight: FontWeight.w500, // ✅ Fix 3
                        ),
                      ),
                      const Divider(color: accentGold, thickness: 1),
                      Text(
                        "${widget.revelationType} • ${widget.numberOfAyahs} Ayahs",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: .w600,
                          color: primaryGreen,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "بِسْمِ ٱللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700, // ✅ Fix 3
                          color: accentGold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Ayah List ──
          SliverPadding(
            padding: const .symmetric(horizontal: 15, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final arabicAyah = arabicAyahs[index];
                final englishAyah = englishAyahs[index];

                return Container(
                  margin: const .symmetric(vertical: 8),
                  padding: const .symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: textColor,
                    borderRadius: .circular(8),
                    border: .all(color: accentGold.withOpacity(0.5), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: primaryGreen.withOpacity(0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: primaryGreen,
                              shape: .circle,
                              border: .all(width: 1.4, color: accentGold),
                            ),
                            child: Center(
                              child: Text(
                                arabicAyah.numberInSurah.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: .w600,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            spacing: 6,
                            children: [
                              Icon(Icons.share, size: 25, color: accentGold),
                              Icon(
                                Icons.play_arrow_outlined,
                                size: 25,
                                color: accentGold,
                              ),
                              Icon(
                                Icons.bookmark_outline,
                                size: 25,
                                color: accentGold,
                              ),
                            ],
                          ),
                        ],
                      ),

                      const Divider(color: accentGold, thickness: 1),
                      Align(
                        alignment: .centerRight,
                        child: Text(
                          arabicAyah.text,
                          textAlign: .right,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: .w600,
                            color: arabicText,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        englishAyah.text,
                        textAlign: .justify,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: translationText,
                        ),
                      ),
                    ],
                  ),
                );
              }, childCount: arabicAyahs.length),
            ),
          ),
        ],
      ),
    );
  }
}
