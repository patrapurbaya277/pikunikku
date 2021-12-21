import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pikunikku/cubit/tour/tour_cubit.dart';
import 'package:pikunikku/pages/home/widgets/choose_tour.dart';
import 'package:pikunikku/pages/home/widgets/dash_home.dart';
import 'package:pikunikku/pages/home/widgets/for_you.dart';
import 'package:pikunikku/pages/tour_list/screen/tour_list_page.dart';
// import 'package:provider/src/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TourCubit,TourState>(
      builder: (context,state) {
        return RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 1),
              () {
                context.read<TourCubit>().getAllData();
              },
            );
          },
          child: ListView(
            children: [
              DashHome(),
              ChooseTour(),
              ForYou(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => TourOnePage(
                                    title: "Destinasi Pergi Jauh",
                                    filter: TourOnePage.pergi_jauh,
                                  )));
                        },
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            // color: Color(0xff00ADEF),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xff00ADEF),
                                Color(0xff00ADEF),
                                Color(0xff00ADEF).withOpacity(0.7),
                                Color(0xff00ADEF).withOpacity(0.6),
                                Color(0xff00ADEF).withOpacity(0.7),
                                Color(0xff00ADEF),
                              ],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/geography.svg",
                                color: Colors.white,
                                height: 80,
                                width: 80,
                                fit: BoxFit.scaleDown,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Pergi Jauh",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => TourOnePage(
                                    title: "Destinasi Dekat Rumah",
                                    filter: TourOnePage.dekat_rumah,
                                  )));
                        },
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xff00ADEF),
                                Color(0xff00ADEF),
                                Color(0xff00ADEF).withOpacity(0.7),
                                Color(0xff00ADEF).withOpacity(0.6),
                                Color(0xff00ADEF).withOpacity(0.7),
                                Color(0xff00ADEF),
                              ],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/svg/ind.svg",
                                height: 80,
                                width: 80,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Dekat Rumah",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(),
            ],
          ),
        );
      }
    );
  }
}
