import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final String? value;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final ValueChanged<String>? onChanged;
  final String? hint;
  // final LoginBloc2? bloc;
  final bool? isObscure;
  const LoginField(
      {Key? key, this.hint, this.isObscure, this.onChanged, this.inputType, 
      this.suffixIcon, this.value
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        // height: 50,
        child: TextFormField(
          initialValue: value??"",
          keyboardType: inputType??TextInputType.text,
          obscureText: isObscure??false,
          onChanged: onChanged,
          decoration: InputDecoration(
            // labelText: this.label,
            // errorText: snap.error.toString()??"",
            suffixIcon: suffixIcon??SizedBox(),
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
