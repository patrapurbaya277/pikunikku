import 'package:flutter/material.dart';

class NotIncludedList extends StatelessWidget {
  final List<String>? notIncludedList;
  const NotIncludedList({Key? key, this.notIncludedList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10, top:7),
      child: Column(
          children: 
          notIncludedList!
              .map(
                (e) =>
                    Padding(
                      padding: const EdgeInsets.only( bottom: 5),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Color(0xff00adef),
                        borderRadius: BorderRadius.circular(3)
                      ),
                      child: Icon(
                        Icons.close_outlined,
                        size: 15,
                        color: Colors.white,
                      ),
                  ),
                  SizedBox(
                      width: 5,
                  ),
                  Flexible(
                      child: Text(
                        e,
                      ),
                  )
                ]),
                    ),
              )
              .toList()),
    );
  }
}
