import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/user/user_cubit.dart';
// import 'package:pikunikku/pages/home/screens/home_page.dart';

class SubmitButton extends StatelessWidget {
  final void Function()? onPressed;
  const SubmitButton(
      {Key? key, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, login) {
        return TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(
              Color(0xff00ADEF),
            ),
          ),
          onPressed: onPressed,
          child: Container(
            width: 100,
            height: 30,
            alignment: Alignment.center,
            child: Text(
              "Masuk",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }
    );
  }
}
