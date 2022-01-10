import 'dart:convert';

import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:pikunikku/sources/api/url.dart';
import 'package:pikunikku/sources/model/article.dart';

class ArticleRead extends StatefulWidget {
  final Article article;
  const ArticleRead({Key? key, required this.article}) : super(key: key);

  @override
  _ArticleReadState createState() => _ArticleReadState();
}

class _ArticleReadState extends State<ArticleRead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          "Baca Artikel",
        ),
        backgroundColor: Color(0xff00adef),
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(widget.article.title.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center),

              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                        // clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          "assets/images/admin.png",
                          height: 11,
                          width: 11,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Admin",style: TextStyle(fontSize: 10),)
                    ],
                  ),
                  // Text("•",style: TextStyle(fontSize: 20), ),
                  Row(
                    children: [
                      Icon(Icons.date_range,size: 14,),
                      SizedBox(width: 2,),
                      Text(
                        DateFormat("dd MMMM yyyy")
                            .format(widget.article.createdAt!),style: TextStyle(fontSize: 10)
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.category,size: 14,),
                      SizedBox(width: 2,),
                      Text(widget.article.category.toString(),style: TextStyle(fontSize: 10))
                    ],
                  )
                ],
              ),
              SizedBox(height:20),
              widget.article.picture == null
                  ? SizedBox()
                  : widget.article.slider == "" || widget.article.slider == "[]"
                      ? Image.network(
                          URL.baseBeta +
                              "assets/images/articles/" +
                              widget.article.picture.toString(),
                        )
                      : Carousel(
                          autoplay: false,
                          dotVerticalPadding: 15,
                          dotBgColor: Colors.transparent,
                          dotIncreasedColor: Color(0xff00adef),
                          images: [
                            Image.network(
                              URL.base + widget.article.picture.toString(),
                              fit: BoxFit.cover,
                              height: 300,
                            ),
                            ...json
                                .decode(
                                  widget.article.slider.toString(),
                                )
                                .map(
                                  (item) => Container(
                                    child: Center(
                                      child: Image.network(
                                        URL.base + item,
                                        fit: BoxFit.cover,
                                        height: 300,
                                      ),
                                    ),
                                  ),
                                ),
                          ],
                        ),
              // Text(widget.article.content)
              
              
              SizedBox(height: 20,),
              HtmlWidget(
                widget.article.content.toString(),

              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
