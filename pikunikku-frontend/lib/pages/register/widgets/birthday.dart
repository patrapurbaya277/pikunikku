import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pikunikku/cubit/register/register_cubit.dart';
import 'package:pikunikku/pages/register/style.dart';

class Birthday extends StatelessWidget {
  final FocusNode? focusName;
  final FocusNode? focusPhone;
  const Birthday({Key? key,this.focusName,this.focusPhone}) : super(key: key);
  _selectDate(BuildContext context, RegisterState state) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: state.birthday ?? DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != state.birthday) {
      context.read<RegisterCubit>().updateBirthday(selected);
      print(state.birthday);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tanggal Lahir",
            style: RegisterStyle.label,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 15),
            child: Row(
              children: [
                Expanded(
                  child: state.birthday != null
                      ? Text(
                          DateFormat("dd MMMM yyyy").format(
                            state.birthday ?? DateTime.now(),
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Text("Pilih Tanggal Lahir",
                          textAlign: TextAlign.center),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff00ADEF))),
                    onPressed: () {
                      focusPhone!.unfocus();
                      focusName!.unfocus();
                      _selectDate(context, state);
                    },
                    child: Text("Pilih Tanggal Lahir"),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}
