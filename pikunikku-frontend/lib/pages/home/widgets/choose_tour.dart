import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:pikunikku/pages/tour_list/screen/tour_list_page.dart';

class ChooseTour extends StatelessWidget {
  const ChooseTour({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => TourOnePage(
                  title: "Pilih Destinasi",
                )));
      },
      child: Transform.translate(
        offset: Offset(0, -30),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Card(
            color: Color(0xff00adef),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.white, width: 2),
            ),
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 20),
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     SizedBox(
            //       width: 20,
            //     ),
            //     // Icon(
            //     //   Icons.pin_drop,
            //     //   color: Colors.red.withOpacity(0.8),
            //     //   size: 27,
            //     // ),
            //     SvgPicture.asset("assets/svg/tracking.svg", height: 22, width: 22, fit: BoxFit.scaleDown,),
            //     SizedBox(
            //       width: 5,
            //     ),
            //     Text("Pilih Destinasi",
            //         style: TextStyle(
            //           color: Colors.black.withOpacity(0.5),
            //           fontSize: 15,
            //         )),
            //   ],
            // ),
            child: Center(
              child: Text(
                "Pilih Destinasi",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
