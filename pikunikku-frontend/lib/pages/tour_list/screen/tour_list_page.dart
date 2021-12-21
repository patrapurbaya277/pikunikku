

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/tour/tour_cubit.dart';
import 'package:pikunikku/pages/explore/widgets/tour_item.dart';

class TourOnePage extends StatefulWidget {
  final String? title;
  final String? filter;
  const TourOnePage({ Key? key , this.title, this.filter}) : super(key: key);
  static String dekat_rumah = "theme-travel";
  static String pergi_jauh = "tour-travel";

  @override
  _TourOnePageState createState() => _TourOnePageState();
}

class _TourOnePageState extends State<TourOnePage> {
  @override
  Widget build(BuildContext context) {
    context.read<TourCubit>().getAllData();
    return BlocBuilder<TourCubit, TourState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title.toString(), style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
            leading: InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back,color: Colors.black,),
            ),
          ),
          body: ListView(
            children: (widget.filter==null?state.allTour:state.allTour!.where((element) => element.category==widget.filter))!.map((e) => TourItem(tour: e)).toList(),
          ),
        );
      }
    );
  }
}