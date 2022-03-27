

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/edit_profile/edit_cubit.dart';

class PasswordAuthentication extends StatelessWidget {
  final FocusNode? passwordFocus;
  const PasswordAuthentication({Key? key, this.passwordFocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCubit, EditState>(builder: (context, editState) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
              label: Text("Password Lama"),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff00adef), width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff00adef), width: 1.4),
                borderRadius: BorderRadius.circular(5),
              ),
              suffixIcon: InkWell(
                onTap: (){
                  context.read<EditCubit>().visiblePassword();
                },
                child: Icon(editState.hidePassword==null||editState.hidePassword==false? Icons.visibility_off:Icons.visibility),
              )
            ),
            focusNode: passwordFocus,
            obscureText: editState.hidePassword??true,
            
            onChanged: (value) {
              context.read<EditCubit>().onPasswordChanged(value);
            },
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      editState.password != null && editState.password != ""
                          ? Color(0xff00adef)
                          : Colors.grey),
                  overlayColor: MaterialStateProperty.all(
                      editState.password != null && editState.password != ""
                          ? null
                          : Colors.transparent)),
              onPressed: () {
                if (editState.password != null && editState.password != "") {
                  passwordFocus!.unfocus();
                  context.read<EditCubit>().verifikasiPassword(context);
                }
              },
              child: Text("Verifikasi Password"),
            ),
          )
        ],
      );
    });
  }
}
