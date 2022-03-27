import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:pikunikku/cubit/booking/booking_cubit.dart';
import 'package:pikunikku/sources/model/paket.dart';
import 'package:pikunikku/sources/model/tour.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaketItem extends StatelessWidget {
  final Tour? tour;
  final Paket? paket;
  const PaketItem({Key? key, this.paket, this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xff00adef).withOpacity(0.2),
        borderRadius: BorderRadius.circular(7),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            paket!.packageName.toString(),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff00adef)),
          ),
          SizedBox(
            height: 5,
          ),
          Text(paket!.packageDescription.toString(),
              style: TextStyle(fontSize: 15)),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rp " + paket!.packagePrice.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<BookingCubit>().preBook(
                      tour!.id.toString(), paket!.id!.toInt(), context);
                  
                },
                child: Text("Buat Pemesanan"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
