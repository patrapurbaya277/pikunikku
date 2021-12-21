import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/register/register_cubit.dart';
import 'package:pikunikku/pages/register/style.dart';

class GenderRadio extends StatelessWidget {
  const GenderRadio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Jenis Kelamin", style: RegisterStyle.label,),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Radio(
                        value: "Laki-laki",
                        groupValue: state.gender,
                        onChanged: (value) => context
                            .read<RegisterCubit>()
                            .onGenderChanged(value.toString()),
                      ),
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
                        groupValue: state.gender,
                        onChanged: (value) => context
                            .read<RegisterCubit>()
                            .onGenderChanged(value.toString()),
                      ),
                      Text("Perempuan",),
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
