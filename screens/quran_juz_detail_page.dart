// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_ui/Quran%20App/models/quran_juz_model.dart';
import 'package:flutter_ui/Quran%20App/utils/colors.dart';

class QuranJuzDetailPage extends StatelessWidget {
  final Ayah arabicJuz;
  final Ayah englishJuz;

  const QuranJuzDetailPage({
    super.key,
    required this.arabicJuz,
    required this.englishJuz,
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
          "Juz 30 - Detail",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: .bold,
            color: textColor,
          ),
        ),
        centerTitle: true,
        actions: [Icon(Icons.more_vert, size: 30, color: accentGold)],
      ),
      body: _buildSurahJuzDetailsBody(),
    );
  }

  Widget _buildSurahJuzDetailsBody() {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // ── Header Card ──
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: const .all(15),
                  padding: const .symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: textColor,
                    borderRadius: .circular(10),
                    border: .all(
                      color: primaryGreen.withOpacity(0.5),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: accentGold.withOpacity(0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: .spaceAround,
                    spacing: 10,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              accentGold,
                              BlendMode.srcIn,
                            ),
                            child: Image.asset(
                              "assets/images/quran/star_icon.png",
                              width: 80,
                              height: 80,
                              fit: .cover,
                            ),
                          ),
                          Text(
                            englishJuz.surah.number.toString(),
                            style: const TextStyle(
                              color: primaryGreen,
                              fontSize: 26,
                              fontWeight: .w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: .center,
                        mainAxisAlignment: .center,
                        children: [
                          Text(
                            englishJuz.surah.name,
                            style: const TextStyle(
                              color: primaryGreen,
                              fontSize: 34,
                              fontWeight: .w700,
                            ),
                          ),
                          Text(
                            "${arabicJuz.surah.englishName} (${arabicJuz.surah.number})",
                            style: const TextStyle(
                              color: accentGold,
                              fontSize: 20,
                              fontWeight: .w600,
                            ),
                          ),
                          Text(
                            arabicJuz.surah.englishNameTranslation,
                            style: const TextStyle(
                              color: arabicText,
                              fontSize: 16,
                              fontWeight: .w500,
                            ),
                          ),
                          Text(
                            "${arabicJuz.surah.revelationType.name} • ${arabicJuz.surah.numberOfAyahs} Ayahs",
                            style: const TextStyle(
                              fontSize: 14,
                              color: primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ],
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
                      Align(
                        alignment: .topCenter,
                        child: Text(
                          arabicJuz.text,
                          textAlign: .center,
                          style: const TextStyle(
                            color: primaryGreen,
                            fontSize: 34,
                            fontWeight: .w700,
                          ),
                        ),
                      ),
                      Divider(
                        radius: .circular(10),
                        thickness: 1.5,
                        color: accentGold,
                      ),
                      Align(
                        alignment: .topCenter,
                        child: Text(
                          englishJuz.text,
                          textAlign: .center,
                          style: const TextStyle(
                            color: arabicText,
                            fontSize: 20,
                            // fontWeight: .w500,
                          ),
                        ),
                      ),
                      Divider(
                        radius: .circular(10),
                        thickness: .5,
                        color: accentGold,
                      ),
                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            padding: const .all(10),
                            decoration: BoxDecoration(
                              color: accentGold,
                              shape: .circle,
                            ),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              size: 30,
                              color: textColor,
                            ),
                          ),
                          Row(
                            spacing: 6,
                            children: [
                              Icon(
                                Icons.bookmark_outline_rounded,
                                size: 30,
                                color: primaryGreen.withOpacity(.4),
                              ),
                              Icon(
                                Icons.share_rounded,
                                size: 30,
                                color: primaryGreen.withOpacity(.4),
                              ),
                              Icon(
                                Icons.copy_rounded,
                                size: 30,
                                color: primaryGreen.withOpacity(.4),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
                  child: GridView.count(
                    crossAxisCount: 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 0.55,
                    children: [
                      _buildJuzIndicatorCard(
                        title: "Ayah",
                        icon: FlutterIslamicIcons.quran,
                        value: arabicJuz.numberInSurah.toString(),
                      ),
                      _buildJuzIndicatorCard(
                        title: "Surah",
                        icon: FlutterIslamicIcons.quran2,
                        value: arabicJuz.surah.number.toString(),
                      ),
                      _buildJuzIndicatorCard(
                        title: "Juz",
                        icon: FlutterIslamicIcons.solidQuran,
                        value: arabicJuz.juz.toString(),
                      ),
                      _buildJuzIndicatorCard(
                        title: "Page",
                        icon: FlutterIslamicIcons.solidQuran2,
                        value: arabicJuz.page.toString(),
                      ),
                      _buildJuzIndicatorCard(
                        title: "Ruku",
                        icon: FlutterIslamicIcons.quran2,
                        value: arabicJuz.ruku.toString(),
                      ),
                      _buildJuzIndicatorCard(
                        title: "Manzil",
                        icon: FlutterIslamicIcons.quran,
                        value: arabicJuz.manzil.toString(),
                      ),
                      _buildJuzIndicatorCard(
                        title: "Hizb Quarter",
                        icon: FlutterIslamicIcons.solidQuran2,
                        value: arabicJuz.hizbQuarter.toString(),
                      ),
                      _buildJuzIndicatorCard(
                        title: "Sajda",
                        icon: FlutterIslamicIcons.sajadah,
                        value: arabicJuz.sajda == false ? "No" : "Yes",
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

  Widget _buildJuzIndicatorCard({
    required String title,
    required IconData icon,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: .center,
      mainAxisAlignment: .center,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(color: primaryGreen, shape: .circle),
          child: Icon(icon, size: 30, color: textColor),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 14,
            fontWeight: .w600,
            color: primaryGreen,
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 15, fontWeight: .w500, color: accentGold),
        ),
      ],
    );
  }
}
