import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'quran_theme_event.dart';
part 'quran_theme_state.dart';

String _defaultTranslationFontForMode(String mode) {
  switch (mode) {
    case 'Urdu':
      return 'Jameel';
    case 'English (Saheeh)':
    case 'English (Clear Quran)':
      return 'Poppins';
    case 'Turkish (Saheeh)':
    case 'Persian (Hussein Dari)':
    case 'Russian (Kuliev)':
      return 'Roboto';
    case 'Malayalam (Abdul Hameed)':
    case 'Bengali':
    case 'Indonesian':
      return 'Noto Sans';
    case 'French (Hamidullah)':
    case 'Italian (Piccardo)':
    case 'Portuguese':
    case 'Spanish':
      return 'Lato';
    case 'Dutch (Siregar)':
    case 'Chinese':
    case 'Swedish':
      return 'Montserrat';
    default:
      return 'Poppins';
  }
}

class QuranThemeBloc extends HydratedBloc<QuranThemeEvent, QuranThemeState> {
  QuranThemeBloc()
      : super(
          QuranThemeState(
            quranType: 'Normal',
            showTranslation: true,
            translationMode: 'English (Clear Quran)',
            withArabs: true,
            quranFontSize: 24,
            quranFontFamily: 'Uthman',
            translationFontSize: 16,
            translationFontFamily: 'Poppins',
            qcfScrollDirection: 'Vertical',
          ),
        ) {
    on<QuranThemeEvent>((event, emit) async {
      if (event is SetQuranType) {
        emit(QuranThemeState(
          quranType: event.type,
          showTranslation: state.showTranslation,
          translationMode: state.translationMode,
          withArabs: state.withArabs,
          quranFontSize: state.quranFontSize,
          quranFontFamily: event.type == 'QCF' ? 'qcf' : 'Uthman',
          translationFontSize: state.translationFontSize,
          translationFontFamily: state.translationFontFamily,
          qcfScrollDirection: state.qcfScrollDirection,
        ));
      }
      if (event is ShowTranslation) {
        emit(QuranThemeState(
          quranType: state.quranType,
          showTranslation: event.show,
          translationMode: state.translationMode,
          withArabs: state.withArabs,
          quranFontSize: state.quranFontSize,
          quranFontFamily: state.quranFontFamily,
          translationFontSize: state.translationFontSize,
          translationFontFamily: state.translationFontFamily,
          qcfScrollDirection: state.qcfScrollDirection,
        ));
      }
      if (event is SwitchTranslationMode) {
        emit(QuranThemeState(
          quranType: state.quranType,
          showTranslation: state.showTranslation,
          translationMode: event.mode,
          withArabs: state.withArabs,
          quranFontSize: state.quranFontSize,
          quranFontFamily: state.quranFontFamily,
          translationFontSize: state.translationFontSize,
          translationFontFamily: _defaultTranslationFontForMode(event.mode),
          qcfScrollDirection: state.qcfScrollDirection,
        ));
      }
      if (event is ShowWithArab) {
        emit(QuranThemeState(
          quranType: state.quranType,
          showTranslation: state.showTranslation,
          translationMode: state.translationMode,
          withArabs: event.show,
          quranFontSize: state.quranFontSize,
          quranFontFamily: state.quranFontFamily,
          translationFontSize: state.translationFontSize,
          translationFontFamily: state.translationFontFamily,
          qcfScrollDirection: state.qcfScrollDirection,
        ));
      }
      if (event is AddQuranFontSize) {
        emit(QuranThemeState(
          quranType: state.quranType,
          showTranslation: state.showTranslation,
          translationMode: state.translationMode,
          withArabs: state.withArabs,
          quranFontSize: state.quranFontSize + 1,
          quranFontFamily: state.quranFontFamily,
          translationFontSize: state.translationFontSize,
          translationFontFamily: state.translationFontFamily,
          qcfScrollDirection: state.qcfScrollDirection,
        ));
      }
      if (event is ReduceQuranFontSize) {
        emit(QuranThemeState(
          quranType: state.quranType,
          showTranslation: state.showTranslation,
          translationMode: state.translationMode,
          withArabs: state.withArabs,
          quranFontSize: state.quranFontSize - 1,
          quranFontFamily: state.quranFontFamily,
          translationFontSize: state.translationFontSize,
          translationFontFamily: state.translationFontFamily,
          qcfScrollDirection: state.qcfScrollDirection,
        ));
      }
      if (event is SetQuranFontFamily) {
        emit(QuranThemeState(
          quranType: state.quranType,
          showTranslation: state.showTranslation,
          translationMode: state.translationMode,
          withArabs: state.withArabs,
          quranFontSize: state.quranFontSize,
          quranFontFamily: event.family,
          translationFontSize: state.translationFontSize,
          translationFontFamily: state.translationFontFamily,
          qcfScrollDirection: state.qcfScrollDirection,
        ));
      }
      if (event is AddTranslationFontSize) {
        emit(QuranThemeState(
          quranType: state.quranType,
          showTranslation: state.showTranslation,
          translationMode: state.translationMode,
          withArabs: state.withArabs,
          quranFontSize: state.quranFontSize,
          quranFontFamily: state.quranFontFamily,
          translationFontSize: state.translationFontSize + 1,
          translationFontFamily: state.translationFontFamily,
          qcfScrollDirection: state.qcfScrollDirection,
        ));
      }
      if (event is ReduceTranslationFontSize) {
        emit(QuranThemeState(
          quranType: state.quranType,
          showTranslation: state.showTranslation,
          translationMode: state.translationMode,
          withArabs: state.withArabs,
          quranFontSize: state.quranFontSize,
          quranFontFamily: state.quranFontFamily,
          translationFontSize: state.translationFontSize - 1,
          translationFontFamily: state.translationFontFamily,
          qcfScrollDirection: state.qcfScrollDirection,
        ));
      }
      if (event is SetTranslationFontFamily) {
        final safeFontFamily = state.translationMode == 'Urdu'
            ? 'Jameel'
            : event.family;
        emit(QuranThemeState(
          quranType: state.quranType,
          showTranslation: state.showTranslation,
          translationMode: state.translationMode,
          withArabs: state.withArabs,
          quranFontSize: state.quranFontSize,
          quranFontFamily: state.quranFontFamily,
          translationFontSize: state.translationFontSize,
          translationFontFamily: safeFontFamily,
          qcfScrollDirection: state.qcfScrollDirection,
        ));
      }
      if (event is SetQcfScrollDirection) {
        emit(QuranThemeState(
          quranType: state.quranType,
          showTranslation: state.showTranslation,
          translationMode: state.translationMode,
          withArabs: state.withArabs,
          quranFontSize: state.quranFontSize,
          quranFontFamily: state.quranFontFamily,
          translationFontSize: state.translationFontSize,
          translationFontFamily: state.translationFontFamily,
          qcfScrollDirection: event.direction,
        ));
      }
    });
  }

  Stream<QuranThemeState> mapEventToState(
    QuranThemeEvent event,
  ) async* {}

  @override
  QuranThemeState? fromJson(Map<String, dynamic> json) {
    try {
      final mode = json['translationMode'].toString();
      final savedFamily = json['translationFontFamily'].toString();
      final safeFamily = mode == 'Urdu'
          ? 'Jameel'
          : (savedFamily.isEmpty
              ? _defaultTranslationFontForMode(mode)
              : savedFamily);

      return QuranThemeState(
        quranType: json['quranType']?.toString() ?? 'Normal',
        showTranslation: json['showTranslation'] as bool,
        translationMode: mode,
        withArabs: json['withArabs'] as bool,
        quranFontSize: json['quranFontSize'] as double,
        quranFontFamily: json['quranFontFamily'].toString(),
        translationFontSize: json['translationFontSize'] as double,
        translationFontFamily: safeFamily,
        qcfScrollDirection:
            json['qcfScrollDirection']?.toString() ?? 'Vertical',
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(QuranThemeState state) {
    try {
      return {
        'showTranslation': state.showTranslation,
        'quranType': state.quranType,
        'translationMode': state.translationMode,
        'withArabs': state.withArabs,
        'quranFontSize': state.quranFontSize,
        'quranFontFamily': state.quranFontFamily,
        'translationFontSize': state.translationFontSize,
        'translationFontFamily': state.translationFontFamily,
        'qcfScrollDirection': state.qcfScrollDirection,
      };
    } catch (e) {
      return null;
    }
  }
}
