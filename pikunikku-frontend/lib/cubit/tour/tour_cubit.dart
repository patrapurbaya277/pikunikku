import 'dart:convert';
import 'dart:io';
// import 'dart:io';
// import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:path_provider/path_provider.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:pikunikku/pages/tour_detail/screen/tour_detail.dart';
import 'package:pikunikku/pages/tour_paket/screen/tour_paket.dart';
import 'package:pikunikku/sources/api/API.dart';
import 'package:pikunikku/sources/model/paket.dart';
import 'package:pikunikku/sources/model/tour.dart';

part 'tour_state.dart';

class TourCubit extends Cubit<TourState> {
  TourCubit() : super(TourState());

  void getAllTour() async {
    http.Response response;
    try {
      response = await http.get(API.allTour);
      // print(response.body);
      final jsonData = jsonDecode((response.body).toString());
      if (response.statusCode == 200) {
        List<Tour> _listTour = [];
        for (var item in jsonData["data"]) {
          _listTour.add(Tour.fromJson(item));
        }
        _listTour = _listTour.where((element) => element.deparatureTime!.isAfter(DateTime.now())).toList();
        _listTour.sort((a, b) {
          return a.createdAt!.compareTo(DateTime.parse(b.createdAt.toString()));
        });
        emit(state.copyWith(
            allTour: _listTour,
            allTourLength: _listTour.length>5?5:_listTour.length,
            listTourDekatRumah: _listTour
                .where((element) => element.category == "theme-travel")
                .toList(),
            listTourPergiJauh: _listTour
                .where((element) => element.category == "tour-travel")
                .toList(),
            loadingData: false));
        // emit(state.copyWith(loadingData: false));
        print("all sukses");
      }
    } catch (e) {
      print("Error saat mendapatkan tour");
    }
  }

  void getTourDetail(BuildContext context, Tour tour) {
    emit(state.copyWith(singleTour: tour));
    getListPaket();
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => TourDetail()));
  }
  // void getDekatRumah() async {
  //   http.Response response;
  //   try {
  //     response = await http.get(API.dekatRumahTour);
  //     print(response.body);
  //     final jsonData = jsonDecode((response.body).toString());
  //     if (response.statusCode == 200) {
  //       List<Tour> _listTour = [];
  //       for (var item in jsonData["data"]) {
  //         _listTour.add(Tour.fromJson(item));
  //       }
  //       emit(state.copyWith(listTourDekatRumah: _listTour, listTourDekatRumahLength: 5));
  //       emit(state.copyWith(loadingData: false));
  //       print("dekat rumah sukses");
  //     }
  //   } catch (e) {
  //     print("Error saat mendapatkan tour");
  //   }
  // }

  // void getPergiJauh() async {
  //   http.Response response;
  //   try {
  //     response = await http.get(API.pergiJauhTour);
  //     print(response.body);
  //     final jsonData = jsonDecode((response.body).toString());
  //     if (response.statusCode == 200) {
  //       List<Tour> _listTour = [];
  //       for (var item in jsonData["data"]) {
  //         _listTour.add(Tour.fromJson(item));
  //       }
  //       emit(state.copyWith(listTourPergiJauh: _listTour, listTourPergiJauhLength: 5));
  //       emit(state.copyWith(loadingData: false));
  //       print("pergi jauh sukses");
  //     }
  //   } catch (e) {
  //     print("Error saat mendapatkan tour");
  //   }
  // }

  void getAllData() {
    emit(state.copyWith(loadingData: true));
    getAllTour();
    // getDekatRumah();
    // getPergiJauh();
    emit(state.copyWith(successGetData: true));
  }

  void downloadPdf(String url, String title, context) async {
    Dio dio = Dio();
    await Permission.storage.request();
    // final String path = downloadsDirectory.path;
    // final downloadPath = await path.getDownloadsDirectory();
    final downloadPath = Directory("/storage/emulated/0/Download/");
    print(downloadPath);
    var filePath = downloadPath.path + '/$title.pdf';
    print(filePath);
    await dio.download(url, filePath).then((value) {
      dio.close();
    });
    final snackBar = SnackBar(
        content:
            Text('File berhasil diunduh dan tersimpan di folder Downloads'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void getListPaket()async{
    emit(state.copyWith(loadingPaket: true, selectedListPaket: [],));
    http.Response response;
    try {
      response = await http.get(API.paket);
      print(response.body);
      final jsonData = jsonDecode((response.body).toString());
      if (response.statusCode == 200) {
        List<Paket> _listPaket = [];
        for (var item in jsonData["data"]) {
          _listPaket.add(Paket.fromJson(item));
        }
        emit(state.copyWith(listPaket: _listPaket,));
        List<Paket> _listSelectedPaket = List.from(_listPaket.where((element) => element.configPaketId==state.singleTour!.id));
        if(_listSelectedPaket.length!=0){
          emit(state.copyWith(hasFilteredData: true, selectedListPaket: _listSelectedPaket));
        }
        // emit(state.copyWith(loadingData: false));
        print("sukses get paket");
      }
    } catch (e) {
      print("Error saat mendapatkan paket");
    }
  }

  void showFilterPaket(context){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>PaketPage()));
  }
}
