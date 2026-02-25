import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quran/quran.dart';

import '../../utils/sirat_card.dart';

class AyatCard extends StatelessWidget {
  AyatCard({super.key});
  final RandomVerse randomVerse = RandomVerse();
  @override
  Widget build(BuildContext context) {
    return SiratCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Quran Ayat of the Day',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).cardColor
                  : Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: [
                Text(
                  randomVerse.verse,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        // fontFamily: 'cairo',
                        // fontFamily: FontHelper.getQcfFont(1),
                        fontFamily: GoogleFonts.tajawal().fontFamily,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  randomVerse.translation,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Surah ${quran.getSurahName(randomVerse.surahNumber)} - Ayah ${randomVerse.verseNumber}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
