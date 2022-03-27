import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/edit_profile/edit_cubit.dart';

class GenderEdit extends StatelessWidget {
  const GenderEdit({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCubit, EditState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Jenis Kelamin",
            style: TextStyle(color: Color(0xff00adef), fontSize: 21),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Radio(
                          value: "Laki-laki",
                          groupValue: state.jeniskelamin,
                          onChanged: (value) {
                            context
                                .read<EditCubit>()
                                .onGenderChanged(value.toString());
                          }),
                      Text("Laki-laki"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Radio(
                          value: "Perempuan",
                          groupValue: state.jeniskelamin,
                          onChanged: (value) {
                            context
                                .read<EditCubit>()
                                .onGenderChanged(value.toString());
                          }),
                      Text(
                        "Perempuan",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      );
    });
  }
}
