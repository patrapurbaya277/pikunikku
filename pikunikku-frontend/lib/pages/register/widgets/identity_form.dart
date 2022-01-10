import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
import 'package:pikunikku/cubit/register/register_cubit.dart';
import 'package:pikunikku/pages/register/widgets/birthday.dart';
import 'package:pikunikku/pages/register/widgets/gender_radio.dart';
import 'package:pikunikku/pages/register/widgets/navigation_button.dart';
import 'package:pikunikku/pages/register/widgets/register_field.dart';
// import 'package:provider/src/provider.dart';
// import 'package:provider/src/provider.dart';

class IdentityForm extends StatelessWidget {
  final FocusNode? nameFocus;
  final FocusNode? phoneFocus;
  const IdentityForm({Key? key, this.nameFocus, this.phoneFocus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      return Column(
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                width: 150,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: state.image != null?Colors.transparent:Colors.grey),
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/user_default.png",
                        ),
                        fit: BoxFit.cover)),
                child: state.image != null
                    ? Image.file(File(state.image!.path), fit: BoxFit.cover)
                    : SizedBox()
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () async {
                    context.read<RegisterCubit>().pickImage(context);
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xff00ADEF)),
                    child: Icon(
                      Icons.photo_camera_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
          RegisterField(
            label: "Nama",
            value: state.name,
            inputType: TextInputType.name,
            onChanged: (value) =>
                context.read<RegisterCubit>().onNameChanged(value),
            focusNode: nameFocus,
          ),
          GenderRadio(focusName: nameFocus, focusPhone: phoneFocus,),
          // Text("Tanggal Lahir"),
          Birthday(focusName: nameFocus, focusPhone: phoneFocus),
          RegisterField(
            label: "Nomor Handphone",
            value: state.phoneNumber,
            inputType: TextInputType.number,
            onChanged: (value) =>
                context.read<RegisterCubit>().onPhoneNumberChanged(value),
            focusNode: phoneFocus,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavigationButton(
                type: NavigationButton.before,
                onPressed: () => context.read<RegisterCubit>().beforeProgress(),
                enabled: true,
              ),
              NavigationButton(
                // enabled: state.identityTrue,
                enabled: state.name != "" &&
                    state.birthday != null &&
                    state.phoneNumber != "",
                type: NavigationButton.next,
                onPressed: () {
                  if (state.name != "" &&
                      state.birthday != null &&
                      state.phoneNumber != "") {
                    context.read<RegisterCubit>().nextProgress();
                  }
                },
              )
            ],
          ),
        ],
      );
    });
  }
}
