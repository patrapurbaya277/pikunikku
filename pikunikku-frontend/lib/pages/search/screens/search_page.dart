import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/search/search_cubit.dart';
import 'package:pikunikku/pages/search/widgets/search_widget.dart';
// import 'package:pikunikku/sources/model/tour.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FocusNode focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      return SafeArea(
        child: GestureDetector(
          onTap: () {
            focus.unfocus();
          },
          child: Scaffold(
            body: NestedScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              headerSliverBuilder: (context, child) => [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  pinned: true,
                  title: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10),
                            height: 40,
                            child: Align(
                              alignment: Alignment.center,
                              child: TextFormField(
                                autofocus: true,
                                onChanged: (value) => context
                                    .read<SearchCubit>()
                                    .onKeyChanged(value),
                                onFieldSubmitted: (_) {
                                  focus.unfocus();
                                  if (state.key != null || state.key != "") {
                                    context
                                        .read<SearchCubit>()
                                        .searchTour(context);
                                  }
                                },
                                textInputAction: TextInputAction.search,
                                focusNode: focus,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                  hintText: "Lokasi yang anda inginkan",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
              body: state.loading == false
                  ?
                  // ListView(
                  //     children: state.result == [] || state.result == null
                  //         ? [SizedBox()]
                  //         : state.result!
                  //             .map((e) => SearchWidget(tour: e))
                  //             .toList(),
                  //   )
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 0.6,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemCount: state.result==null?0:state.result!.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return SearchWidget(tour: state.result![index]);
                        }),
                  )
                  : Center(
                      child:
                          CircularProgressIndicator(color: Color(0xff00adef))),
            ),
          ),
        ),
      );
    });
  }
}
