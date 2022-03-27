import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pikunikku/sources/api/url.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Alamat",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 5),
          Text(
            "Office 8 Lv.18A Jl. Jend.Sudirman kav.52-53 Sudirman Central Business District (SCBD) Jakarta Selatan",
            style: TextStyle(color: Colors.white),
            textAlign:TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            "Nomor Telepon",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 5),
          Text(
            "+62 81 1900 4220",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            "Email",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 5),
          Text(
            "admin@pikunikku.id",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 20),
          Text(
            "Also find us on social media",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text("Instagram",style: TextStyle(color: Colors.white),),
              InkWell(
                onTap: ()async{
                  const url = URL.facebook;
      
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
                },
                child: Icon(FontAwesomeIcons.facebook,
                    color: Colors.white, size: 30),
              ),
              SizedBox(width: 15),
              InkWell(onTap: ()async{
                  const url = URL.instagram;
      
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
                }, child: Icon(FontAwesomeIcons.instagram, color: Colors.white, size: 30)),
              SizedBox(width: 15),
              InkWell(onTap: ()async{
                  const url = URL.youtube;
      
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
                }, child: Icon(FontAwesomeIcons.youtube, color: Colors.white, size: 30)),
            ],
          ),
        ],
      ),
    );
  }
}
