
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/pages/tour_paket/screen/tour_paket.dart';
import 'package:pikunikku/sources/api/API.dart';
import 'package:pikunikku/sources/model/paket.dart';

part 'paket_state.dart';

class PaketCubit extends Cubit<PaketState> {
  PaketCubit() : super(PaketState());

  void init(){
    emit(PaketState());
  }
  
  void getListPaket()async{
    http.Response response;
    try {
      response = await http.get(API.paket);
      print(response.body);
      final jsonData = jsonDecode((response.body).toString());
      if (response.statusCode == 200) {
        List<Paket> _listTour = [];
        for (var item in jsonData["data"]) {
          _listTour.add(Paket.fromJson(item));
        }
        emit(state.copyWith(listPaket: _listTour,));
        if(_listTour.where((element) => element.configPaketId==state.filter).length!=0){
          emit(state.copyWith(hasFilteredData: true));
        }
        // emit(state.copyWith(loadingData: false));
        print("sukses get paket");
      }
    } catch (e) {
      print("Error saat mendapatkan paket");
    }
  }

  void showFilterPaket(String? id, context){
    emit(state.copyWith(filter: id));
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>PaketPage()));
  }
  
}