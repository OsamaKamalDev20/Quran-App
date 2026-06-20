// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_ui/Quran%20App/screens/asma_ul_husna_page.dart';
import 'package:flutter_ui/Quran%20App/screens/asma_un_nabi_page.dart';
import 'package:flutter_ui/Quran%20App/screens/famous_duas_page.dart';
import 'package:flutter_ui/Quran%20App/screens/namaz_timings.dart';
import 'package:flutter_ui/Quran%20App/screens/quran_juz_page.dart';
import 'package:flutter_ui/Quran%20App/screens/quran_manzil_page.dart';
import 'package:flutter_ui/Quran%20App/screens/quran_sajda_page.dart';
import 'package:flutter_ui/Quran%20App/screens/surah_page.dart';
import 'package:flutter_ui/Quran%20App/utils/colors.dart';

class QuranHomePage extends StatefulWidget {
  const QuranHomePage({super.key});

  @override
  State<QuranHomePage> createState() => _QuranHomePageState();
}

class _QuranHomePageState extends State<QuranHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBackground,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: primaryGreen,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {},
          splashColor: Colors.transparent,
          icon: Icon(Icons.menu_rounded, size: 34, color: accentGold),
        ),
        title: Text(
          "Quran App",
          style: TextStyle(fontSize: 24, fontWeight: .bold, color: textColor),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            splashColor: Colors.transparent,
            icon: Icon(Icons.search_rounded, size: 34, color: accentGold),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: .vertical,
          padding: const .symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Align(
                alignment: .center,
                child: Text(
                  "بِسْمِ ٱللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: .w600,
                    color: accentGold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Osama Kamal",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: .bold,
                  color: primaryGreen,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: const .symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: textColor,
                  borderRadius: .circular(12),
                  border: .all(color: accentGold.withOpacity(.5), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: primaryGreen.withOpacity(.06),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1,
                  children: [
                    _buildHomeIndicatorCard(
                      title: "Prayer Time",
                      icon: FlutterIslamicIcons.solidMosque,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => NamazTimings()),
                        );
                      },
                    ),
                    _buildHomeIndicatorCard(
                      title: "Asmaa Ul Husna",
                      icon: FlutterIslamicIcons.solidAllah,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => AsmaUlHusnaPage()),
                        );
                      },
                    ),

                    _buildHomeIndicatorCard(
                      title: "Asmaa Un Nabi",
                      icon: FlutterIslamicIcons.solidMohammad,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => AsmaUnNabiPage()),
                        );
                      },
                    ),
                    _buildHomeIndicatorCard(
                      title: "Famous Dua's",
                      icon: FlutterIslamicIcons.solidQuran2,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => FamousDuasPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Four Tab bar shows here "Surah's", "Juz", "Manzil" and "Sajda's"
              const SizedBox(height: 20),
              DefaultTabController(
                length: 4,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: textColor,
                        borderRadius: .circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: primaryGreen.withOpacity(.06),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TabBar(
                        dividerColor: Colors.transparent,
                        labelColor: textColor,
                        isScrollable: false,
                        labelPadding: const .symmetric(horizontal: 6),
                        labelStyle: TextStyle(fontSize: 15, fontWeight: .w600),
                        unselectedLabelColor: accentGold,
                        unselectedLabelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: .w600,
                        ),
                        indicator: BoxDecoration(
                          color: primaryGreen,
                          borderRadius: .circular(6),
                          border: .all(width: 1, color: primaryGreen),
                        ),
                        indicatorSize: .tab,
                        tabs: [
                          Tab(text: "Surah"),
                          Tab(text: "Juz"),
                          Tab(text: "Manzil"),
                          Tab(text: "Sajda"),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 350,
                      child: TabBarView(
                        children: [
                          QuranSurah(),
                          QuranJuz(),
                          QuranManzil(),
                          QuranSajda(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeIndicatorCard({
    required String title,
    required IconData icon,
    required VoidCallback onPress,
  }) {
    return InkWell(
      onTap: onPress,
      borderRadius: .circular(12),
      child: Container(
        height: 120,
        padding: const .all(15),
        decoration: BoxDecoration(
          color: primaryGreen,
          borderRadius: .circular(12),
        ),
        child: Column(
          spacing: 10,
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Icon(icon, size: 50, color: accentGold),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: .w600,
                color: textColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
