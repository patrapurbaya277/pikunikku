import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/edit_profile/edit_cubit.dart';
import 'package:pikunikku/pages/profile/widgets/new_password.dart';
import 'package:pikunikku/pages/profile/widgets/password_auth.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  FocusNode passwordFocus = FocusNode();
  FocusNode newPasswordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  // Future<bool> _onWillPop(EditState editState)async {

  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCubit, EditState>(builder: (context, editState) {
      return Stack(
        children: [
          WillPopScope(
            onWillPop: () async {
              if (editState.passwordFase == 1) {
                return await showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("Peringatan"),
                          content: Text("Apakah anda yakin ?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text("Tidak")),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: Text("Ya")),
                          ],
                        ));
              } else {
                Navigator.of(context).pop(false);
              }
              return false;
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  "Ubah Password",
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white,
                shadowColor: Colors.transparent,
                leading: InkWell(
                  onTap: () {
                    if (editState.passwordFase == 1) {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text("Peringatan"),
                                content: Text("Apakah anda yakin ?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Tidak")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Ya")),
                                ],
                              ));
                    } else {
                      Navigator.of(context).pop(false);
                    }
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                    child: [
                  PasswordAuthentication(
                    passwordFocus: passwordFocus,
                  ),
                  NewPassword(
                    newPasswordFocus: newPasswordFocus,
                    confirmPasswordFocus: confirmPasswordFocus,
                  ),
                ][editState.passwordFase!.toInt()]),
              ),
            ),
          ),
          editState.loading == true
              ? Scaffold(
                  backgroundColor: Colors.black.withOpacity(0.8),
                  body: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      );
    });
  }
}
