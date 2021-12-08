import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/sources/api/API.dart';
import 'package:pikunikku/sources/model/user.dart';
import 'package:pikunikku/sources/preferences/preference.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());

  void login(String email, String password) async {
    http.Response response;
    try {
      response = await http
          .post(API.login, body: {'email': email, 'password': password});
          print(response.body);
      final jsonData = jsonDecode((response.body).toString());
      if (response.statusCode == 200) {
        if(jsonData["status"]==true){
          User user = User.fromJson(jsonData["data"]);
        emit(state.copyWith(
            user: user,
            status: jsonData["status"],
            token: jsonData["api_token"], loading: true));
        Preferences prefs = Preferences();
        prefs.setAuthToken(jsonData["api_token"]);
        }else{
          emit(state.copyWith(
          status: jsonData["status"],
          message: jsonData["msg"],
        ));
        }
        
      } else {
        emit(state.copyWith(
          status: jsonData["status"],
          message: jsonData["msg"],
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
      emit(state.copyWith(token: data.toString(), status: true, loading: true));
    }, onError: (e) {
      print(e);
    });
  }

  void stopLoading(){
    emit(state.copyWith(loading: false));
  }

  void logout(){
    Preferences prefs = Preferences();
    prefs.reset();
  }
}
