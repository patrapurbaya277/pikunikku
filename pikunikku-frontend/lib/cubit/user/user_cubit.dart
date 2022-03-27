import 'dart:convert';
// import 'dart:js';

// import 'package:flutter/cupertino.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/edit_profile/edit_cubit.dart';
import 'package:pikunikku/cubit/login/login_cubit.dart';
import 'package:pikunikku/cubit/main/main_cubit.dart';
import 'package:pikunikku/pages/login/screen/login_page.dart';
import 'package:pikunikku/sources/api/API.dart';
import 'package:pikunikku/sources/model/avoider.dart';
import 'package:pikunikku/sources/model/user.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';
// import 'package:pikunikku/sources/preferences/preference.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState());

  void init() {
    emit(UserState());
  }

  void updateuser(BuildContext context) async {
    Avoider avoider = Avoider();
    avoider.catchException(
        context: context,
        function: () async {
          http.Response response;
          response = await http.get(API.updateUser,
              headers: {"Authorization": "Bearer ${state.token}"});
          // print(response.body);
          // if(response.body){}
          if (response.body.toString().split("").toList()[0] == "{") {
            final jsonData = jsonDecode((response.body).toString());
            if (response.statusCode == 200) {
              if (jsonData["status"] == true) {
                print("sukses update user");
                User user = User.fromJson(jsonData["data"]);
                emit(state.copyWith(
                  user: user,
                ));
                // context.read<EditCubit>().update(user);
              }
            }
          }
        });
    // http.Response response;
    // try {
    //   response = await http.get(API.updateUser,
    //       headers: {"Authorization": "Bearer ${state.token}"});
    //   // print(response.body);
    //   // if(response.body){}
    //   if (response.body.toString().split("").toList()[0] == "{") {
    //     final jsonData = jsonDecode((response.body).toString());
    //     if (response.statusCode == 200) {
    //       if (jsonData["status"] == true) {
    //         print("sukses update user");
    //         User user = User.fromJson(jsonData["data"]);
    //         emit(state.copyWith(
    //           user: user,
    //         ));
    //         context.read<EditCubit>().update(user);
    //       }
    //     }
    //   }
    // } catch (e) {
    //   print("Error saat update user");
    //   print(e);
    // }
  }

  void login(String email, String password, BuildContext context) async {
    Avoider avoider = Avoider();
    avoider.catchException(
      context: context,
      functionBreak: () {
        emit(state.copyWith(
          status: false,
          loading: false,
        ));
      },
      function: () async {
        emit(state.copyWith(loading: true));
        http.Response response;
        response = await http
            .post(API.login, body: {'email': email, 'password': password});
        print(response.body);
        final jsonData = jsonDecode((response.body).toString());
        if (response.statusCode == 200) {
          if (jsonData["status"] == true) {
            // Preferences prefs = Preferences();
            // prefs.setAuthToken(jsonData["api_token"]);
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString("token", jsonData["api_token"]);

            User user = User.fromJson(jsonData["data"]);
            emit(state.copyWith(
                user: user,
                status: jsonData["status"],
                token: jsonData["api_token"],
                loading: false,
                authSuccess: true));
            context.read<EditCubit>().init(user);
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
      },
    );
    // emit(state.copyWith(loading: true));
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult != ConnectivityResult.none) {
    //   http.Response response;
    //   try {
    //     response = await http
    //         .post(API.login, body: {'email': email, 'password': password});
    //     print(response.body);
    //     final jsonData = jsonDecode((response.body).toString());
    //     if (response.statusCode == 200) {
    //       if (jsonData["status"] == true) {
    //         // Preferences prefs = Preferences();
    //         // prefs.setAuthToken(jsonData["api_token"]);
    //         SharedPreferences pref = await SharedPreferences.getInstance();
    //         pref.setString("token", jsonData["api_token"]);

    //         User user = User.fromJson(jsonData["data"]);
    //         emit(state.copyWith(
    //             user: user,
    //             status: jsonData["status"],
    //             token: jsonData["api_token"],
    //             loading: false,
    //             authSuccess: true));
    //         context.read<EditCubit>().init(user);
    //       } else {
    //         emit(state.copyWith(
    //           status: jsonData["status"],
    //           message: jsonData["msg"],
    //           loading: false,
    //         ));
    //       }
    //     } else {
    //       emit(state.copyWith(
    //         status: jsonData["status"],
    //         message: jsonData["msg"],
    //         loading: false,
    //       ));
    //     }
    //   } catch (e) {
    //     print("Error saat login");
    //   }
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text("Tidak ada koneksi internet")));
    //   emit(state.copyWith(
    //     status: false,
    //     loading: false,
    //   ));
    // }
  }

  // void setToken() {
  //   Preferences prefs = Preferences();
  //   Future<String> authToken = prefs.getAuthToken();
  //   authToken.then((data) {
  //     emit(state.copyWith(token: data.toString(), status: true));
  //   }, onError: (e) {
  //     print(e);
  //   });
  // }
  void checkTokenAvailability(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? _token = pref.getString("token");

    if (_token != null && _token != "") {
      emit(state.copyWith(token: _token));
      loginWithToken(_token, context);
    }
  }

  void loginWithToken(String token, BuildContext context) async {
    Avoider avoider = Avoider();
    avoider.catchException(
        context: context,
        functionBreak: () {
          emit(state.copyWith(
            status: false,
            loading: false,
          ));
        },
        function: () async {
          emit(state.copyWith(loading: true));
          http.Response response;
          response = await http
              .get(API.updateUser, headers: {"Authorization": "Bearer $token"});
          // print(response.body);
          // if(response.body){}
          if (response.body.toString().split("").toList()[0] == "{") {
            final jsonData = jsonDecode((response.body).toString());
            if (response.statusCode == 200) {
              if (jsonData["status"] == true) {
                print("sukses update user");
                User user = User.fromJson(jsonData["data"]);
                emit(state.copyWith(
                    token: token,
                    user: user,
                    status: true,
                    loading: false,
                    authSuccess: true));
                context.read<EditCubit>().init(user);
              }
            }
          }
        });
    // emit(state.copyWith(loading: true));
    // var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult != ConnectivityResult.none) {
    //   http.Response response;
    //   try {
    //     response = await http
    //         .get(API.updateUser, headers: {"Authorization": "Bearer $token"});
    //     // print(response.body);
    //     // if(response.body){}
    //     if (response.body.toString().split("").toList()[0] == "{") {
    //       final jsonData = jsonDecode((response.body).toString());
    //       if (response.statusCode == 200) {
    //         if (jsonData["status"] == true) {
    //           print("sukses update user");
    //           User user = User.fromJson(jsonData["data"]);
    //           emit(state.copyWith(
    //               token: token,
    //               user: user,
    //               status: true,
    //               loading: false,
    //               authSuccess: true));
    //           context.read<EditCubit>().init(user);
    //         }
    //       }
    //     }
    //   } catch (e) {
    //     print("Error saat mendapatkan user");
    //     print(e);
    //   }
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text("Tidak ada koneksi internet")));
    //   emit(state.copyWith(
    //     status: false,
    //     loading: false,
    //   ));
    // }
  }

  void logout(BuildContext context) async {
    context.read<MainCubit>().init();
    context.read<LoginCubit>().init();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false);
  }
}
