import 'package:flutter/material.dart';

import 'register_field.dart';

class AccountField extends StatelessWidget {
  const AccountField({Key? key}) : super(key: key);
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController cPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RegisterField(
        label: "Email :",
        controller: emailController,
      ),
      RegisterField(
        label: "Password :",
        controller: passwordController,
      ),
      RegisterField(
        label: "Confirm Password :",
        controller: cPasswordController,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Selanjutnya",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 15,
              ),
            ],
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xff00ADEF))),
          onPressed: () {},
        ),
      ),
    ]);
  }
}
