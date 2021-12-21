import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ndialog/ndialog.dart';
import 'package:pikunikku/cubit/register/register_cubit.dart';
import 'package:pikunikku/pages/register/widgets/account_form.dart';
import 'package:pikunikku/pages/register/widgets/address_form.dart';
import 'package:pikunikku/pages/register/widgets/card_container.dart';
import 'package:pikunikku/pages/register/widgets/identity_form.dart';
// import 'package:pikunikku/features/register/widgets/register_field.dart';
// import 'package:pikunikku/features/register/widgets/top_clip_path.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextStyle subStyle = TextStyle(
    color: Color(0xffAFAFAF),
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );

  TextStyle selectedStyle = TextStyle(
      color: Color(0xff00ADEF), fontSize: 18, fontWeight: FontWeight.w500);

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff00ADEF),
                  Color(0xff7FCCEB),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 135,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(200)),
                color: Colors.white,
              ),
              child: SizedBox(
                height: 100,
                width: 300,
                child: Image.asset(
                  "assets/images/logo_black.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Scaffold(
            appBar: AppBar(
              toolbarHeight: 40,
              shadowColor: Colors.transparent,
              // toolbarOpacity: 0,
              elevation: 0,
              backgroundColor: Colors.transparent,
              // leading: Icon(Icons.arrow_back, color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 135,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: state.status == true
                          ? Column(
                              children: [
                                Text(
                                  "Akun berhasil dibuat",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Silahkan kembali ke halaman login",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ],
                            )
                          : CardContainer(
                              children: [
                                Text(
                                  "Daftar",
                                  style: TextStyle(
                                      color: Color(0xff00ADEF),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      "Akun",
                                      style: state.progress == 0
                                          ? selectedStyle
                                          : subStyle,
                                      textAlign: TextAlign.center,
                                    )),
                                    Expanded(
                                        child: Text(
                                      "Data Diri",
                                      style: state.progress == 1
                                          ? selectedStyle
                                          : subStyle,
                                      textAlign: TextAlign.center,
                                    )),
                                    Expanded(
                                        child: Text(
                                      "Alamat",
                                      style: state.progress == 2
                                          ? selectedStyle
                                          : subStyle,
                                      textAlign: TextAlign.center,
                                    )),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    state.status == true
                                        ? ""
                                        : state.loading == true
                                            ? ""
                                            : state.message.toString(),
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                [
                                  AccountField(),
                                  IdentityForm(),
                                  AddressForm(),
                                ][state.progress!.toInt()]
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
