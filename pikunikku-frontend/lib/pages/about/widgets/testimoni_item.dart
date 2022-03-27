import 'package:flutter/material.dart';
import 'package:pikunikku/sources/api/url.dart';
import 'package:pikunikku/sources/model/testimoni.dart';

class TestimoniItem extends StatelessWidget {
  final Testimoni? testimoni;
  const TestimoniItem({Key? key, this.testimoni}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10)
            ),
            margin: EdgeInsets.only(left: (MediaQuery.of(context).size.width/4)/2),
            padding: EdgeInsets.only(left: (MediaQuery.of(context).size.width/4)/2+10,top: 10,bottom: 10,right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  testimoni!.subtitle.toString(),
                  style: TextStyle(),
                ),
                SizedBox(height:5),
                Text(
                  testimoni!.title.toString(),
                  style: TextStyle(color: Color(0xff00adef)),
                ),
                Text(
                  testimoni!.place.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: MediaQuery.of(context).size.width/4,
            width: MediaQuery.of(context).size.width/4,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Image.network(URL.baseBeta + "${testimoni!.pict}"),
          ),
        ],
      ),
    );
  }
}
