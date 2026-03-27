import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/error/failures.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  DownloadBloc() : super(DownloadInitial()) {
    on<DownloadDatabase>((event, emit) async {
      emit(DownloadFailed(LocalFailure(
        message: 'Database download is no longer required.',
        error: 0,
        extraInfo: 'Bundled database (assets/latest.db) is used instead.',
      )));
    });
  }
}
