import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pikunikku/cubit/paket/paket_cubit.dart';
import 'package:pikunikku/cubit/tour/tour_cubit.dart';
import 'package:pikunikku/pages/tour_paket/widgets/paket_item.dart';

class PaketPage extends StatefulWidget {
  const PaketPage({Key? key}) : super(key: key);

  @override
  _PaketPageState createState() => _PaketPageState();
}

class _PaketPageState extends State<PaketPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TourCubit, TourState>(builder: (context, state) {
      return RefreshIndicator(
        onRefresh: (){
          return Future.delayed(Duration(seconds: 1), () {
            context.read<TourCubit>().getListPaket(context);
          });
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: Text(
                "Pilih paket yang tersedia",
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
              )),
          body: ListView(
            children: state.selectedListPaket!
                .map((e) => PaketItem(
                      tour: state.singleTour,
                      paket: e,
                    ))
                .toList(),
          ),
        ),
      );
    });
  }
}
