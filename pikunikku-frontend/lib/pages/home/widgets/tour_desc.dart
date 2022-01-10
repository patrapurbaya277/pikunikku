import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/tour/tour_cubit.dart';
import 'package:pikunikku/main.dart';

class TourDesc extends StatelessWidget {
  final int index;
  const TourDesc({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TourCubit, TourState>(builder: (context, state) {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              alignment: Alignment.centerLeft,
              child: Text(
                state.allTour![index].name.toString().capitalizeEachWord(),
                maxLines: 2,
                style: TextStyle(fontSize: 17, overflow: TextOverflow.ellipsis),
                textAlign: TextAlign.start,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 15,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  state.allTour![index].duration.toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              state.allTour![index].desc!,
              maxLines: 4,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.black.withOpacity(0.6)
              ),
            )
          ],
        ),
      );
    });
  }
}
