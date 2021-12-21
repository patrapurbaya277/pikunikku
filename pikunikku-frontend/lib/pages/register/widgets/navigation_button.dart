

import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final bool? enabled;
  final Function()? onPressed;
  final String? type;
  const NavigationButton({Key? key, this.onPressed, this.type, this.enabled})
      : super(key: key);

  static String before = "before";
  static String next = "next";
  static String finish = "finish";

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: type==NavigationButton.finish?Text("Buat Akun", style: TextStyle(color: Colors.white)):Row(
        children: [
          type == NavigationButton.before
              ? Icon(Icons.arrow_back, color: Colors.white, size: 15)
              : Text("Selanjutnya", style: TextStyle(color: Colors.white)),
          SizedBox(
            width: 10,
          ),
          type == NavigationButton.before
              ? Text("Sebelumnya", style: TextStyle(color: Colors.white))
              : Icon(Icons.arrow_forward, color: Colors.white, size: 15),
        ],
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
        enabled == true
            ? Color(0xff00ADEF)
            : Color(0xff00ADEF).withOpacity(0.5),
      )),
      onPressed: onPressed,
    );
  }
}
