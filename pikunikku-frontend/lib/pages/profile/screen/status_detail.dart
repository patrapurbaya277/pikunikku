import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pikunikku/cubit/booking/booking_cubit.dart';
import 'package:pikunikku/cubit/tour/tour_cubit.dart';
import 'package:pikunikku/sources/api/url.dart';
import 'package:url_launcher/url_launcher.dart';

class StatusDetail extends StatefulWidget {
  const StatusDetail({Key? key}) : super(key: key);

  @override
  _StatusDetailState createState() => _StatusDetailState();
}

class _StatusDetailState extends State<StatusDetail> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TourCubit, TourState>(builder: (context, tourState) {
      return BlocBuilder<BookingCubit, BookingState>(builder: (context, state) {
        Color? getColor() {
          switch (state.bookDetail!.status) {
            case "Lunas":
              return Colors.green[600];
            case "Belum Lunas":
              return Colors.orange;
            case "Batal":
              return Colors.red;
            default:
              return Colors.red;
          }
        }

        IconData? getIcon() {
          switch (state.bookDetail!.status) {
            case "Lunas":
              return Icons.check_circle;
            case "Belum Lunas":
              return Icons.warning_rounded;
            case "Batal":
              return Icons.close_rounded;
            default:
              return Icons.close_rounded;
          }
        }

        String? getText() {
          switch (state.bookDetail!.status) {
            case "Lunas":
              return "Pembayaran Telah Selesai";
            case "Belum Lunas":
              return "Menunggu Pembayaran";
            case "Batal":
              return "Dibatalkan";
            default:
              return "Dibatalkan";
          }
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Detail Pemesanan",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          floatingActionButton: Container(
            // color: Colors.blue,
            // padding: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, -2),
                  spreadRadius: 2,
                  blurRadius: 2),
            ]),
            // height: MediaQuery.of(context).size.height / 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pembayaran Tersisa"),
                      Text(
                        "Rp " +
                            (NumberFormat("#,##0.00", "en_US").format(
                                double.parse(state.bookDetail!.totalPrice
                                        .toString()) -
                                    double.parse(state.bookDetail!.totalPayments
                                        .toString()))),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (builder) {
                          return Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Text(
                                  "Pembayaran",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Silahkan Transfer Rp ${(NumberFormat("#,##0.00", "en_US").format(double.parse(state.bookDetail!.totalPrice.toString()) - double.parse(state.bookDetail!.totalPayments.toString())))} ke nomor Rekening salah satu dari",
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("•"),
                                      SizedBox(width: 4),
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "CIMB_PT. Pikunikku Arunika Indonesia",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text("800172365300"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("•"),
                                      SizedBox(width: 4),
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "BCA_PT. PIKUNIKKU ARUNIKA INDONESIA",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text("0060768170"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("•"),
                                      SizedBox(width: 4),
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "MANDIRI_PT. PIKUNIKKU ARUNIKA INDONESIA",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text("1240010718808"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Pastikan 3 angka belakang (kode unik) sesuai saat anda melakukan transfer, guna memudahkan admin melakukan verifikasi",
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                    onPressed: () async {
                                      String url = "https://beta.pikunikku.id/membership/tour-history/${state.bookDetail!.uuid}/show";

                                      if (await canLaunch(url)) {
                                        await launch(url);
                                      } else {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                    child: Text("Upload Bukti Pembayaran")),
                              ],
                            ),
                          );
                        });
                  },
                  // https://beta.pikunikku.id/membership/tour-history/1c6f7ca0-41ca-4fcf-9239-edcdc3ca2e17/show
                  child: Container(
                    height: 50,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xff00adef),
                      // borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Bayar",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: RefreshIndicator(
            onRefresh: () async {
              return Future.delayed(Duration(seconds: 1), () {
                context.read<BookingCubit>().bookDetail(state.bookDetail!.uuid);
              });
            },
            child: ListView(
              children: [
                Container(
                  height: 70,
                  color: getColor(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          getIcon(),
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(width: 5),
                        Text(
                          getText().toString(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tanggal Pemesanan"),
                      Text(
                        DateFormat("dd MMMM yyyy, ss:mm:hh")
                            .format(state.bookDetail!.createdAt!),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Batas Pembayaran"),
                      Text(
                        DateFormat("dd MMMM yyyy, ss:mm:hh").format(
                          state.bookDetail!.createdAt!.add(Duration(days: 1)),
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Image.network(URL.base +
                      "${json.decode(tourState.allTour!.firstWhere((element) => element.id == state.bookDetail!.uuidConfigPakets).pict.toString())[0]}"),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    tourState.allTour!
                        .firstWhere((element) =>
                            element.id == state.bookDetail!.uuidConfigPakets)
                        .name
                        .toString(),
                    style: TextStyle(
                      // fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    "x" + state.bookDetail!.totalPeople.toString() + " orang",
                    textAlign: TextAlign.end,
                  ),
                ),
                Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total yang harus dibayar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rp " +
                            (NumberFormat("#,##0.00", "en_US").format(
                                double.parse(state.bookDetail!.totalPrice
                                    .toString()
                                    .toString()))),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total yang sudah dibayar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rp " +
                            (NumberFormat("#,##0.00", "en_US").format(
                                double.parse(state.bookDetail!.totalPayments
                                    .toString()
                                    .toString()))),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}
