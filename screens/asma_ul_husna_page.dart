// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_ui/Quran%20App/models/asma_ul_husna_model.dart';

import '../utils/colors.dart';

class AsmaUlHusnaPage extends StatefulWidget {
  const AsmaUlHusnaPage({super.key});

  @override
  State<AsmaUlHusnaPage> createState() => _AsmaUlHusnaPageState();
}

class _AsmaUlHusnaPageState extends State<AsmaUlHusnaPage> {
  List<AsmaUlHusnaModel> nameLists = [];

  @override
  void initState() {
    super.initState();
    asmaUlHusnaNames();
  }

  Future<void> asmaUlHusnaNames() async {
    final String response = await rootBundle.loadString(
      'assets/data/quran_data.json',
    );
    final Map<String, dynamic> data = json.decode(response);
    final List<dynamic> list = data['asmaUlHusna'];

    setState(() {
      nameLists = list.map((e) => AsmaUlHusnaModel.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        iconTheme: IconThemeData(color: accentGold),
        backgroundColor: primaryGreen,
        title: Column(
          spacing: 4,
          crossAxisAlignment: .start,
          children: [
            const Text(
              "ASMA UL HUSNA",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: accentGold,
              ),
            ),
            const Text(
              "99 Beautiful Names of ALLAH",
              style: TextStyle(fontSize: 15.5, color: textColor),
            ),
          ],
        ),
        actions: [
          Row(
            spacing: 6,
            children: [
              Icon(Icons.search_rounded, size: 28, color: accentGold),
              Icon(Icons.bookmark_border_rounded, size: 28, color: accentGold),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: nameLists.isEmpty
            ? Center(child: CircularProgressIndicator(color: accentGold))
            : Padding(
                padding: const .all(12),
                child: GridView.builder(
                  itemCount: nameLists.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final name = nameLists[index];
                    return _NameGridCard(name: name);
                  },
                ),
              ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _NameGridCard({required AsmaUlHusnaModel name}) {
    return GestureDetector(
      onTap: () => _showNameModal(context, name),
      child: Container(
        decoration: BoxDecoration(
          color: textColor,
          borderRadius: .circular(10),
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
          mainAxisAlignment: .center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(primaryGreen, BlendMode.srcIn),
                  child: Image.asset(
                    "assets/images/quran/star_icon.png",
                    width: 44,
                    height: 44,
                    fit: .cover,
                  ),
                ),
                Text(
                  name.id.toString(),
                  style: const TextStyle(
                    color: accentGold,
                    fontSize: 14,
                    fontWeight: .w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              name.arabic,
              maxLines: 2,
              textAlign: .center,
              style: const TextStyle(
                color: primaryGreen,
                fontSize: 24,
                fontWeight: .w700,
              ),
            ),
            Divider(
              thickness: 1,
              color: accentGold.withOpacity(.7),
              indent: 28,
              endIndent: 28,
            ),
          ],
        ),
      ),
    );
  }
}

void _showNameModal(BuildContext context, AsmaUlHusnaModel name) {
  showModalBottomSheet(
    context: context,
    backgroundColor: warmBackground,
    shape: RoundedRectangleBorder(borderRadius: .vertical(top: .circular(24))),
    builder: (BuildContext context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Padding(
          padding: const .all(15.0),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Align(
                alignment: .center,
                child: Container(
                  margin: const .only(top: 15),
                  width: 45,
                  height: 4,
                  decoration: BoxDecoration(
                    color: accentGold.withOpacity(0.4),
                    borderRadius: .circular(2),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    "About This Name",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: .bold,
                      color: primaryGreen,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      size: 35,
                      color: accentGold,
                    ),
                  ),
                ],
              ),

              Align(
                alignment: .center,
                child: Text(
                  name.arabic,
                  textAlign: .center,
                  style: const TextStyle(
                    color: primaryGreen,
                    fontSize: 44,
                    fontWeight: .w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: .center,
                child: Text(
                  name.transliteration,
                  textAlign: .center,
                  style: const TextStyle(
                    color: accentGold,
                    fontSize: 24,
                    fontWeight: .w600,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Align(
                alignment: .center,
                child: Text(
                  name.translation,
                  textAlign: .center,
                  style: const TextStyle(
                    color: primaryGreen,
                    fontSize: 20,
                    fontWeight: .w500,
                  ),
                ),
              ),

              Divider(thickness: 1.4, color: accentGold.withOpacity(.4)),

              ListTile(
                leading: Container(
                  padding: const .all(8),
                  decoration: BoxDecoration(
                    color: accentGold.withOpacity(.2),
                    shape: .circle,
                    border: .all(color: accentGold),
                  ),
                  child: Icon(
                    FlutterIslamicIcons.solidQuran2,
                    color: accentGold,
                    size: 30,
                  ),
                ),
                title: Text(
                  "Meaning",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: .w700,
                    color: primaryGreen,
                  ),
                ),
                subtitle: Text(
                  name.meaning,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: .w500,
                    color: translationText,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
