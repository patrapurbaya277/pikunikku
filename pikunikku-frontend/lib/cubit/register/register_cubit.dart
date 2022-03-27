import 'dart:convert';
import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:intl/intl.dart';
import 'package:pikunikku/sources/api/API.dart';
import 'package:pikunikku/sources/model/avoider.dart';
import 'package:pikunikku/sources/model/kecamatan.dart';
import 'package:pikunikku/sources/model/kota.dart';
import 'package:pikunikku/sources/model/provinsi.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';
// import 'package:pikunikku/sources/api/url.dart';
// import 'package:http/http.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState());

  void init() => emit(RegisterState());

  void onEmailChanged(String value) => emit(state.copyWith(email: value));

  void onPasswordChanged(String value) => emit(state.copyWith(password: value));

  void onConfirmPasswordChanged(String value) =>
      emit(state.copyWith(confirmPassword: value));

  void accountConfirmation(bool check) =>
      emit(state.copyWith(accountTrue: check));

  void onNameChanged(String value) => emit(state.copyWith(name: value));

  void onGenderChanged(String value) {
    emit(state.copyWith(gender: value));
  }

  void updateBirthday(DateTime date) => emit(state.copyWith(birthday: date));

  void onPhoneNumberChanged(String value) =>
      emit(state.copyWith(phoneNumber: value));

  void identityConfirmation(bool check) =>
      emit(state.copyWith(identityTrue: check));

  // void onCityChanged(String value) {
  //   emit(state.copyWith(
  //     kecamatan: null,
  //     kelurahan: null,
  //     kodePos: null,
  //     listKecamatan: [],
  //     listKelurahan: [],
  //     listUniqueKecamatan: [],
  //   ));
  //   emit(state.copyWith(
  //     city: state.listCity!.firstWhere((element) => element.kota == value),
  //   ));
  //   getKecamatan();
  // }

  // void onProvinceChanged(String value) {
  //   emit(state.copyWith(
  //     city: null,
  //     kecamatan: null,
  //     kelurahan: null,
  //     kodePos: null,
  //     listCity: [],
  //     listKelurahan: [],
  //     listKecamatan: [],
  //     listUniqueKecamatan: [],
  //   ));
  //   emit(state.copyWith(
  //     province: state.listProvince!
  //         .firstWhere((element) => element.provinsi == value),
  //   ));
  //   getKota();
  // }

  // void onKecamatanChanged(String value) {
  //   emit(state.copyWith(
  //     kelurahan: null,
  //     kodePos: null,
  //     listKelurahan: [],
  //   ));
  //   emit(state.copyWith(
  //     kecamatan: value,
  //   ));
  //   getKelurahan();
  // }

  // void onKelurahanChanged(String value) {
  //   emit(state.copyWith(
  //       kelurahan: value,
  //       kodePos: state.listKecamatan!
  //           .firstWhere((element) => element.kelurahan == value)
  //           .kodepos));
  //   print(state.kelurahan);
  //   print(state.kodePos);
  // }

  // void onKodePosChanged(String value) => emit(state.copyWith(kodePos: value));

  // void onPostalCodeChanged(String value) =>
  //     emit(state.copyWith(postalCode: value));

  void onAddressChanged(String value) => emit(state.copyWith(address: value));

  void addressConfirmation(bool check) =>
      emit(state.copyWith(addressTrue: check));

  void nextProgress() => emit(state.copyWith(progress: state.progress! + 1));

  void beforeProgress() => emit(state.copyWith(progress: state.progress! - 1));

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
        ratioX: 1,
        ratioY: 1,
      ),
    );
    if (_croppedImage != null) {
      emit(state.copyWith(image: File(_croppedImage.path)));
    }

    // emit(state.copyWith(image: File(_croppedImage!.path)));
    // emit(state.copyWith(image: _croppedImage));
  }

  void registerMultipart(BuildContext context) async {
    // print(API.register.toString());
    Avoider avoider = Avoider();
    avoider.catchException(
      context: context,
      functionBreak: () {
        emit(state.copyWith(loading: false));
      },
      function: () async {
        emit(state.copyWith(loading: true));
        var request = http.MultipartRequest('POST', API.register);
        // request.files.add(await http.MultipartFile.fromPath('picture', image.path));
        if (state.image != null) {
          request.files.add(
            http.MultipartFile.fromBytes(
              'picture',
              state.image!.readAsBytesSync(),
              filename: state.image!.path,
            ),
          );
        }
        request.fields.addAll(
          {
            'nama': state.name.toString(),
            'no_hp': state.phoneNumber.toString(),
            'email': state.email,
            'password': state.confirmPassword,
            'alamat': state.address.toString(),
            'kota': state.kota.toString() + "(${state.kecamatan.toString()})",
            'provinsi': state.provinsi.toString(),
            'kode_pos': state.kodePos.toString(),
            'tgl_lahir': DateFormat("yyyy-MM-dd")
                .format(state.birthday ?? DateTime.now()),
            'jenis_kelamin': state.gender.toString(),
          },
        );
        var res = await request.send();
        var responseData = await res.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        print(responseString);
        if (responseString[0] == "{") {
          final jsonData = jsonDecode(responseString);
          if (res.statusCode == 200) {
            if (jsonData["status"] == true) {
              emit(state.copyWith(
                  status: jsonData["status"],
                  message: jsonData["msg"],
                  loading: false));
            } else {
              emit(state.copyWith(
                  status: jsonData["status"],
                  message: jsonData["msg"],
                  loading: false));
            }
          } else {
            emit(state.copyWith(
                status: jsonData["status"],
                message: jsonData["msg"],
                loading: false));
          }
        } else {
          emit(state.copyWith(status: false, message: "gagal", loading: false));
        }
      },
    );
  }

  void getProvinsi(context) async {
    Avoider avoider = Avoider();
    avoider.catchException(
        context: context,
        function: () async {
          http.Response response;
          response = await http.get(API.provinsi);
          // print(jsonData);
          final jsonData = jsonDecode(response.body.toString());
          Map<String, dynamic> data = jsonData;
          List<Provinsi> _listProvinsi = data.entries
              .map((e) => Provinsi(id: e.key, provinsi: e.value))
              .toList();
          emit(state.copyWith(listProvince: _listProvinsi));
        });
  }

  void getKota(context) async {
    Avoider avoider = Avoider();
    avoider.catchException(context: context, function: () {});
    http.Response response;
    response = await http.get(API.kota(state.province!.id.toString()));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body.toString());
      Map<String, dynamic> data = jsonData;
      List<Kota> _listKota =
          data.entries.map((e) => Kota(id: e.key, kota: e.value)).toList();
      emit(state.copyWith(
        listCity: _listKota,
      ));
    }
  }

  void getKecamatan(context) async {
    Avoider avoider = Avoider();
    avoider.catchException(
        context: context,
        function: () async {
          http.Response response;
          response = await http.get(API.kecamatan(state.city!.id.toString()));
          if (response.statusCode == 200 || response.statusCode == 201) {
            final jsonData = jsonDecode(response.body.toString());
            print(jsonData);
            List<Kecamatan> _listKecamatan = [];
            List<String> _listUnique = [];
            for (var item in jsonData) {
              Kecamatan kec = Kecamatan.fromJson(item);
              _listKecamatan.add(kec);
              _listUnique.add(kec.kecamatan.toString());
            }
            emit(state.copyWith(
                listUniqueKecamatan: _listUnique.toSet().toList(),
                listKecamatan: _listKecamatan));
          }
        });
  }

  void getKelurahan() {
    // emit(state.copyWith(listKelurahan: []));
    List<Kecamatan> _listKecamatan = state.listKecamatan!
        .where((element) => element.kecamatan == state.kecamatan)
        .toList();
    List<String> _listKelurahan = [];
    for (var item in _listKecamatan) {
      _listKelurahan.add(item.kelurahan.toString());
    }
    emit(state.copyWith(listKelurahan: _listKelurahan));
  }

  Widget listProvinsiContent(BuildContext context) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Scrollbar(
        isAlwaysShown: true,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: state.listProvince!.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: InkWell(
                child: Container(
                    child:
                        Text(state.listProvince![index].provinsi.toString())),
                onTap: () {
                  emit(state.copyWith(
                    province: state.listProvince![index],
                    provinsi: state.listProvince![index].provinsi,
                    kota: "",
                    listCity: [],
                    listUniqueKecamatan: [],
                    city: Kota(),
                    listKecamatan: [],
                    kecamatan: "",
                    listKelurahan: [],
                    kelurahan: "",
                    kodePos: "",
                  ));
                  getKota(context);
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget listKotaContent(BuildContext context) {
    print(state.listCity);
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Scrollbar(
        isAlwaysShown: true,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: state.listCity != null ? state.listCity!.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: InkWell(
                child: Text(state.listCity![index].kota.toString()),
                onTap: () {
                  emit(state.copyWith(
                    city: state.listCity![index],
                    kota: state.listCity![index].kota,
                    kecamatan: "",
                    listUniqueKecamatan: [],
                    listKecamatan: [],
                    listKelurahan: [],
                    kelurahan: "",
                    kodePos: "",
                  ));
                  getKecamatan(context);
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget listKecamatanContent(BuildContext context) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Scrollbar(
        isAlwaysShown: true,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: state.listUniqueKecamatan != null
              ? state.listUniqueKecamatan!.length
              : 0,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: InkWell(
                child: Text(state.listUniqueKecamatan![index]),
                onTap: () {
                  emit(state.copyWith(
                    kelurahan: "",
                    kodePos: "",
                    listKelurahan: [],
                  ));
                  emit(state.copyWith(
                    kecamatan: state.listUniqueKecamatan![index],
                  ));
                  getKelurahan();
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget listKelurahanContent(BuildContext context) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Scrollbar(
        isAlwaysShown: true,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount:
              state.listKelurahan != null ? state.listKelurahan!.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: InkWell(
                child: Text(state.listKelurahan![index]),
                onTap: () {
                  emit(
                    state.copyWith(
                        kelurahan: state.listKelurahan![index],
                        kodePos: state.listKecamatan!
                            .firstWhere((element) =>
                                element.kelurahan ==
                                state.listKelurahan![index])
                            .kodepos),
                  );
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
