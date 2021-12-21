import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/main/main_cubit.dart';
import 'package:pikunikku/cubit/tour/tour_cubit.dart';
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
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Apakah anda yakin ?'),
            content: new Text('Ingin keluar dari aplikasi'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Tidak',
                    style: TextStyle(color: Color(0xff00adef))),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child:
                    new Text('Ya', style: TextStyle(color: Color(0xff00adef))),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    context.read<TourCubit>().getAllData();
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) => WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          bottomNavigationBar: BottomNavBar(),
          body: IndexedStack(
            index: state.selectedMenu,
            children: [
              HomePage(),
              ExplorePage(),
              ProfilePage(),
            ],
          ),
        ),
      ),
    );
  }
}
