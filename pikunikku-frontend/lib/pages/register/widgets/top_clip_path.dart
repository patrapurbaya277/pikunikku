import 'package:flutter/material.dart';

class TopClipPath extends StatelessWidget {
  const TopClipPath({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BackgroundClipper(),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.51,
          decoration: BoxDecoration(
            color: Colors.white,
          )
          // borderRadius: BorderRadius.circular(),
          ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // path.moveTo(size.width*0.25, 0,);
    // path.quadraticBezierTo(size.width*0.25, 0,size.width*0.375,77);
    // path.quadraticBezierTo(size.width*0.375,77,size.width*0.5, 114);
    // path.quadraticBezierTo(size.width*0.5, 114,size.width*0.625, 77);
    // path.quadraticBezierTo(size.width*0.625, 77,size.width*0.75, 0);

    // path.moveTo(size.width*0.25, 0,);
    // path.quadraticBezierTo(size.width*0.3, 114, size.width*0.5, 114,);
    // path.quadraticBezierTo(size.width*0.625, 114, size.width*0.75, 0,);

    path.lineTo(size.width * 0.75, 0);
    path.lineTo(size.width * 0.25, 0);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
