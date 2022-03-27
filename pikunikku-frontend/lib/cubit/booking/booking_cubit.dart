import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:pikunikku/pages/booking/screens/booking_page.dart';
import 'package:pikunikku/sources/api/API.dart';
import 'package:http/http.dart' as http;
import 'package:pikunikku/sources/model/avoider.dart';
import 'package:pikunikku/sources/model/book_data.dart';
import 'package:pikunikku/sources/model/paket.dart';
// import 'package:pikunikku/sources/model/testimoni.dart';
import 'package:pikunikku/sources/model/tour.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingState());
  final Avoider avoider = Avoider();

  void init() {
    emit(BookingState());
  }

  void setCanBook(bool value) {
    emit(state.copyWith(canBook: value));
  }

  void tambah() {
    emit(state.copyWith(jumlah: state.jumlah! + 1));
  }

  void kurang() {
    emit(state.copyWith(jumlah: state.jumlah! - 1));
  }

  void onMetodeChanged(String value) {
    emit(state.copyWith(metode: value));
  }

  void book(BuildContext context) async {
    // print(API.register.toString());
    Avoider avoider = Avoider();
    avoider.catchException(
      context: context,
      functionBreak: () {
        emit(state.copyWith(loading: false));
      },
      function: () async {
        emit(state.copyWith(loading: true));
        SharedPreferences pref = await SharedPreferences.getInstance();
        String? token = pref.getString("token");
        var request = http.MultipartRequest('POST', API.book);
        request.headers.addAll({"Authorization": "Bearer $token"});
        // request.files.add(await http.MultipartFile.fromPath('picture', image.path));
        request.files.add(
          http.MultipartFile.fromBytes(
            'ktp_sim',
            state.image!.readAsBytesSync(),
            filename: state.image!.path.split("/").last,
          ),
        );
        request.fields.addAll(
          {
            'config_paket_id': state.paket!.configPaketId.toString(),
            'paket_id': state.paket!.id.toString(),
            'total_people': state.jumlah.toString(),
            'model_pembayaran': state.metode.toString(),
            'bank_select': 'manual_transfer_bank',
          },
        );
        var res = await request.send();
        var responseData = await res.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        print(responseString.toString());
        // final jsonData = jsonDecode(responseString);
        // print(jsonData);
        if (res.statusCode == 200) {
          final jsonData = jsonDecode(responseString);
          if (jsonData["status"] == "success") {
            emit(
              state.copyWith(
                // loading: false,
                bookData: BookData.fromJson(jsonData["data"]),
              ),
            );
            if (state.loading == true && state.bookData != null) {
              emit(state.copyWith(
                loading: false,
                bookStatus: true,
              ));
            }
          } else {
            emit(
              state.copyWith(
                loading: false,
                message: jsonData["msg"],
                // bookData: BookData.fromJson(jsonData["data"]),
                // bookStatus: true,
              ),
            );
          }

          //   if (jsonData["status"] == true) {
          //     Navigator.of(context).pop();
          //     // print(jsonData.toString());
          //     // emit(state.copyWith(
          //     //     status: jsonData["status"],
          //     //     message: jsonData["msg"],
          //     //     loading: false));
          //   } else {
          //     // print(jsonData.toString());
          //     // emit(state.copyWith(
          //     //     status: jsonData["status"],
          //     //     message: jsonData["msg"],
          //     //     loading: false));
          //   }
          //   // print(responseString);
          //   // print(responseString.runtimeType);
          // } else {
          //   // print(jsonData.toString());
          //   // emit(state.copyWith(
          //   //     status: jsonData["status"],
          //   //     message: jsonData["msg"],
          //   //     loading: false));
        }
      },
    );
  }

  void pickImage(BuildContext context) async {
    var _image = await ImagePickerGC.pickImage(
      source: ImgSource.Both,
      context: context,
      galleryIcon: Icon(Icons.image, color: Color(0xff00adef)),
      cameraIcon: Icon(Icons.camera_alt, color: Color(0xff00adef)),
      barrierDismissible: true,
      cameraText: Text(
        "Dari Kamera",
        style: TextStyle(color: Colors.black),
      ),
      galleryText: Text(
        "Dari Galeri",
        style: TextStyle(color: Colors.black),
      ),
    );
    File? _croppedImage = await ImageCropper.cropImage(
      sourcePath: _image.path,
      aspectRatio: CropAspectRatio(
        ratioX: 2,
        ratioY: 1,
      ),
    );
    if (_croppedImage != null) {
      emit(state.copyWith(image: File(_croppedImage.path)));
    }
  }

  void preBook(String idTour, int idPaket, context) {
    avoider.catchException(
      context: context,
      function: () async {
        http.Response response;
        SharedPreferences pref = await SharedPreferences.getInstance();
        String? token = pref.getString("token");
        response = await http.post(
          API.preBook,
          body: {'id': idTour, 'paket_id': idPaket.toString()},
          headers: {
            "Authorization": "Bearer $token",
          },
        );
        // print(response.body);
        final jsonData = jsonDecode((response.body).toString());
        if (response.statusCode == 200) {
          if (jsonData["status"] == "success") {
            Tour _tour = Tour.fromJson(jsonData["tour"]);
            Paket _paket = Paket.fromJson(jsonData["paket"]);
            emit(state.copyWith(tour: _tour, paket: _paket));
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Color(0xff00adef),
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarColor: Color(0xff00adef),
              systemNavigationBarIconBrightness: Brightness.light,
            ));
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => BookingPage()));
          }
        }
      },
    );
  }

  void listBookData(context) {
    avoider.catchException(
      context: context,
      function: () async {
        http.Response response;
        SharedPreferences pref = await SharedPreferences.getInstance();
        String? token = pref.getString("token");
        response = await http.get(
          API.listBook,
          headers: {
            "Authorization": "Bearer $token",
          },
        );
        // print(response.body);
        
        if (response.statusCode == 200) {
          final jsonData = jsonDecode((response.body).toString());
          if (jsonData["status"] == "success") {
            List<BookData> _list = [];
            for (var item in jsonData["data"]) {
              _list.add(BookData.fromJson(item));
            }
            emit(state.copyWith(listBookData: _list));
          }
        }
      },
    );
  }

  void bookDetail(String? data){
    emit(state.copyWith(bookDetail: state.listBookData!.firstWhere((element) => element.uuid==data)));
  }
}
