import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pikunikku/pages/articles/screen/article_read.dart';
import 'package:pikunikku/sources/api/url.dart';
import 'package:pikunikku/sources/model/article.dart';

class ArticleItem extends StatelessWidget {
  final Article? article;
  const ArticleItem({Key? key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ArticleRead(article: article!)));
      },
      child: Container(
        height: 200,
        margin: EdgeInsets.only(bottom: 10),
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          // color: Colors.grey,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey,
              Colors.white,
              Colors.grey
            ]
          ),
          image: DecorationImage(
            image:  NetworkImage(
              URL.baseBeta +
                  "assets/images/articles/" +
                  article!.picture.toString(),
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
    
          // borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    // Colors.transparent,
                    Colors.black
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article!.title.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Image.asset(
                              "assets/images/admin.png",
                              height: 18,
                              width: 18,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Admin", style: TextStyle(color: Colors.white))
                        ],
                      ),
                      Text(
                          DateFormat("EEEE, dd MMMM yyyy")
                              .format(article!.createdAt!),
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
