import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_ui/Quran%20App/utils/colors.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class NamazTimings extends StatefulWidget {
  const NamazTimings({super.key});

  @override
  State<NamazTimings> createState() => _NamazTimingsState();
}

class _NamazTimingsState extends State<NamazTimings> {
  final DateTime _now = DateTime.now();

  String get _englishDate => DateFormat('EEEE, d MMMM yyyy').format(_now);

  String get _islamicDate {
    final h = HijriCalendar.fromDate(_now);
    return '${h.hDay} ${h.longMonthName} ${h.hYear} H';
  }

  String _formatTime(int hour, int minute) {
    final dt = DateTime(_now.year, _now.month, _now.day, hour, minute);
    return DateFormat('hh:mm a').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryGreen,
        toolbarHeight: 170,
        centerTitle: true,
        title: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          children: [
            Icon(FlutterIslamicIcons.solidMosque, size: 60, color: accentGold),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("📍", style: TextStyle(fontSize: 16)),
                const SizedBox(width: 4),
                const Text(
                  "Karachi, Pakistan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: .bold,
                    color: accentGold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // ── Gregorian Date ──
            Text(
              _englishDate,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: .w700,
                color: textColor,
              ),
            ),

            const SizedBox(height: 6),
            Text(
              _islamicDate,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: .w500,
                color: accentGold,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Padding(
              padding: const .symmetric(horizontal: 15, vertical: 8),
              child: const Text(
                "AWQAT-E-SALAT",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: .bold,
                  color: primaryGreen,
                ),
              ),
            ),
            // ── 5 Namazain ──
            _namazTimings(
              title: "Fajr",
              subTitle: "Subah ki Namaz",
              value: _formatTime(05, 00),
            ),
            _divider(),
            _namazTimings(
              title: "Dhuhr",
              subTitle: "Dopahar ki Namaz",
              value: _formatTime(13, 05),
            ),
            _divider(),
            _namazTimings(
              title: "Asr",
              subTitle: "Sham se Pehle ki Namaz",
              value: _formatTime(17, 15),
            ),
            _divider(),
            _namazTimings(
              title: "Maghrib",
              subTitle: "Ghuroob ke Waqt ki Namaz",
              value: _formatTime(19, 20),
            ),
            _divider(),
            _namazTimings(
              title: "Isha",
              subTitle: "Raat ki Namaz",
              value: _formatTime(20, 49),
            ),
          ],
        ),
      ),
    );
  }

  // ── Namaz tile ──
  Widget _namazTimings({
    required String title,
    required String subTitle,
    required String value,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: .w700,
          color: accentGold,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: const TextStyle(fontSize: 14, color: primaryGreen),
      ),
      trailing: Text(
        value,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: arabicText,
        ),
      ),
    );
  }

  // ── Divider ──
  Widget _divider() => const Divider(
    height: 1,
    thickness: 0.5,
    indent: 16,
    endIndent: 16,
    color: Color(0xFFDDD5C0),
  );
}
