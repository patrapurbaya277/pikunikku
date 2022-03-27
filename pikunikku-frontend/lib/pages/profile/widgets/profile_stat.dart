import 'package:flutter/material.dart';

class ProfileStat extends StatelessWidget {
  final String? label;
  final String? value;
  final FocusNode? focusNode;
  // final Function(String)? onChanged;
  final Function()? onTap;
  const ProfileStat({Key? key, this.label, this.value, this.onTap, this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Divider(height: 40),
        Text(
          label!,
          style: TextStyle(color: Color(0xff00adef), fontSize: 21),
        ),
        InkWell(
          onTap: onTap,
          focusNode: focusNode,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            width: MediaQuery.of(context).size.width,
            // height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xff00adef), width: 2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(value!),
          ),
        ),
        // TextFormField(
        //   onChanged: onChanged,
        //   initialValue: value,
        //   decoration: InputDecoration(
        //     focusedBorder: OutlineInputBorder(
        //       borderRadius:BorderRadius.circular(5),
        //       borderSide: BorderSide(color: Color(0xff00adef))
        //     ),
        //     enabledBorder: OutlineInputBorder(
        //       borderRadius:BorderRadius.circular(5),
        //       borderSide: BorderSide(color: Color(0xff00adef),width: 2)
        //     )
        //   ),
        // ),
        SizedBox(height: 20),
      ],
    );
  }
}
