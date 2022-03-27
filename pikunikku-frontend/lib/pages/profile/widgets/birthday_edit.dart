import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pikunikku/cubit/edit_profile/edit_cubit.dart';

class BirthdayEdit extends StatelessWidget {
  const BirthdayEdit({ Key? key }) : super(key: key);
  _selectDate(BuildContext context, EditState state) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: state.tglLahir ?? DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != state.tglLahir) {
      context.read<EditCubit>().selectBirthday(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCubit, EditState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tanggal Lahir",
            style: TextStyle(color: Color(0xff00adef), fontSize: 21),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 15),
            child: Row(
              children: [
                Expanded(
                  child: state.tglLahir != null
                      ? Text(
                          DateFormat("dd MMMM yyyy").format(
                            state.tglLahir ?? DateTime.now(),
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