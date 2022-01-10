

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/register/register_cubit.dart';
import 'package:pikunikku/pages/register/widgets/navigation_button.dart';

import 'register_field.dart';

class AccountField extends StatelessWidget {
  final FocusNode? emailFocus;
  final FocusNode? passwordFocus;
  final FocusNode? cPasswordFocus;
  const AccountField({Key? key, this.emailFocus, this.passwordFocus, this.cPasswordFocus}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) => Column(
        children: [
          RegisterField(
            inputAction: TextInputAction.next,
            // validator: (value)=> value!.isValidEmail()?null:"Masukkan email dengan benar",
            label: "Email :",
            value: state.email,
            inputType: TextInputType.emailAddress,
            onChanged: (value) =>
                context.read<RegisterCubit>().onEmailChanged(value),
            focusNode: emailFocus,
          ),
          RegisterField(
            inputAction: TextInputAction.next,
            label: "Password :",
            value: state.password,
            obscured: true,
            onChanged: (value) =>
                context.read<RegisterCubit>().onPasswordChanged(value),
            focusNode: passwordFocus,
          ),
          Text("Panjang minimal password adalah 6 karakter"),
          RegisterField(
            inputAction: TextInputAction.done,
            label: "Confirm Password :",
            value: state.confirmPassword,
            obscured: true,
            onChanged: (value) =>
                context.read<RegisterCubit>().onConfirmPasswordChanged(value),
            focusNode: cPasswordFocus,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NavigationButton(
                enabled: state.accountTrue,
                type: NavigationButton.next,
                onPressed: () {
                  if(state.accountTrue==true){
                    context.read<RegisterCubit>().nextProgress();
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}