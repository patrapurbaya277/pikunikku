import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? hint;
  // final LoginBloc2? bloc;
  final TextEditingController? controller;
  final bool isObscure;
  const LoginField(
      {Key? key, this.hint, this.controller, required this.isObscure, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        // height: 50,
        child: TextField(
          controller: controller,
          obscureText: isObscure,
          onChanged: onChanged,
          decoration: InputDecoration(
            // labelText: this.label,
            // errorText: snap.error.toString()??"",
            hintText: "$hint",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
