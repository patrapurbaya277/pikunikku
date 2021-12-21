
import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());
  
  void init() => emit(LoginState());

  void onEmailChanged(String value) => emit(state.copyWith(email: value));

  void onPasswordChanged(String value) => emit(state.copyWith(password: value));

  void showHidePassword(){
    if(state.visiblePassword==true)emit(state.copyWith(visiblePassword: false));
    else if(state.visiblePassword==false)emit(state.copyWith(visiblePassword: true));
    
  }
}