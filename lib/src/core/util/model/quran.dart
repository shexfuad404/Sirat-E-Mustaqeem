import 'package:quran/quran.dart' as quran_package;

class Quran {
  final int ayatId;
  final int ayatNumber;
  final String arabicText;
  final String urduTranslation;
  final int ayatSajda;
  final int surahRuku;
  final int paraRuku;
  final int paraId;
  final int manzilNo;
  final int ayatVisible;
  final int surahId;
  final String withoutAerab;
  final int favorite;

  Quran({
    required this.ayatId,
    required this.ayatNumber,
    required this.arabicText,
    required this.urduTranslation,
    required this.ayatSajda,
    required this.surahRuku,
    required this.paraRuku,
    required this.paraId,
    required this.manzilNo,
    required this.ayatVisible,
    required this.surahId,
    required this.withoutAerab,
    required this.favorite,
  });

  static const Map<String, quran_package.Translation> translationByMode = {
    'English (Saheeh)': quran_package.Translation.enSaheeh,
    'English (Clear Quran)': quran_package.Translation.enClearQuran,
    'Turkish (Saheeh)': quran_package.Translation.trSaheeh,
    'Malayalam (Abdul Hameed)': quran_package.Translation.mlAbdulHameed,
    'Persian (Hussein Dari)': quran_package.Translation.faHusseinDari,
    'French (Hamidullah)': quran_package.Translation.frHamidullah,
    'Italian (Piccardo)': quran_package.Translation.itPiccardo,
    'Dutch (Siregar)': quran_package.Translation.nlSiregar,
    'Portuguese': quran_package.Translation.portuguese,
    'Russian (Kuliev)': quran_package.Translation.ruKuliev,
    'Urdu': quran_package.Translation.urdu,
    'Bengali': quran_package.Translation.bengali,
    'Indonesian': quran_package.Translation.indonesian,
    'Chinese': quran_package.Translation.chinese,
    'Spanish': quran_package.Translation.spanish,
    'Swedish': quran_package.Translation.swedish,
  };

  String getTranslationText(
    String translationMode, {
    int? verseNumberOverride,
  }) {
    final effectiveVerseNumber = verseNumberOverride ?? ayatNumber;
    final effectiveTranslation =
        translationByMode[translationMode] ?? quran_package.Translation.urdu;

    try {
      return quran_package.getVerseTranslation(
        surahId,
        effectiveVerseNumber,
        translation: effectiveTranslation,
      );
    } catch (_) {
      return urduTranslation;
    }
  }

  String getVerseText({
    int? verseNumberOverride,
  }) {
    final effectiveVerseNumber = verseNumberOverride ?? ayatNumber;
    return quran_package.getVerse(surahId, effectiveVerseNumber,
        verseEndSymbol: true);
  }

  int getVerseCount({
    int? surahNumber,
  }) {
    return quran_package.getVerseCount(surahId);
  }
}

class Qurans {
  final List<Quran> _qurans = [];

  void initializeData(List<Map<String, Object?>> datas) {
    for (final Map<String, Object?> data in datas) {
      _qurans.add(
        Quran(
          ayatId: data['ayatId'] as int,
          ayatNumber: data['ayatNumber'] as int,
          arabicText: data['arabicText'].toString(),
          urduTranslation: data['urduTranslation'].toString(),
          ayatSajda: data['ayatSajda'] as int,
          surahRuku: data['surahRuku'] as int,
          paraRuku: data['paraRuku'] as int,
          paraId: data['paraId'] as int,
          manzilNo: data['manzilNo'] as int,
          ayatVisible: data['ayatVisible'] as int,
          surahId: data['surahId'] as int,
          withoutAerab: data['withoutAerab'].toString(),
          favorite: int.tryParse(data['favourite'].toString()) ?? 0,
        ),
      );
    }
  }

  List<Quran> getQuransBySurah(int surahId) {
    return _qurans.where((Quran quran) => quran.surahId == surahId).toList();
  }

  List<Quran> getQuransByJuz(int id) {
    return _qurans.where((Quran quran) => quran.paraId == id).toList();
  }

  List<Quran> get getFavoritesQuran =>
      _qurans.where((Quran quran) => quran.favorite == 1).toList();

  List<Quran> get qurans => _qurans;
}
