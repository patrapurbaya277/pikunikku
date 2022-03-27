import 'dart:convert';

import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/sources/api/API.dart';
import 'package:http/http.dart' as http;
import 'package:pikunikku/sources/model/avoider.dart';
import 'package:pikunikku/sources/model/testimoni.dart';

part 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  AboutCubit() : super(AboutState());
  final Avoider avoider = Avoider();
  

  void init(){
    emit(state.copyWith(index: 0,));
  }

  void nextMenu(){
    if(state.index! < state.maxMenu-1)
    emit(state.copyWith(index: state.index!+1));
  }
  void previousMenu(){
    if(state.index! > 0)
    emit(state.copyWith(index: state.index!-1));
  }

  void getTestimoni(context) {
    avoider.catchException(
        context: context,
        function: () async {
          http.Response response;
          response = await http.get(API.testimoni);
          final jsonData = jsonDecode((response.body).toString());
          if (response.statusCode == 200) {
            List<Testimoni> _listTestimoni = [];
            for (var item in jsonData["data"]) {
              _listTestimoni.add(Testimoni.fromJson(item));
            }
            emit(state.copyWith(
              listTestimoni: _listTestimoni
            ));
            print("sukses get testimoni");
          }
        });
  }
}
