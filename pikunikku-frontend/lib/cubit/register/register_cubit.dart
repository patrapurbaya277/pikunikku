import 'dart:convert';
import 'dart:io';

// import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:intl/intl.dart';
import 'package:pikunikku/sources/api/API.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
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

  void onGenderChanged(String value) => emit(state.copyWith(gender: value));

  void updateBirthday(DateTime date) => emit(state.copyWith(birthday: date));

  void onPhoneNumberChanged(String value) =>
      emit(state.copyWith(phoneNumber: value));

  void identityConfirmation(bool check) =>
      emit(state.copyWith(identityTrue: check));

  void onCityChanged(String value) => emit(state.copyWith(city: value));

  void onProvinceChanged(String value) => emit(state.copyWith(province: value));

  void onPostalCodeChanged(String value) =>
      emit(state.copyWith(postalCode: value));

  void onAddressChanged(String value) => emit(state.copyWith(address: value));

  void addressConfirmation(bool check) =>
      emit(state.copyWith(addressTrue: check));

  void nextProgress() => emit(state.copyWith(progress: state.progress! + 1));

  void beforeProgress() => emit(state.copyWith(progress: state.progress! - 1));

  void pickImage(BuildContext context) async {
    var _image = await ImagePickerGC.pickImage(
      source: ImgSource.Both,
      context: context,
      cameraText: Text(
        "Dari Kamera",
        style: TextStyle(color: Colors.red),
      ),
      galleryText: Text(
        "Dari Galeri",
        style: TextStyle(color: Colors.blue),
      ),
    );
    File? _croppedImage = await ImageCropper.cropImage(
      sourcePath: _image.path,
      aspectRatio: CropAspectRatio(
        ratioX: 1,
        ratioY: 1,
      ),
    );

    emit(state.copyWith(image: _croppedImage));
  }

  void registerMultipart(BuildContext context) async {
    print(API.register.toString());
    emit(state.copyWith(loading: true));
    try {
      var request = http.MultipartRequest('POST', API.register);
      // request.files.add(await http.MultipartFile.fromPath('picture', image.path));
      request.files.add(
        http.MultipartFile.fromBytes(
          'picture',
          File(state.image!.path).readAsBytesSync(),
          filename: state.image!.path.split("/").last,
        ),
      );
      print(state.image!.path);
      print(state.image!.path.split("/").last);
      print("picture type :" + state.image!.runtimeType.toString());
      request.fields.addAll(
        {
          'nama': state.name.toString(),
          'no_hp': state.phoneNumber.toString(),
          'email': state.email,
          'password': state.confirmPassword,
          'alamat': state.address.toString(),
          'kota': state.city.toString(),
          'provinsi': state.province.toString(),
          'kode_pos': state.postalCode.toString(),
          'tgl_lahir':
              DateFormat("yyyy-MM-dd").format(state.birthday ?? DateTime.now()),
          'jenis_kelamin': state.gender.toString(),
        },
      );
      var res = await request.send();

      var responseData = await res.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print(responseString);
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
        print(responseString);
        print(responseString.runtimeType);
      } else {
        emit(state.copyWith(
            status: jsonData["status"],
            message: jsonData["msg"],
            loading: false));
      }
      // var responseString = String.fromCharCodes(responseData);
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(exception.toString())));
      emit(state.copyWith(loading: false, message: "Terjadi Kesalahan"));
    }
  }

  // void register() async {
  //   emit(state.copyWith(loading: true));
  //   http.Response response;
  //   try {
  //     response = await http.post(
  //       API.register,
  //       body: {
  //         'nama': state.name,
  //         'no_hp': state.phoneNumber,
  //         'email': state.email,
  //         'password': state.confirmPassword,
  //         'alamat': state.address,
  //         'kota': state.city,
  //         'provinsi': state.province,
  //         'kode_pos': state.postalCode,
  //         'tgl_lahir':
  //             DateFormat("yyyy-MM-dd").format(state.birthday ?? DateTime.now()),
  //         'jenis_kelamin': state.gender,
  //       },
  //     );
  //     print(response.body);
  //     final jsonData = jsonDecode((response.body).toString());
  //     if (response.statusCode == 200) {
  //       if (jsonData["status"] == true) {
  //         emit(state.copyWith(
  //             status: jsonData["status"],
  //             message: jsonData["msg"],
  //             loading: false));
  //       } else {
  //         emit(state.copyWith(
  //             status: jsonData["status"],
  //             message: jsonData["msg"],
  //             loading: false));
  //       }
  //     } else {
  //       emit(state.copyWith(
  //           status: jsonData["status"],
  //           message: jsonData["msg"],
  //           loading: false));
  //     }
  //   } catch (e) {
  //     print("Error saat register");
  //   }
  // }
}
