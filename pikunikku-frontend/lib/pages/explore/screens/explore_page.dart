import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/search/search_cubit.dart';
import 'package:pikunikku/cubit/tour/tour_cubit.dart';
import 'package:pikunikku/pages/explore/widgets/tour_item.dart';
import 'package:pikunikku/pages/search/screens/search_page.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TourCubit, TourState>(
      builder: (context, state) => state.successGetData == true
          ? SafeArea(
            child: DefaultTabController(
                length: 3,
                child: NestedScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  headerSliverBuilder: (context, child) => [
                    SliverToBoxAdapter(
                      child: InkWell(
                        onTap: (){
                          context.read<SearchCubit>().init();
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>SearchPage()));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 15,
                            left: 10,
                            right: 10,
                          ),
                          height: 40,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              Text(
                                "Lokasi yang anda inginkan ?",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverAppBar(
                      elevation: 2,
                      backgroundColor: Colors.white,
                      automaticallyImplyLeading: false,
                      pinned: true,
                      title: SizedBox(
                        height: 40,
                        child: Card(
                          elevation: 0,
                          margin: EdgeInsets.all(0),
                          child: TabBar(
                            labelPadding: EdgeInsets.symmetric(horizontal: 15),
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.black.withOpacity(0.5),
                            isScrollable: true,
                            tabs: [
                              Text("Semua"),
                              Text("Pergi Jauh"),
                              Text("Dekat Rumah"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  body: TabBarView(
                    children: [
                      state.allTour == null
                          ? SizedBox()
                          : RefreshIndicator(
                              onRefresh: () {
                                return Future.delayed(
                                  Duration(seconds: 1),
                                  () {
                                    context.read<TourCubit>().getAllTour(context);
                                  },
                                );
                              },
                              child: ListView(
                                children: state.allTour!
                                    .map((e) => TourItem(tour: e))
                                    .toList(),
                              ),
                            ),
                      state.listTourPergiJauh == null
                          ? SizedBox()
                          : RefreshIndicator(
                            onRefresh: () {
                                return Future.delayed(
                                  Duration(seconds: 1),
                                  () {
                                    context.read<TourCubit>().getAllTour(context);
                                  },
                                );
                              },
                            child: ListView(
                                children: state.listTourPergiJauh!
                                    .map((e) => TourItem(tour: e))
                                    .toList(),
                              ),
                          ),
                      state.listTourDekatRumah == null
                          ? SizedBox()
                          : RefreshIndicator(
                            onRefresh: () {
                                return Future.delayed(
                                  Duration(seconds: 1),
                                  () {
                                    context.read<TourCubit>().getAllTour(context);
                                  },
                                );
                              },
                            child: ListView(
                                children: state.listTourDekatRumah!
                                    .map((e) => TourItem(tour: e))
                                    .toList(),
                              ),
                          ),
                    ],
                  ),
                ),
              ),
          )
          : state.loadingData == true
              ? CircularProgressIndicator()
              : SizedBox(),
    );
  }
}
