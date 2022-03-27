import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pikunikku/cubit/booking/booking_cubit.dart';
import 'package:pikunikku/pages/profile/screen/status_detail.dart';
import 'package:pikunikku/sources/api/url.dart';
import 'package:pikunikku/sources/model/book_data.dart';
import 'package:pikunikku/sources/model/tour.dart';

class BookItem extends StatelessWidget {
  final BookData? bookData;
  final Tour? tourData;
  const BookItem({Key? key, this.bookData, this.tourData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.read<BookingCubit>().bookDetail(bookData!.uuid);
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>StatusDetail()));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Text(bookData!.uuid.toString()),
                      Text(
                        tourData!.name.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "x${bookData!.totalPeople} orang",
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(height: 5),
                      // Text(
                      //   DateFormat("dd MMMM yyyy, ss:mm:hh")
                      //       .format(bookData!.createdAt!),
                      //   textAlign: TextAlign.end,
                      // ),
                      Text(
                        "Rp " +
                            (NumberFormat("#,##0.00", "en_US").format(
                                double.parse(
                                    bookData!.totalPrice.toString().toString()))),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    URL.base + "${json.decode(tourData!.pict.toString())[0]}",
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Status Pembayaran: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  bookData!.status.toString(),
                  style: TextStyle(
                    color: bookData!.status == "Belum Lunas"
                        ? Colors.orange
                        : bookData!.status == "Lunas"
                            ? Colors.green[600]
                            : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
