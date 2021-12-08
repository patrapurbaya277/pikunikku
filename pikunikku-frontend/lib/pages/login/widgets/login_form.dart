import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/login/login_cubit.dart';
import 'package:pikunikku/cubit/user/user_cubit.dart';
import 'package:pikunikku/pages/home/screens/home_page.dart';
// import 'package:pikunikku/sources/model/user.dart';

import 'login_field.dart';
import 'submit_button.dart';
// import 'package:pikunikku/features/register/screen/register.dart';

class LoginForm extends StatelessWidget {
  final Function()? onSubmit;
  final ValueChanged<String>? onEmailChanged;
  final ValueChanged<String>? onPasswordChanged;
  const LoginForm({Key? key, this.onSubmit, this.onEmailChanged, this.onPasswordChanged}) : super(key: key);
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoginField(
            hint: "Email",
            controller: emailController,
            onChanged: onEmailChanged,
            isObscure: false,
          ),
          LoginField(
            hint: "Password",
            controller: passwordController,
            isObscure: true,
            onChanged: onPasswordChanged,
          ),
          SizedBox(
            height: 25,
          ),
          SubmitButton(
            onPressed: onSubmit,
          ),
          
        ],
      ),
    );
  }
}
