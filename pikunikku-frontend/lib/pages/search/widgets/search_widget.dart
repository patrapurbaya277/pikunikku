import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pikunikku/sources/api/url.dart';
import 'package:pikunikku/sources/model/tour.dart';

class SearchWidget extends StatelessWidget {
  final Tour tour;
  const SearchWidget({Key? key, required this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: 220,
      clipBehavior: Clip.antiAlias,
      // height: 270,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ]),
      child: Column(
        children: [
          Image.network(
            URL.base + json.decode(tour.pict.toString())[0],
            fit: BoxFit.cover,
          ),
          SearchDesc(
            tour: tour,
          )
        ],
      ),
    );
  }
}

class SearchDesc extends StatelessWidget {
  final Tour tour;
  const SearchDesc({Key? key, required this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(children: [
        Text(
          tour.name.toString(),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Icon(Icons.star, color: Colors.orange.withOpacity(0.7), size: 15),
            Icon(Icons.star, color: Colors.orange.withOpacity(0.7), size: 15),
            Icon(Icons.star, color: Colors.orange.withOpacity(0.7), size: 15),
            Icon(Icons.star, color: Colors.orange.withOpacity(0.7), size: 15),
            Icon(Icons.star, color: Colors.orange.withOpacity(0.7), size: 15),
            SizedBox(
              width: 10,
            ),
            Text("5.0", style: TextStyle(color: Colors.orange)),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Icon(
              Icons.pin_drop,
              color: Colors.red,
            ),
            SizedBox(
              width: 5,
            ),
            Text(tour.location.toString()),
            SizedBox(
              width: 5,
            ),
          ],
        ),
        Text(
          tour.desc.toString(),
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            color: Colors.black.withOpacity(0.6),
            
          ),
          maxLines: 3,
        )
      ]),
    );
  }
}
