import 'package:flutter/material.dart';

class PreparationList extends StatelessWidget {
  final List<String>? preparationList;
  const PreparationList({Key? key, this.preparationList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10, top:7),
      child: Column(
        children: preparationList!
            .map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "•",
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          e,
                        ),
                      )
                    ],
                  ),
            ))
            .toList(),
      ),
    );
  }
}
