import 'dart:convert';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/login/login_cubit.dart';
import 'package:pikunikku/cubit/main/main_cubit.dart';
import 'package:pikunikku/pages/login/screen/login_page.dart';
import 'package:pikunikku/sources/api/API.dart';
import 'package:pikunikku/sources/model/user.dart';
import 'package:pikunikku/sources/preferences/preference.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());

  void init() {
    emit(UserState());
  }

  void login(String email, String password) async {
    emit(state.copyWith(loading: true));
    http.Response response;
    try {
      response = await http
          .post(API.login, body: {'email': email, 'password': password});
      print(response.body);
      final jsonData = jsonDecode((response.body).toString());
      if (response.statusCode == 200) {
        if (jsonData["status"] == true) {
          Preferences prefs = Preferences();
          prefs.setAuthToken(jsonData["api_token"]);

          User user = User.fromJson(jsonData["data"]);
          emit(state.copyWith(
              user: user,
              status: jsonData["status"],
              token: jsonData["api_token"],
              loading: false,
              authSuccess: true));
        } else {
          emit(state.copyWith(
            status: jsonData["status"],
            message: jsonData["msg"],
            loading: false,
          ));
        }
      } else {
        emit(state.copyWith(
          status: jsonData["status"],
          message: jsonData["msg"],
          loading: false,
        ));
      }
    } catch (e) {
      print("Error saat login");
    }
  }

  void setToken() {
    Preferences prefs = Preferences();
    Future<String> authToken = prefs.getAuthToken();
    authToken.then((data) {
      emit(state.copyWith(token: data.toString(), status: true));
    }, onError: (e) {
      print(e);
    });
  }

  void logout(BuildContext context) {
    context.read<MainCubit>().init();
    context.read<LoginCubit>().init();
    Preferences prefs = Preferences();
    prefs.reset();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);
  }
}
