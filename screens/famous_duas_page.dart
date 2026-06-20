// ignore_for_file: deprecated_member_use
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/Quran%20App/utils/colors.dart';
import 'package:flutter_ui/Quran%20App/models/famous_duas_model.dart';

class FamousDuasPage extends StatefulWidget {
  const FamousDuasPage({super.key});

  @override
  State<FamousDuasPage> createState() => _FamousDuasPageState();
}

class _FamousDuasPageState extends State<FamousDuasPage> {
  List<FamousDuas> duasList = [];

  @override
  void initState() {
    super.initState();
    loadDuas();
  }

  Future<void> loadDuas() async {
    final String response = await rootBundle.loadString(
      'assets/data/quran_data.json',
    );
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> list = data['famousDuas'];

    setState(() {
      duasList = list.map((e) => FamousDuas.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBackground,
      appBar: AppBar(
        iconTheme: IconThemeData(color: accentGold),
        backgroundColor: primaryGreen,
        centerTitle: true,
        title: const Text(
          "MASOOR DUAIN",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: accentGold,
          ),
        ),
      ),
      body: duasList.isEmpty
          ? const Center(child: CircularProgressIndicator(color: accentGold))
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: duasList.length,
              itemBuilder: (context, index) {
                final dua = duasList[index];
                return Container(
                  margin: const .symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: textColor,
                    borderRadius: .circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: primaryGreen.withOpacity(.06),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Padding(
                        padding: const .symmetric(horizontal: 12, vertical: 8),
                        child: Text(
                          dua.category,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: .w500,
                            color: primaryGreen,
                          ),
                        ),
                      ),

                      Container(
                        width: .infinity,
                        padding: const .symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: primaryGreen,
                          borderRadius: .vertical(top: .circular(6)),
                        ),
                        child: Row(
                          spacing: 10,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: accentGold,
                              child: Text(
                                dua.id,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: .w600,
                                  color: primaryGreen,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                dua.title,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: .w700,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const .symmetric(horizontal: 12, vertical: 8),
                        child: Column(
                          spacing: 6,
                          children: [
                            Align(
                              alignment: .centerRight,
                              child: Text(
                                dua.arabic,
                                textAlign: .right,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: .w700,
                                  color: arabicText,
                                  height: 2,
                                ),
                              ),
                            ),
                            Text(
                              dua.translation,
                              textAlign: .justify,
                              style: TextStyle(
                                fontSize: 14,
                                color: translationText,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
