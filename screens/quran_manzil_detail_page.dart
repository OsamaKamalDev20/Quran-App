// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_ui/Quran%20App/utils/colors.dart';

import '../models/quran_manzil_model.dart';

class QuranManzilDetailPage extends StatelessWidget {
  final Ayah arabicManzil;
  final Ayah englishManzil;
  const QuranManzilDetailPage({
    super.key,
    required this.arabicManzil,
    required this.englishManzil,
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
          "Juz 7 - Detail",
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
      body: _buildSurahManzilDetailsBody(),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const .all(15),
          child: Row(
            spacing: 10,
            mainAxisAlignment: .spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(color: accentGold, shape: .circle),
                  child: IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.bookmark_rounded,
                      size: 24,
                      color: textColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: ElevatedButton.icon(
                  onPressed: () {},
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSurahManzilDetailsBody() {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // ── Header Card ──
          SliverToBoxAdapter(
            child: Column(
              children: [
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
                  child: Row(
                    mainAxisAlignment: .spaceAround,
                    spacing: 10,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              primaryGreen,
                              BlendMode.srcIn,
                            ),
                            child: Image.asset(
                              "assets/images/quran/star_icon.png",
                              width: 100,
                              height: 100,
                              fit: .cover,
                            ),
                          ),
                          Text(
                            arabicManzil.surah.number.toString(),
                            style: const TextStyle(
                              color: accentGold,
                              fontSize: 34,
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
                            arabicManzil.surah.name,
                            style: const TextStyle(
                              color: accentGold,
                              fontSize: 34,
                              fontWeight: .w700,
                            ),
                          ),
                          Text(
                            arabicManzil.surah.englishName,
                            style: const TextStyle(
                              color: primaryGreen,
                              fontSize: 20,
                              fontWeight: .w600,
                            ),
                          ),
                          Text(
                            arabicManzil.surah.englishNameTranslation,
                            style: const TextStyle(
                              color: arabicText,
                              fontSize: 16,
                              fontWeight: .w500,
                            ),
                          ),
                          Text(
                            "${arabicManzil.surah.revelationType.name} • ${arabicManzil.surah.numberOfAyahs} Ayahs",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: .w500,
                              color: accentGold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: const .all(10),
                  // padding: const .symmetric(horizontal: 15, vertical: 10),
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
                  child: ListTile(
                    title: Text(
                      "Translation (English)",
                      style: TextStyle(
                        fontWeight: .w600,
                        color: primaryGreen,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      arabicManzil.surah.englishNameTranslation,
                      // textAlign: .justify,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: .normal,
                        color: translationText,
                      ),
                    ),
                    trailing: Icon(
                      Icons.bookmark_border_rounded,
                      size: 30,
                      color: accentGold,
                    ),
                  ),
                ),

                Container(
                  margin: const .all(10),
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
                  child: Column(
                    crossAxisAlignment: .center,
                    mainAxisAlignment: .center,
                    children: [
                      Align(
                        alignment: .topCenter,
                        child: Text(
                          arabicManzil.text,
                          textAlign: .center,
                          style: const TextStyle(
                            color: accentGold,
                            fontSize: 34,
                            fontWeight: .w700,
                          ),
                        ),
                      ),
                      Divider(
                        radius: .circular(10),
                        thickness: 1.5,
                        color: primaryGreen,
                      ),
                      const SizedBox(height: 10),
                      GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.55,
                        children: [
                          _buildManzilIndicatorCard(
                            title: "Surah",
                            value1: arabicManzil.surah.englishName,
                            value2: "(${arabicManzil.surah.number})",
                          ),
                          _buildManzilIndicatorCard(
                            title: "Ayah",
                            value1: "${arabicManzil.numberInSurah}",
                            value2: "of ${arabicManzil.surah.numberOfAyahs}",
                          ),
                          _buildManzilIndicatorCard(
                            title: "Juz",
                            value1: "${arabicManzil.juz}",
                          ),
                          _buildManzilIndicatorCard(
                            title: "Page",
                            value1: "${arabicManzil.page}",
                          ),
                          _buildManzilIndicatorCard(
                            title: "Ruku",
                            value1: "${arabicManzil.ruku}",
                          ),
                          _buildManzilIndicatorCard(
                            title: "Hizb Quarter",
                            value1: "${arabicManzil.hizbQuarter}",
                          ),
                          _buildManzilIndicatorCard(
                            title: "Sajda",
                            value1: arabicManzil.sajda == false ? "No" : "Yes",
                          ),
                        ],
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
