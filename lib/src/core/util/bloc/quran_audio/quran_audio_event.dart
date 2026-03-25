// ignore_for_file: unused_element

part of 'quran_audio_bloc.dart';

abstract class QuranAudioEvent extends Equatable {
  const QuranAudioEvent();
}

class PlayAyah extends QuranAudioEvent {
  final int ayatId;
  final int surahId;
  const PlayAyah({required this.ayatId, required this.surahId});

  @override
  List<Object> get props => [ayatId, surahId];
}

class ToggleAyahPlayPause extends QuranAudioEvent {
  final int ayatId;
  final int surahId;
  const ToggleAyahPlayPause({required this.ayatId, required this.surahId});

  @override
  List<Object> get props => [ayatId, surahId];
}

class PlaySurah extends QuranAudioEvent {
  final int surahId;
  final List<int> ayatIds;
  const PlaySurah({required this.surahId, required this.ayatIds});

  @override
  List<Object> get props => [surahId, ayatIds];
}

class TogglePlayPause extends QuranAudioEvent {
  const TogglePlayPause();
  @override
  List<Object> get props => [];
}

class StopAudio extends QuranAudioEvent {
  const StopAudio();
  @override
  List<Object> get props => [];
}

class ClearAudioError extends QuranAudioEvent {
  const ClearAudioError();
  @override
  List<Object> get props => [];
}

class _InternalTrackChanged extends QuranAudioEvent {
  final int currentAyatId;
  const _InternalTrackChanged(this.currentAyatId);

  @override
  List<Object> get props => [currentAyatId];
}

class _InternalPlayerStateChanged extends QuranAudioEvent {
  final QuranAudioStatus status;
  const _InternalPlayerStateChanged(this.status);

  @override
  List<Object> get props => [status];
}

class _InternalError extends QuranAudioEvent {
  final String message;
  const _InternalError(this.message);

  @override
  List<Object> get props => [message];
}

