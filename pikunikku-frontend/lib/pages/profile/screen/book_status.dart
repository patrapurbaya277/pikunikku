import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/booking/booking_cubit.dart';
import 'package:pikunikku/cubit/tour/tour_cubit.dart';
import 'package:pikunikku/pages/profile/widgets/book_item.dart';

class BookStatus extends StatefulWidget {
  const BookStatus({Key? key}) : super(key: key);

  @override
  _BookStatusState createState() => _BookStatusState();
}

class _BookStatusState extends State<BookStatus> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TourCubit, TourState>(builder: (context, tourState) {
        return BlocBuilder<BookingCubit, BookingState>(builder: (context, state) {
          return RefreshIndicator(
            onRefresh: ()async{
              return Future.delayed(Duration(seconds: 1),(){
                context.read<BookingCubit>().listBookData(context);
              });
            },
            child: Scaffold(
              backgroundColor: Colors.white.withOpacity(0.9),
              appBar: AppBar(
                title: Text(
                  "Status Pemesanan",
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
              body: state.listBookData != null
                  ? state.listBookData!.length != 0
                      ? ListView(
                          children: state.listBookData!.map((e) => BookItem(bookData: e,tourData:tourState.allTour!.firstWhere((element) => element.id==e.uuidConfigPakets),)).toList(),
                        )
                      : Center(
                          child: Container(
                          child: Text(
                            "Belum ada riwayat pemesanan",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ))
                  : SizedBox(),
            ),
          );
        });
      }
    );
  }
}
