// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/pages/home/screens/home_page.dart';
import 'package:pikunikku/pages/login/screen/login_page.dart';

import 'cubit/login/login_cubit.dart';
import 'cubit/user/user_cubit.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      routes: {
        HomePage.home: (context) => const HomePage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Pikunikku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<UserCubit>(
            create: (BuildContext context) => UserCubit(),
          ),
          BlocProvider<LoginCubit>(
            create: (BuildContext context) => LoginCubit(),
          ),
        ],
        child: LoginPage(),
      ),
    );
  }
}
