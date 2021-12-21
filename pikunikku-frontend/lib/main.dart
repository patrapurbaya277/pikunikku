// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/pages/login/screen/login_page.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'cubit/login/login_cubit.dart';
import 'cubit/main/main_cubit.dart';
import 'cubit/paket/paket_cubit.dart';
import 'cubit/register/register_cubit.dart';
import 'cubit/tour/tour_cubit.dart';
import 'cubit/user/user_cubit.dart';

// void main() async {
//   runApp(MyApp());
// }
Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://ea98cd4a122d4b4abad8255ea881e013@o1095880.ingest.sentry.io/6115855';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(MyApp()),
  );

  // or define SENTRY_DSN via Dart environment variable (--dart-define)
}  

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (BuildContext context) => UserCubit(),
        ),
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider<MainCubit>(
          create: (BuildContext context) => MainCubit(),
        ),
        BlocProvider<RegisterCubit>(
          create: (BuildContext context) => RegisterCubit(),
        ),
        BlocProvider<TourCubit>(
          create: (BuildContext context) => TourCubit(),
        ),
        BlocProvider<PaketCubit>(
          create: (BuildContext context) => PaketCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pikunikku',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String capitalizeEachWord() {
    return "${this.toLowerCase().split(" ").map((e) => e.capitalize()).join(" ")}";
  }
}
