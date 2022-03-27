import 'dart:async';
// import 'dart:io';

// import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/about/about_cubit.dart';
import 'package:pikunikku/cubit/article/article_cubit.dart';
import 'package:pikunikku/cubit/booking/booking_cubit.dart';
import 'package:pikunikku/cubit/main/main_cubit.dart';
import 'package:pikunikku/cubit/tour/tour_cubit.dart';
import 'package:pikunikku/cubit/user/user_cubit.dart';
import 'package:pikunikku/pages/articles/screen/article_page.dart';
import 'package:pikunikku/pages/home/screens/home_page.dart';
import 'package:pikunikku/pages/main/widgets/bottom_nav_bar.dart';
import 'package:pikunikku/pages/profile/screen/profile_page.dart';

import '../../explore/screens/explore_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool close = false;

  // bool connected = false;
  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  dispose() {
    close = true;
    super.dispose();
  }

  initState() {
    context.read<TourCubit>().getAllTour(context);
    context.read<ArticleCubit>().getListArticle(context);
    context.read<AboutCubit>().getTestimoni(context);
    Timer.periodic(Duration(seconds: 5), (timer) async {
      if (close == true) timer.cancel();
      if (mounted) {
        context.read<UserCubit>().updateuser(context);
        context.read<BookingCubit>().listBookData(context);
      }
    });
    super.initState();
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Apakah anda yakin ?'),
            content: new Text('Ingin keluar dari aplikasi'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: new Text('Tidak',
                    style: TextStyle(color: Color(0xff00adef))),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child:
                    new Text('Ya', style: TextStyle(color: Color(0xff00adef))),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) => WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          bottomNavigationBar: BottomNavBar(),
          body: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(
                Duration(seconds: 1),
                () {
                  context.read<TourCubit>().getAllTour(context);
                  context.read<ArticleCubit>().getListArticle(context);
                  context.read<UserCubit>().updateuser(context);
                },
              );
            },
            child: IndexedStack(
              index: state.selectedMenu,
              children: [
                HomePage(),
                ExplorePage(),
                ArticlePage(),
                ProfilePage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
