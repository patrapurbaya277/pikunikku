import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pikunikku/cubit/booking/booking_cubit.dart';
import 'package:pikunikku/cubit/main/main_cubit.dart';
import 'package:pikunikku/pages/main/screen/main_page.dart';
import 'package:pikunikku/pages/register/widgets/card_container.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state.paket != null && state.image != null) {
          context.read<BookingCubit>().setCanBook(true);
        } else {
          context.read<BookingCubit>().setCanBook(false);
        }
      },
      child: BlocBuilder<BookingCubit, BookingState>(builder: (context, state) {
        return WillPopScope(
          onWillPop: ()async{
            if(state.bookStatus==true){
              return false;
            }
            return true;
          },
          child: Stack(
            children: [
              state.bookStatus == true
                  ? Scaffold(
                      backgroundColor: Color(0xff00adef),
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        leading: SizedBox(),
                      ),
                      body: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CardContainer(
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green,
                                ),
                                Text(
                                  "Pemesanan Berhasil",
                                  style: TextStyle(
                                      fontSize: 25, fontWeight: FontWeight.bold),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  state.tour!.name.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Tanggal Pemesanan"),
                                    Text(DateFormat("dd MMMM yyyy")
                                        .format(state.bookData!.createdAt!))
                                  ],
                                ),
                                // SizedBox(height: 20),
                                Divider(
                                  height: 20,
                                ),
        
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Tanggal Keberangkatan"),
                                    Text(DateFormat("dd MMMM yyyy")
                                        .format(state.tour!.deparatureTime!))
                                  ],
                                ),
                                Divider(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Jumlah"),
                                    Text(state.bookData!.totalPeople.toString() +
                                        " orang")
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Harga"),
                                    Text("Rp " +
                                        (NumberFormat("#,##0.00", "en_US").format(
                                                double.parse(state
                                                    .bookData!.totalPrice
                                                    .toString())))
                                            .toString())
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Dibayar"),
                                    Text("Rp " +
                                        (NumberFormat("#,##0.00", "en_US").format(
                                                double.parse(state
                                                    .bookData!.totalPayments
                                                    .toString())))
                                            .toString())
                                  ],
                                ),
                                SizedBox(height: 20),
                                DottedLine(
                                  dashColor: Colors.grey,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Status Pembayaran"),
                                    Text(
                                      state.bookData!.status.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: state.bookData!.status ==
                                                  "Belum Lunas"
                                              ? Colors.orange
                                              : state.bookData!.status == "Lunas"
                                                  ? Colors.green[600]
                                                  : Colors.red),
                                    )
                                  ],
                                ),
                                SizedBox(height: 30),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(
                                          Color(0xff00adef))),
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MainPage(),
                                      ),
                                      (route) => false,
                                    );
                                    context.read<MainCubit>().onMenuChanged(0);
                                    context.read<BookingCubit>().init();
                                  },
                                  child: Text("Kembali ke halaman utama"),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Scaffold(
                      backgroundColor: Color(0xff00adef),
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        leading: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            SystemChrome.setSystemUIOverlayStyle(
                                SystemUiOverlayStyle(
                              statusBarColor: Colors.white,
                              statusBarIconBrightness: Brightness.dark,
                              systemNavigationBarDividerColor: Colors.transparent,
                              systemNavigationBarColor: Colors.white,
                              systemNavigationBarIconBrightness: Brightness.dark,
                            ));
                            context.read<BookingCubit>().init();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: state.paket == null && state.tour == null
                              ? CircularProgressIndicator(color: Colors.white)
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      state.tour!.name.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CardContainer(
                                      borderRadius: BorderRadius.circular(10),
                                      alignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Booking",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(left: 10),
                                              child: Text("Jumlah Pax :"),
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    if (state.jumlah != 1) {
                                                      context
                                                          .read<BookingCubit>()
                                                          .kurang();
                                                    }
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all()),
                                                      child: Icon(
                                                        Icons.remove,
                                                      )),
                                                ),
                                                SizedBox(width: 10),
                                                Text(state.jumlah.toString()),
                                                SizedBox(width: 10),
                                                InkWell(
                                                  onTap: () {
                                                    if (state.jumlah !=
                                                        int.parse(state.paket!
                                                            .availablePackage
                                                            .toString())) {
                                                      context
                                                          .read<BookingCubit>()
                                                          .tambah();
                                                    }
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all()),
                                                      child: Icon(
                                                        Icons.add,
                                                      )),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Paket Tersedia : " +
                                                state.paket!.availablePackage
                                                    .toString(),
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Upload KTP/SIM",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                        SizedBox(height: 5),
                                        state.image != null
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Container(
                                                    child: Image.file(
                                                        File(state.image!.path))),
                                              )
                                            : SizedBox(),
                                        SizedBox(height: 5),
                                        Center(
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Color(0xff00adef))),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Column(
                                                children: [
                                                  Icon(Icons.camera_alt),
                                                  // Text("Pilih Gambar")
                                                ],
                                              ),
                                            ),
                                            onPressed: () {
                                              context
                                                  .read<BookingCubit>()
                                                  .pickImage(context);
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Model Pembayaran",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          height: 30,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.blue),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    if (state.metode == "DP")
                                                      context
                                                          .read<BookingCubit>()
                                                          .onMetodeChanged(
                                                              "Langsung");
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: state.metode ==
                                                              "Langsung"
                                                          ? Color(0xff00adef)
                                                          : null,
                                                    ),
                                                    child: Text("Langsung",
                                                        style: TextStyle(
                                                            color: state.metode ==
                                                                    "Langsung"
                                                                ? Colors.white
                                                                : Colors.black)),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    if (state.paket!.minimumDp !=
                                                        0.0) if (state
                                                            .metode ==
                                                        "Langsung")
                                                      context
                                                          .read<BookingCubit>()
                                                          .onMetodeChanged("DP");
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: state.metode == "DP"
                                                          ? Color(0xff00adef)
                                                          : state.paket!
                                                                      .minimumDp ==
                                                                  0.0
                                                              ? Colors.grey
                                                              : null,
                                                    ),
                                                    child: Text("DP",
                                                        style: TextStyle(
                                                            color: state.metode ==
                                                                    "DP"
                                                                ? Colors.white
                                                                : Colors.black)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        DottedLine(
                                          dashColor: Colors.grey,
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Total Biaya ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            ),
                                            Text(
                                              "Rp " +
                                                  (NumberFormat(
                                                              "#,##0.00", "en_US")
                                                          .format(state.paket!
                                                                  .packagePrice! *
                                                              state.jumlah!
                                                                  .toDouble()))
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                state.canBook == true
                                                    ? Color(0xff00adef)
                                                    : Colors.grey,
                                              ),
                                              overlayColor:
                                                  MaterialStateProperty.all(
                                                state.canBook == true
                                                    ? null
                                                    : Colors.transparent,
                                              ),
                                            ),
                                            onPressed: () {
                                              if (state.canBook == true) {
                                                context
                                                    .read<BookingCubit>()
                                                    .book(context);
                                              }
                                            },
                                            child: Text("Pesan Sekarang"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
              state.loading == true
                  ? Scaffold(
                      backgroundColor: Colors.white.withOpacity(0.5),
                      body: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xff00adef),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        );
      }),
    );
  }
}
