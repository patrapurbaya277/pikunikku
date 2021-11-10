import 'package:flutter/material.dart';
import 'package:pikunikku/features/login/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
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
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
              Expanded(child: LoginForm()),
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Tidak memiliki Akun ?",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      child: Text("Daftar",style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                      ),),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
