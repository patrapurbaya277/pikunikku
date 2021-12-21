

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/register/register_cubit.dart';
import 'package:pikunikku/pages/register/widgets/navigation_button.dart';

import 'register_field.dart';

class AccountField extends StatelessWidget {
  const AccountField({Key? key}) : super(key: key);
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController cPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (BuildContext context, state) async {
        if (state.password == state.confirmPassword &&
            state.password.length > 5 && state.email!="") {
          context.read<RegisterCubit>().accountConfirmation(true);
        } else {
          context.read<RegisterCubit>().accountConfirmation(false);
        }
      },
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) => Column(
          children: [
            RegisterField(
              // validator: (value)=> value!.isValidEmail()?null:"Masukkan email dengan benar",
              label: "Email :",
              value: state.email,
              inputType: TextInputType.emailAddress,
              onChanged: (value) =>
                  context.read<RegisterCubit>().onEmailChanged(value),
            ),
            RegisterField(
              label: "Password :",
              value: state.password,
              obscured: true,
              onChanged: (value) =>
                  context.read<RegisterCubit>().onPasswordChanged(value),
            ),
            Text("Panjang minimal password adalah 6 karakter"),
            RegisterField(
              label: "Confirm Password :",
              value: state.confirmPassword,
              obscured: true,
              onChanged: (value) =>
                  context.read<RegisterCubit>().onConfirmPasswordChanged(value),
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