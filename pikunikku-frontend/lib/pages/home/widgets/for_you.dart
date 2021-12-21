import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/tour/tour_cubit.dart';
import 'package:pikunikku/pages/home/widgets/tour_desc.dart';
// import 'package:pikunikku/pages/tour_detail/screen/tour_detail.dart';
import 'package:pikunikku/sources/api/url.dart';
// import 'package:pikunikku/sources/imagesFromAPI/images.dart';

class ForYou extends StatelessWidget {
  const ForYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TourCubit, TourState>(builder: (context, state) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 12, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Untuk Anda",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                // InkWell(
                //   onTap: () {
                //     print(json.decode(state.allTour![0].pict.toString())[0]);
                //     print(json
                //         .decode(state.allTour![0].pict.toString())
                //         .runtimeType);
                //   },
                //   child: Row(
                //     children: [
                //       Text(
                //         "Selengkapnya",
                //         style: TextStyle(
                //             fontSize: 16,
                //             // fontWeight: FontWeight.bold,
                //             color: Color(0xff00ADEF)),
                //       ),
                //       Icon(Icons.arrow_forward_ios, color: Color(0xff00ADEF), size: 13,)
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
              height: 330,
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 10,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: state.allTourLength!.toInt(),
                  itemBuilder: (BuildContext ctxt, int index) {
                    return InkWell(
                      onTap: (){
                        // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>TourDetail()));
                        context.read<TourCubit>().getTourDetail(context, state.allTour![index]);
                      },
                      child: Container(
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
                                offset:
                                    Offset(1, 1), // changes position of shadow
                              ),
                            ]),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                // height: 150,
                                // width: 300,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(URL.base +
                                          json.decode(state.allTour![index].pict
                                              .toString())[0]),
                                      fit: BoxFit.cover),
                                ),
                                // margin: EdgeInsets.all(5),
                                // color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: TourDesc(
                                index: index,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
        ],
      );
    });
  }
}
