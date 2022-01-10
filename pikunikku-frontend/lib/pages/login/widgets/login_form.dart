import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/login/login_cubit.dart';
import 'package:pikunikku/cubit/user/user_cubit.dart';
// import 'package:pikunikku/pages/home/screens/home_page.dart';
// import 'package:pikunikku/sources/model/user.dart';

import 'login_field.dart';
import 'submit_button.dart';
// import 'package:pikunikku/features/register/screen/register.dart';

class LoginForm extends StatelessWidget {
  final Function()? onSubmit;
  final ValueChanged<String>? onEmailChanged;
  final ValueChanged<String>? onPasswordChanged;
  final FocusNode? focusEmail;
  final FocusNode? focusPassword;
  const LoginForm(
      {Key? key,
      this.onSubmit,
      this.onEmailChanged,
      this.onPasswordChanged,
      this.focusEmail,
      this.focusPassword})
      : super(key: key);
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(builder: (context, userState) {
      return BlocBuilder<LoginCubit, LoginState>(
          builder: (context, loginState) {
        return Container(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoginField(
                hint: "Email",
                action: TextInputAction.next,
                value: loginState.email,
                onChanged: onEmailChanged,
                inputType: TextInputType.emailAddress,
                focusNode: focusEmail,
              ),
              LoginField(
                hint: "Password",
                action: TextInputAction.done,
                value: loginState.password,
                isObscure: loginState.visiblePassword ? false : true,
                onChanged: onPasswordChanged,
                focusNode: focusPassword,
                onComplete: (_) {
                  context
                      .read<UserCubit>()
                      .login(loginState.email, loginState.password,context);
                },
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () => context.read<LoginCubit>().showHidePassword(),
                    child: loginState.visiblePassword
                        ? Icon(
                            Icons.visibility,
                            color: Colors.black,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              userState.authSuccess == true
                  ? Text("")
                  : userState.message == null
                      ? Text("")
                      : Text(
                          userState.message.toString(),
                          style: TextStyle(color: Colors.yellow),
                        ),
              SizedBox(
                height: 25,
              ),
              SubmitButton(
                      onPressed: () {
                        focusEmail!.unfocus();
                        focusPassword!.unfocus();
                        context
                            .read<UserCubit>()
                            .login(loginState.email, loginState.password,context);
                      },
                    ),
            ],
          ),
        );
      });
    });
  }
}
