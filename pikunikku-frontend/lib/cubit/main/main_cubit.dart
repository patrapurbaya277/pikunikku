// import 'dart:html';

// import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState());

  void init() => emit(MainState());

  void onMenuChanged(int selectedIndex) =>
      emit(state.copyWith(selectedMenu: selectedIndex));

  
}
