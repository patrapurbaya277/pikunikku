import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/main/main_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit,MainState>(
      builder: (context,state) {
        return BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: "Explore"),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
          ],
          onTap: (value) => context.read<MainCubit>().onMenuChanged(value),
          currentIndex: state.selectedMenu,
          iconSize: 30,
          // type: BottomNavigationBarType.shifting,
          // selectedFontSize: 20,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 20,

          selectedIconTheme: IconThemeData(color: Color(0xff00adef)),
          unselectedIconTheme: IconThemeData(color: Colors.grey),
        );
      }
    );
  }
}
