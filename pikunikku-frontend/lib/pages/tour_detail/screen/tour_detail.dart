import 'dart:convert';

// import 'dart:io';

import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// import 'package:pikunikku/cubit/paket/paket_cubit.dart';
// import 'package:pdfdownload/pdfdownload.dart';
import 'package:pikunikku/cubit/tour/tour_cubit.dart';
import 'package:pikunikku/cubit/user/user_cubit.dart';
import 'package:pikunikku/pages/tour_detail/screen/itinerary.dart';
import 'package:pikunikku/pages/tour_detail/widgets/tnc.dart';
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
    return BlocBuilder<UserCubit, UserState>(builder: (context, userState) {
      return BlocBuilder<TourCubit, TourState>(builder: (context, state) {
        return state.singleTour == null
            ? Scaffold(
                backgroundColor: Colors.white,
                body: Center(child: CircularProgressIndicator()),
              )
            : RefreshIndicator(
                onRefresh: (){
                  return Future.delayed(Duration(seconds: 1), () {
                    context
                        .read<TourCubit>()
                        .updateDetail(context, state.singleTour!);
                  });
                },
                child: Scaffold(
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: ElevatedButton(
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 50,
                      child: state.selectedListPaket != null
                          ? state.selectedListPaket!.length != 0
                              ? userState.user!.isVerified == true
                                  ? Text("Pesan Sekarang")
                                  : Text(
                                      "Silahkan Verifikasi Email Anda",
                                      style: TextStyle(color: Colors.red),
                                    )
                              : Text("Tidak Tersedia")
                          : Text("Tidak Tersedia"),
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          state.selectedListPaket != null
                              ? state.selectedListPaket!.length != 0
                                  ? userState.user!.isVerified == true
                                      ? Colors.white.withOpacity(0.3)
                                      : Colors.transparent
                                  : Colors.transparent
                              : Colors.transparent),
                      backgroundColor: MaterialStateProperty.all(
                          state.selectedListPaket != null
                              ? state.selectedListPaket!.length != 0
                                  ? userState.user!.isVerified == true
                                      ? Color(0xff00adef)
                                      : Colors.grey
                                  : Colors.grey
                              : Colors.grey),
                      shadowColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () {
                      if (state.selectedListPaket!.length != 0 &&
                          state.selectedListPaket != null &&
                          userState.user!.isVerified == true)
                        context.read<TourCubit>().showFilterPaket(context);
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
                                json
                                    .decode(state.singleTour!.pict.toString())
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
                                    )
                                    .take(8),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              context.read<TourCubit>().resetSingle();
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
                          padding: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      state.singleTour!.name.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.orange.withOpacity(0.7),
                                          size: 35),
                                      Text(
                                        "5.0",
                                        style: TextStyle(
                                            color:
                                                Colors.orange.withOpacity(0.7),
                                            fontSize: 25),
                                      ),
                                    ],
                                  ),
                                ],
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
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(Icons.date_range,
                                            color: Color(0xff00adef)),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          DateFormat("dd MMMM yyyy").format(
                                              state
                                                  .singleTour!.deparatureTime!),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300),
                                          maxLines: 2,
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(Icons.access_time,
                                            color: Color(0xff00adef)),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                            state.singleTour!.duration
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.confirmation_num,
                                          color: Color(0xff00adef),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                            (state.selectedListPaket != null
                                                    ? state.selectedListPaket!
                                                        .length
                                                        .toString()
                                                    : "0") +
                                                " paket tersedia",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          color: Color(0xff00adef),
                                        ),
                                        SizedBox(width: 5),
                                        Flexible(
                                          child: Text(
                                              "+62 81 1900 4221 (Admin Pikunikku)",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w300)),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Text(
                                "Deskripsi",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(state.singleTour!.desc.toString()),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Yang Perlu Anda persiapkan",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              PreparationList(
                                preparationList: List<String>.from(state
                                    .singleTour!.metaData!.feature!
                                    .where((element) => element != null)
                                    .toList()),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Tur sudah termasuk",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              IncludedList(
                                includedList: List<String>.from(state
                                    .singleTour!.metaData!.include!
                                    .toList()),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Tur tidak termasuk",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              NotIncludedList(
                                notIncludedList: List<String>.from(state
                                    .singleTour!.metaData!.notInclude!
                                    .toList()),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Itinerary",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
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
                                                    decoration: TextDecoration
                                                        .underline)),
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          ItineraryPage(
                                                            pdfUrl: URL.base +
                                                                state
                                                                    .singleTour!
                                                                    .itinerary
                                                                    .toString(),
                                                          )));
                                              print(URL.base +
                                                  state.singleTour!.itinerary
                                                      .toString());
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
                                                  decoration: TextDecoration
                                                      .underline)),
                                          onTap: () {
                                            context
                                                .read<TourCubit>()
                                                .downloadPdf(
                                                    URL.base +
                                                        state.singleTour!
                                                            .itinerary
                                                            .toString(),
                                                    state.singleTour!.name
                                                        .toString(),
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              PreparationList(
                                preparationList: List<String>.from(
                                    state.singleTour!.metaData!.sign!.toList()),
                              ),
                              SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (builder) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Syarat dan Ketentuan",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2,
                                                child: TermAndCondition(),
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Saya Mengerti"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                  // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>TermAndCondition()));
                                },
                                child: SizedBox(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  child: DottedBorder(
                                    color: Colors.grey,
                                    child: Center(
                                        child: Text("Terms & Conditions",
                                            style:
                                                TextStyle(color: Colors.grey))),
                                  ),
                                ),
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
                ),
              );
      });
    });
  }
}
