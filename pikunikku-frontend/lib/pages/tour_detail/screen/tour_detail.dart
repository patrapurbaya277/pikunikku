import 'dart:convert';
// import 'dart:io';

import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pikunikku/cubit/paket/paket_cubit.dart';
// import 'package:pdfdownload/pdfdownload.dart';
import 'package:pikunikku/cubit/tour/tour_cubit.dart';
import 'package:pikunikku/pages/tour_detail/screen/itinerary.dart';
import 'package:pikunikku/pages/tour_detail/widgets/included_list.dart';
import 'package:pikunikku/pages/tour_detail/widgets/not_included_list.dart';
import 'package:pikunikku/pages/tour_detail/widgets/preparation_list.dart';
import 'package:pikunikku/sources/api/url.dart';
// import 'package:pikunikku/sources/model/meta_data.dart';

class TourDetail extends StatefulWidget {
  const TourDetail({Key? key}) : super(key: key);

  @override
  _TourDetailState createState() => _TourDetailState();
}

class _TourDetailState extends State<TourDetail> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TourCubit, TourState>(builder: (context, state) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ElevatedButton(
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.85,
            height: 50,
            child: state.singleTour!.availableSeat != 0
                ? Text("Pesan Sekarang")
                : Text("Tidak Tersedia"),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                state.singleTour!.availableSeat != 0
                    ? Color(0xff00adef)
                    : Colors.grey),
            shadowColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: () {
            if(state.singleTour!.availableSeat!=0){
              context
                .read<PaketCubit>()
                .showFilterPaket(state.singleTour!.id.toString(), context);
            }
          },
        ),
        body: ListView(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Carousel(
                    autoplay: false,
                    
                    dotVerticalPadding: 15,
                    dotBgColor: Colors.transparent,
                    dotIncreasedColor: Color(0xff00adef),
                    images: List.from(
                      json.decode(state.singleTour!.pict.toString()).map(
                            (item) => Container(
                              child: Center(
                                child: Image.network(
                                  URL.base + item,
                                  fit: BoxFit.cover,
                                  height: 300,
                                ),
                              ),
                            ),
                          ).take(8),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: 60,
                    width: 50,
                    child: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: Offset(0, -30),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.singleTour!.name.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.pin_drop, color: Colors.red),
                        Text(
                          state.singleTour!.location.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star,
                                color: Colors.orange.withOpacity(0.7),
                                size: 30),
                            Text(
                              "5.0",
                              style: TextStyle(
                                  color: Colors.orange.withOpacity(0.7),
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                          child: VerticalDivider(
                            color: Color(0xff00adef),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.date_range, size: 15),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  DateFormat("dd MMMM yyyy").format(
                                      state.singleTour!.deparatureTime!),
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
                                  state.singleTour!.duration.toString(),
                                  style: TextStyle(fontSize: 11),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                          child: VerticalDivider(
                            color: Color(0xff00adef),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Rp " +
                                state.singleTour!.price.toString() +
                                " /pax",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Color(0xff00adef),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.confirmation_num,
                              color: Color(0xff00adef),
                            ),
                            SizedBox(width: 5),
                            Text(
                                (state.singleTour!.availableSeat != null
                                        ? state.singleTour!.availableSeat
                                            .toString()
                                        : "0") +
                                    " yang tersedia",
                                style: TextStyle(fontWeight: FontWeight.w300)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.call,
                              color: Color(0xff00adef),
                            ),
                            SizedBox(width: 5),
                            Text("+62 81 1900 4221 (Admin Pikunikku)",
                                style: TextStyle(fontWeight: FontWeight.w300))
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Deskripsi",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(state.singleTour!.desc.toString()),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Yang Perlu Anda persiapkan",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    PreparationList(
                      preparationList: List<String>.from(
                          state.singleTour!.metaData!.feature!.toList()),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Tur sudah termasuk",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    IncludedList(
                      includedList: List<String>.from(
                          state.singleTour!.metaData!.include!.toList()),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Tur tidak termasuk",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    NotIncludedList(
                      notIncludedList: List<String>.from(
                          state.singleTour!.metaData!.notInclude!.toList()),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Itinerary",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 7),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.picture_as_pdf_rounded,
                                  color: Color(0xff00adef)),
                              SizedBox(width: 5),
                              InkWell(
                                  child: Text("Baca Itinerary",
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.underline)),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ItineraryPage(
                                                  pdfUrl: URL.base +
                                                      state
                                                          .singleTour!.itinerary
                                                          .toString(),
                                                )));
                                    print(URL.base +
                                        state.singleTour!.itinerary.toString());
                                  }),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.file_download_outlined,
                                  color: Color(0xff00adef)),
                              SizedBox(width: 5),
                              InkWell(
                                child: Text("Unduh Itinerary",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline)),
                                onTap: () {
                                  context.read<TourCubit>().downloadPdf(
                                      URL.base +
                                          state.singleTour!.itinerary
                                              .toString(),
                                      state.singleTour!.name.toString(),
                                      context);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Cara Pendaftaran",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    PreparationList(
                      preparationList: List<String>.from(
                          state.singleTour!.metaData!.sign!.toList()),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: DottedBorder(
                          color: Colors.grey,
                          child: Center(child: Text("Terms & Conditions", style: TextStyle(color: Colors.grey))),
                        ),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      );
    });
  }
}
