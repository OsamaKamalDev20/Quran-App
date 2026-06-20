// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../models/quran_sajda_model.dart';
import '../utils/colors.dart';

class QuranSajdaDetailPage extends StatelessWidget {
  final Ayah arabicSajda;
  final Ayah englishSajda;
  const QuranSajdaDetailPage({
    super.key,
    required this.arabicSajda,
    required this.englishSajda,
  });

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
          "14 Sajda - Detail",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: .bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const .only(right: 10),
            child: Icon(Icons.ios_share_rounded, size: 30, color: accentGold),
          ),
        ],
      ),
      body: _buildSurahSajdaDetailsBody(),
    );
  }

  Widget _buildSurahSajdaDetailsBody() {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // ── Header Card ──
          SliverToBoxAdapter(
            child: Column(
              spacing: 10,
              children: [
                SizedBox(height: 30),
                Align(
                  alignment: .center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          primaryGreen,
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(
                          "assets/images/quran/star_icon.png",
                          width: 180,
                          fit: .cover,
                        ),
                      ),
                      Text(
                        arabicSajda.surah.name,
                        style: const TextStyle(
                          color: accentGold,
                          fontSize: 18,
                          fontWeight: .w800,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: const .all(10),
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
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        "${arabicSajda.surah.englishName} • ${arabicSajda.surah.englishNameTranslation}",
                        style: const TextStyle(
                          color: accentGold,
                          fontSize: 17,
                          fontWeight: .w700,
                        ),
                      ),
                      Text(
                        "Ayah ${arabicSajda.numberInSurah} of ${arabicSajda.surah.numberOfAyahs} • ${arabicSajda.surah.revelationType.name}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: .w600,
                          color: primaryGreen,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        arabicSajda.text,
                        textAlign: .right,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: .w700,
                          color: arabicText,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        englishSajda.text,
                        textAlign: .justify,
                        style: TextStyle(fontSize: 15, color: translationText),
                      ),

                      const SizedBox(height: 20),
                      GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                        children: [
                          _buildManzilIndicatorCard(
                            title: "Juz",
                            value1: "${arabicSajda.juz}",
                          ),
                          _buildManzilIndicatorCard(
                            title: "Page",
                            value1: "${arabicSajda.page}",
                          ),
                          _buildManzilIndicatorCard(
                            title: "Ruku",
                            value1: "${arabicSajda.ruku}",
                          ),

                          _buildManzilIndicatorCard(
                            title: "Hizb Quarter",
                            value1: "${arabicSajda.hizbQuarter}",
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Align(
                        alignment: .bottomRight,
                        child: Padding(
                          padding: const .only(right: 10),
                          child: Text(
                            "Ayah ${arabicSajda.numberInSurah} of ${arabicSajda.surah.numberOfAyahs}",
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManzilIndicatorCard({
    required String title,
    required String value1,
    String? value2,
  }) {
    return Container(
      padding: const .symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: accentGold.withOpacity(.15),
        borderRadius: .circular(10),
      ),
      child: Column(
        mainAxisSize: .min,
        mainAxisAlignment: .center,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            textAlign: .center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: .w600,
              color: primaryGreen,
            ),
          ),

          Text(
            value1,
            textAlign: .center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
              fontWeight: .w700,
              color: accentGold,
            ),
          ),

          if (value2 != null) ...[
            Text(
              value2,
              textAlign: .center,
              style: TextStyle(
                fontWeight: .w600,
                fontSize: 15,
                color: arabicText,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
