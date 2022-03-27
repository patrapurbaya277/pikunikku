import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/register/register_cubit.dart';
import 'package:pikunikku/pages/register/style.dart';

class RegisterField extends StatelessWidget {
  final Color? color;
  final bool? enabled;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final int? maxlines;
  final bool? obscured;
  final String? value;
  final ValueChanged<String>? onChanged;
  final String? label;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final bool? showField;
  final String? text;
  final FocusNode? focusNode;
  const RegisterField(
      {Key? key,
      this.color,
      this.enabled,
      this.label,
      this.controller,
      this.onChanged,
      this.value,
      this.obscured,
      this.maxlines,
      this.inputType,
      this.validator,
      this.inputAction,
      this.showField,
      this.text,
      this.focusNode})
      : super(key: key);

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
            style: color==null? RegisterStyle.label:TextStyle(color: color, fontSize: 21),
          ),
          SizedBox(height: 7),
          showField ?? true
              ? TextFormField(
                  // enabled: enabled??true,
                  focusNode: focusNode,
                  validator: validator ?? null,
                  textInputAction: inputAction,
                  keyboardType: inputType ?? TextInputType.text,
                  maxLines: maxlines ?? 1,
                  obscureText: obscured ?? false,
                  initialValue: value ?? "",
                  onChanged: onChanged,
                  readOnly: enabled ?? false,
                  decoration: InputDecoration(
                    focusedBorder: enabled == false
                        ? OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff00ADEF),
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10),
                          )
                        : OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10),
                          ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xff00ADEF), style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xff00ADEF), style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(text!),
                  ],
                ),
        ],
      ),
    );
  }
}

class CustomRegisterField extends StatelessWidget {
  final String? label;
  final String? value;
  final String? defaultValue;
  final Widget? buildContent;
  final bool? showButton;
  const CustomRegisterField({
    Key? key,
    this.defaultValue,
    this.value,
    this.label,
    this.buildContent,
    this.showButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label!,
            style: RegisterStyle.label,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 15),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                  value != ""
                      ? value ?? defaultValue.toString()
                      : defaultValue.toString(),
                  textAlign: TextAlign.start,
                )),
                Expanded(
                  child: showButton == true
                      ? ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff00ADEF))),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(defaultValue!),
                                    content: buildContent,
                                  );
                                });
                          },
                          child: Text(
                            defaultValue!,
                            textAlign: TextAlign.center,
                          ),
                        )
                      : SizedBox(),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}
