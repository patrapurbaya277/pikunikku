import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/login/login_cubit.dart';
import 'package:pikunikku/cubit/user/user_cubit.dart';
import 'package:pikunikku/pages/home/screens/home_page.dart';
import 'package:pikunikku/pages/login/widgets/login_form.dart';
import 'package:pikunikku/pages/register/screen/register.dart';
import 'package:pikunikku/sources/preferences/preference.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
        listener: (BuildContext context, state) async {
      // context.read<UserCubit>().setToken();
      if (state.token != "" && state.status != false) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => MultiBlocProvider(
              providers: [
                BlocProvider<UserCubit>(
                  create: (BuildContext context) => UserCubit(),
                ),
                BlocProvider<LoginCubit>(
                  create: (BuildContext context) => LoginCubit(),
                ),
              ],
              child: HomePage(),
            ),
          ),
        );
      }
    }, child: BlocBuilder<LoginCubit, LoginState>(builder: (context, login) {
      context.read<UserCubit>().setToken();
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/bg-login.JPG",
              ),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.grey.withOpacity(0.6), BlendMode.dstATop)),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      width: 300,
                      child: Image.asset(
                        "assets/images/logo_white.png",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: LoginForm(
                      onSubmit: () {
                        context
                            .read<UserCubit>()
                            .login(login.email, login.password);
                        if (state.status == false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0,

                              content: Container(
                                height: 100,
                                child: Text(
                                  state.message.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      onEmailChanged: (value) {
                        context.read<LoginCubit>().onEmailChanged(value);
                      },
                      onPasswordChanged: (value) {
                        context.read<LoginCubit>().onPasswordChanged(value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tidak memiliki Akun ?",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
                          },
                          child: Text(
                            "Daftar",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      );
    }));
  }
}
