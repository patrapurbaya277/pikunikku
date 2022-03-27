// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/sources/api/API.dart';
import 'package:pikunikku/sources/model/avoider.dart';
import 'package:pikunikku/sources/model/tour.dart';
import 'package:http/http.dart' as http;

part 'searchstate.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState());

  void init() => emit(SearchState());

  void onKeyChanged(String value)=>emit(state.copyWith(key: value));

  void searchTour(context) {
    Avoider avoider = Avoider();
    avoider.catchException(
        context: context,
        functionBreak: (){
          emit(state.copyWith(loading: false));
        },
        function: () async {
          emit(state.copyWith(loading: true, result: [],));
          http.Response response;
          response = await http.get(API.searchTour(state.key.toString()));
          // print(response.body);
          final jsonData = jsonDecode((response.body).toString());
          if (response.statusCode == 200) {
            List<Tour> _listTour = [];
            for (var item in jsonData["data"]) {
              _listTour.add(Tour.fromJson(item));
            }
            _listTour = _listTour
                .where((element) =>
                    element.deparatureTime!.isAfter(DateTime.now()))
                .toList();
            _listTour.sort((a, b) {
              return a.createdAt!
                  .compareTo(DateTime.parse(b.createdAt.toString()));
            });
            emit(state.copyWith(
                result: _listTour,
                loading: false));
            // emit(state.copyWith(loadingData: false));
            print("all sukses");
          }
        });
  }
}
