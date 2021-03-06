import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final CrossAxisAlignment? alignment;
  final List<Widget> children;
  final BorderRadius? borderRadius;
  const CardContainer({Key? key, required this.children, this.borderRadius, this.alignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      // height: 400,
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius??BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(
              0,
              10.0,
            ),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: alignment==null?CrossAxisAlignment.center:alignment!,
        children: children,
      ),
    );
  }
}
