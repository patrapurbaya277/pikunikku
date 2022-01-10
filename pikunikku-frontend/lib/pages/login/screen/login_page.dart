import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/login/login_cubit.dart';
import 'package:pikunikku/cubit/register/register_cubit.dart';
// import 'package:pikunikku/cubit/tour/tour_cubit.dart';
import 'package:pikunikku/cubit/user/user_cubit.dart';
// import 'package:pikunikku/pages/home/screens/home_page.dart';
import 'package:pikunikku/pages/login/widgets/login_form.dart';
import 'package:pikunikku/pages/main/screen/main_page.dart';
import 'package:pikunikku/pages/register/screen/register.dart';
// import 'package:pikunikku/sources/preferences/preference.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode focusEmail = new FocusNode();
  FocusNode focusPassword = new FocusNode();

  void dispose() {
    super.dispose();
    focusEmail.unfocus();
    focusPassword.unfocus();
  }

  @override
  void initState() {
    context.read<UserCubit>().checkTokenAvailability(context);
    context.read<UserCubit>().init();
    context.read<LoginCubit>().init();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
        listener: (BuildContext context, state) async {
      // context.read<UserCubit>().setToken();
      if (state.authSuccess == true) {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (BuildContext context) => MainPage(),
        //   ),
        // );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => MainPage(),
          ),
          (route) => false,
        );
      }
    }, child: BlocBuilder<LoginCubit, LoginState>(builder: (context, login) {
      // context.read<UserCubit>().setToken();
      return GestureDetector(
        onTap: () {
          focusEmail.unfocus();
          focusPassword.unfocus();
        },
        child: Stack(
          children: [
            Container(
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
                body: BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                  return SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          Column(
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
                                  onEmailChanged: (value) {
                                    context
                                        .read<LoginCubit>()
                                        .onEmailChanged(value);
                                  },
                                  onPasswordChanged: (value) {
                                    context
                                        .read<LoginCubit>()
                                        .onPasswordChanged(value);
                                  },
                                  focusEmail: focusEmail,
                                  focusPassword: focusPassword,
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
                                        context.read<RegisterCubit>().init();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterPage()),
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
                          state.loading == true
                              ? Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Logging in...",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  color: Colors.black.withOpacity(0.7),
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      );
    }));
  }
}
