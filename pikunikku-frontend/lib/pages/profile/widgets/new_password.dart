import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/edit_profile/edit_cubit.dart';

class NewPassword extends StatelessWidget {
  final FocusNode? newPasswordFocus;
  final FocusNode? confirmPasswordFocus;
  const NewPassword(
      {Key? key, this.newPasswordFocus, this.confirmPasswordFocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCubit, EditState>(builder: (context, editState) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
                label: Text("Password Baru"),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff00adef), width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff00adef), width: 1.4),
                  borderRadius: BorderRadius.circular(5),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    context.read<EditCubit>().visiblePassword();
                  },
                  child: Icon(editState.hidePassword == null ||
                          editState.hidePassword == false
                      ? Icons.visibility_off
                      : Icons.visibility),
                )),
            focusNode: newPasswordFocus,
            obscureText: editState.hidePassword ?? true,
            onChanged: (value) {
              context.read<EditCubit>().onNewPasswordChanged(value);
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
              label: Text("Konfirmasi Password Baru"),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff00adef), width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff00adef), width: 1.4),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            focusNode: confirmPasswordFocus,
            obscureText: true,
            onChanged: (value) {
              context.read<EditCubit>().onConfirmPasswordChanged(value);
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
                      editState.newPassword != null &&
                              editState.newPassword != "" &&
                              editState.confirmPassword != null &&
                              editState.confirmPassword != "" &&
                              editState.newPassword == editState.confirmPassword
                          ? Color(0xff00adef)
                          : Colors.grey),
                  overlayColor: MaterialStateProperty.all(
                      editState.newPassword != null &&
                              editState.newPassword != "" &&
                              editState.confirmPassword != null &&
                              editState.confirmPassword != "" &&
                              editState.newPassword == editState.confirmPassword
                          ? null
                          : Colors.transparent)),
              onPressed: () {
                if (editState.newPassword != null &&
                    editState.newPassword != "" &&
                    editState.confirmPassword != null &&
                    editState.confirmPassword != "" &&
                    editState.newPassword == editState.confirmPassword) {
                  newPasswordFocus!.unfocus();
                  confirmPasswordFocus!.unfocus();
                  context.read<EditCubit>().ubahPassword(context);
                }
              },
              child: Text("Ganti Password"),
            ),
          )
        ],
      );
    });
  }
}
