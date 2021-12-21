import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pikunikku/cubit/tour/tour_cubit.dart';
import 'package:pikunikku/main.dart';
// import 'package:pikunikku/pages/tour_detail/screen/tour_detail.dart';
import 'package:pikunikku/sources/api/url.dart';
import 'package:pikunikku/sources/model/tour.dart';
// import 'package:provider/src/provider.dart';
// import 'package:provider/src/provider.dart';

class TourItem extends StatelessWidget {
  final Tour tour;
  const TourItem({Key? key, required this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TourCubit, TourState>(
      builder: (context,state) {
        return InkWell(
          onTap: (){
            // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>TourDetail()));
            context.read<TourCubit>().getTourDetail(context, tour);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: MediaQuery.of(context).size.width / 2.5 - 120,
                    bottom: 10,
                  ),
                  height: 180,
                  width: MediaQuery.of(context).size.width - 150,
                  // width: MediaQuery.of(context).size.width / 1.67,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: Offset(1, 1), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
        
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            tour.name.toString().capitalizeEachWord(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(Icons.star,
                              color: Colors.orange.withOpacity(0.7), size: 15),
                          Icon(Icons.star,
                              color: Colors.orange.withOpacity(0.7), size: 15),
                          Icon(Icons.star,
                              color: Colors.orange.withOpacity(0.7), size: 15),
                          Icon(Icons.star,
                              color: Colors.orange.withOpacity(0.7), size: 15),
                          Icon(Icons.star,
                              color: Colors.orange.withOpacity(0.7), size: 15),
                          SizedBox(
                            width: 10,
                          ),
                          Text("5.0", style: TextStyle(color: Colors.orange)),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        tour.desc.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.date_range, size: 15),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                DateFormat("dd MMMM yyyy")
                                    .format(tour.deparatureTime!),
                                style: TextStyle(fontSize: 11),
                                maxLines: 2,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 15),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                tour.duration.toString(),
                                style: TextStyle(fontSize: 11),
                                overflow: TextOverflow.ellipsis
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text("Rp " + (tour.price ?? 0).toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, 40),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(
                                URL.base + json.decode(tour.pict.toString())[0]),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
