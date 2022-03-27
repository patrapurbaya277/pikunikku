import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/edit_profile/edit_cubit.dart';

class LocationEdit extends StatelessWidget {
  final String? label;
  final String? value;
  final String? defaultValue;
  final Widget? buildContent;
  final bool? showButton;
  const LocationEdit({
    Key? key,
    this.defaultValue,
    this.value,
    this.label,
    this.buildContent,
    this.showButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditCubit, EditState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label!,
            style: TextStyle(color: Color(0xff00adef), fontSize: 21),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 15),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                  value != ""
                      ? value ?? defaultValue.toString()
                      : defaultValue.toString(),
                  textAlign: TextAlign.start,
                )),
                Expanded(
                  child: showButton == true
                      ? ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff00ADEF))),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(defaultValue!),
                                    content: buildContent,
                                  );
                                });
                          },
                          child: Text(
                            defaultValue!,
                            textAlign: TextAlign.center,
                          ),
                        )
                      : SizedBox(),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}