import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final Function()? onTap;
  final Icon? icon;
  final String label;
  const MenuItem({ Key? key, this.icon, required this.label , this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        children: [
          icon??SizedBox(),
          SizedBox(width: 15,),
          Text(label, style: TextStyle(color: Colors.black),),
        ],
      ),
    );
  }
}