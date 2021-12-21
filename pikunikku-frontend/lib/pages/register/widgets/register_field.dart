import 'package:flutter/material.dart';
import 'package:pikunikku/pages/register/style.dart';

class RegisterField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final int? maxlines;
  final bool? obscured;
  final String? value;
  final ValueChanged<String>? onChanged;
  final String? label;
  final TextEditingController? controller;
  const RegisterField({Key? key, this.label, this.controller, this.onChanged, this.value, this.obscured, this.maxlines, this.inputType, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label",
            style: RegisterStyle.label,
          ),
          SizedBox(height: 7),
          TextFormField(
            validator: validator??null,
            keyboardType: inputType??TextInputType.text,
            maxLines: maxlines??1,
            obscureText: obscured??false,
            initialValue: value??"",
            onChanged: onChanged,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xff00ADEF),
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xff00ADEF),
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }
}


