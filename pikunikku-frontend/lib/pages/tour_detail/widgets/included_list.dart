import 'package:flutter/material.dart';

class IncludedList extends StatelessWidget {
  final List<String>? includedList;
  const IncludedList({Key? key, this.includedList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7,left: 10),
      child: Column(
          children: includedList!
              .map(
                (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Color(0xff00adef),
                        borderRadius: BorderRadius.circular(3)
                      ),
                      child: Icon(
                        Icons.check,
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
