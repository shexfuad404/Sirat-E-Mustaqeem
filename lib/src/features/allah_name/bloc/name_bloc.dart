import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:muslim_data_flutter/muslim_data_flutter.dart';

part 'name_event.dart';
part 'name_state.dart';

class NameBloc extends Bloc<NameEvent, NameState> {
  NameBloc(NameOfAllah name) : super(NameState(name));
}
