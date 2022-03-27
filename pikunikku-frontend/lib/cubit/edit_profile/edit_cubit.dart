// import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:intl/intl.dart';
// import 'package:pikunikku/cubit/user/user_cubit.dart';
import 'package:pikunikku/sources/api/API.dart';
import 'package:pikunikku/sources/model/avoider.dart';
import 'package:pikunikku/sources/model/kecamatan.dart';
import 'package:pikunikku/sources/model/kota.dart';
import 'package:pikunikku/sources/model/provinsi.dart';
import 'package:pikunikku/sources/model/user.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_state.dart';

class EditCubit extends Cubit<EditState> {
  EditCubit() : super(EditState());
  final Avoider avoider = Avoider();
  void initPassword() {
    emit(state.initEditPassword());
  }

  void visiblePassword() {
    bool current = state.hidePassword ?? false;
    if (current == true) {
      emit(state.copyWith(hidePassword: false));
    } else {
      emit(state.copyWith(hidePassword: true));
    }
  }

  void ubahPassword(context) {
    avoider.catchException(
        context: context,
        function: () async {
          emit(state.copyWith(loading: true));
          SharedPreferences pref = await SharedPreferences.getInstance();
          String? token = pref.getString("token");
          http.Response response;
          response = await http.put(API.editPassword,
              headers: {
                "Authorization": "Bearer $token",
                "Content-type": "application/x-www-form-urlencoded",
              },
              encoding: Encoding.getByName("utf-8"),
              body: {
                'password': state.newPassword.toString(),
                'password_confirmation': state.confirmPassword.toString(),
              });
          print(response.body);
          if (response.body.toString().split("").toList()[0] == "{") {
            final jsonData = jsonDecode((response.body).toString());
            if (response.statusCode == 200) {
              if (jsonData["status"] == "success") {
                emit(state.copyWith(loading: false));
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Password berhasil diubah")));
              }
            } else {
              emit(state.copyWith(loading: false));
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Gagal")));
            }
          } else {
            emit(state.copyWith(loading: false));
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Gagal")));
          }
        });
  }

  void verifikasiPassword(context) {
    avoider.catchException(
        context: context,
        functionBreak: () {
          emit(state.copyWith(loading: false));
        },
        function: () async {
          emit(state.copyWith(loading: true));
          // emit(state.copyWith(loading: true));
          if (state.password!.length < 6) {
            emit(state.copyWith(loading: false));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              "Password tidak boleh kurang dari 6 karakter",
              textAlign: TextAlign.center,
            )));
          } else {
            http.Response response;
            response = await http.post(API.login, body: {
              'email': state.oldUser!.email,
              'password': state.password
            });
            print(response.body);
            final jsonData = jsonDecode((response.body).toString());
            if (response.statusCode == 200) {
              if (jsonData["status"] == true) {
                emit(state.copyWith(
                    passwordFase: 1, loading: false, hidePassword: true));
              } else {
                emit(state.copyWith(loading: false));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  "Password Salah",
                  textAlign: TextAlign.center,
                )));
              }
            } else {
              emit(state.copyWith(loading: false));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                "Password Salah",
                textAlign: TextAlign.center,
              )));
            }
          }
        });
  }

  void setChanged(bool mode) {
    emit(state.copyWith(changed: mode));
  }

  void changeLocationMode(mode) {
    emit(state.copyWith(changeLocation: mode));
    if (mode == false) {
      initLocation();
    }
    // initLocation();
  }

  void initLocation() {
    emit(state.copyWith(
      listProvince: [],
      province: null,
      provinsiTemp: "",
      kotaTemp: "",
      listCity: [],
      listUniqueKecamatan: [],
      city: Kota(),
      listKecamatan: [],
      kecamatanTemp: "",
      listKelurahan: [],
      kelurahanTemp: "",
      kodePosTemp: "",
    ));
  }

  void init(User user) {
    emit(state.copyWith(
      oldUser: user,
      nama: user.nama,
      noHp: user.noHp,
      jeniskelamin: user.jenisKelamin,
      tglLahir: user.tglLahir,
      provinsi: user.provinsi,
      kota: user.kota,
      kodePos: user.kodePos,
      alamat: user.alamat,
      changed: false,
      saving: state.saving ?? false,
    ));
    emit(state.nullImage());
  }

  void update(User user) {
    emit(state.copyWith(oldUser: user));
  }

  // void cancelEdit() {
  //   emit(state.copyWith(nama: state.oldUser!.nama, changed: false,));
  // }

  void selectBirthday(DateTime selected) {
    emit(state.copyWith(tglLahir: selected));
  }

  void changeText(BuildContext context, Function function,
      TextEditingController controller) async {
    showDialog(
        context: context,
        builder: (_) => Align(
              alignment: Alignment.bottomCenter,
              child: AlertDialog(
                contentPadding: EdgeInsets.only(left: 15, right: 15, top: 15),
                buttonPadding: EdgeInsets.only(right: 15, top: 0),
                content: TextFormField(
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xff00adef), width: 2))),
                  controller: controller,
                  autofocus: true,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Batal",
                        style: TextStyle(color: Color(0xff00adef)),
                      )),
                  TextButton(
                      onPressed: () {
                        function();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Simpan",
                        style: TextStyle(color: Color(0xff00adef)),
                      )),
                ],
              ),
            ));
  }

  void changeNama(context, init) {
    TextEditingController controller = TextEditingController();
    controller.text = init;
    function() {
      emit(state.copyWith(nama: controller.text));
    }

    changeText(context, function, controller);
  }

  void changeNoHp(context, init) {
    TextEditingController controller = TextEditingController();
    controller.text = init;
    function() {
      emit(state.copyWith(noHp: controller.text));
    }

    changeText(context, function, controller);
  }

  void onGenderChanged(String value) {
    emit(state.copyWith(jeniskelamin: value));
    print(state.jeniskelamin);
  }

  void onTglLahirChanged(DateTime value) =>
      emit(state.copyWith(tglLahir: value));

  void changeLocation() {
    emit(state.copyWith(
        provinsi: state.provinsiTemp,
        kota: state.kotaTemp! + "(${state.kecamatan.toString()})",
        kodePos: state.kodePosTemp));
  }

  void changeAlamat(context, init) {
    TextEditingController controller = TextEditingController();
    controller.text = init;
    function() {
      emit(state.copyWith(alamat: controller.text));
    }

    changeText(context, function, controller);
  }

  void onPasswordChanged(String value) => emit(state.copyWith(password: value));
  void onNewPasswordChanged(String value) =>
      emit(state.copyWith(newPassword: value));
  void onConfirmPasswordChanged(String value) =>
      emit(state.copyWith(confirmPassword: value));

  // void profileEdit(BuildContext context) {
  //   Avoider avoider = Avoider();
  //   avoider.catchException(
  //       context: context,
  //       functionBreak: () {
  //         emit(state.copyWith(saving: false));
  //       },
  //       function: () async {
  //         emit(state.copyWith(saving: true));
  //         SharedPreferences pref = await SharedPreferences.getInstance();
  //         String? token = pref.getString("token");
  //         http.Response response;
  //         response = await http.put(API.editProfile,
  //             headers: {
  //               "Authorization": "Bearer $token",
  //               "Content-type": "application/x-www-form-urlencoded",
  //             },
  //             encoding: Encoding.getByName("utf-8"),
  //             body: {
  //               'nama': state.nama.toString(),
  //               'no_hp': state.noHp.toString(),
  //               'alamat': state.alamat.toString(),
  //               'kota': state.kota.toString(),
  //               'provinsi': state.provinsi.toString(),
  //               'kode_pos': state.kodePos.toString(),
  //               'tgl_lahir': DateFormat("yyyy-MM-dd")
  //                   .format(state.tglLahir ?? DateTime.now()),
  //               'jenis_kelamin': state.jeniskelamin.toString(),
  //             });
  //         print(response.body);
  //         // if(response.body){}
  //         if (response.body.toString().split("").toList()[0] == "{") {
  //           final jsonData = jsonDecode((response.body).toString());
  //           if (response.statusCode == 200) {
  //             if (jsonData["status"] == true) {
  //               print("sukses edit");
  //               User user = User.fromJson(jsonData["data"]);
  //               init(user);
  //               emit(state.copyWith(saving: false,));

  //               context.read<UserCubit>().updateuser(context);
  //             }
  //           } else {
  //             emit(state.copyWith(saving: false));
  //             print("Statuscode tidak 200");
  //           }
  //         } else {
  //           emit(state.copyWith(saving: false));
  //           ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text("Gagal Menyimpan Perubahan")));
  //           print("Gagal");
  //         }
  //       });
  // }

  void editProfile(BuildContext context) {
    avoider.catchException(
        context: context,
        functionBreak: () {
          emit(state.copyWith(saving: false));
        },
        function: () async {
          emit(state.copyWith(saving: true));
          SharedPreferences pref = await SharedPreferences.getInstance();
          var request = http.MultipartRequest(
            'POST',
            API.editProfile,
          );
          request.headers
              .addAll({"Authorization": "Bearer ${pref.getString("token")}"});
          if (state.image != null) {
            request.files.add(
              http.MultipartFile.fromBytes(
                'picture',
                state.image!.readAsBytesSync(),
                filename: state.image!.path.split("/").last,
              ),
            );
          }
          request.fields.addAll(
            {
              'nama': state.nama.toString(),
              'no_hp': state.noHp.toString(),
              'alamat': state.alamat.toString(),
              'kota': state.kota.toString(),
              'provinsi': state.provinsi.toString(),
              'kode_pos': state.kodePos.toString(),
              'tgl_lahir': DateFormat("yyyy-MM-dd")
                  .format(state.tglLahir ?? DateTime.now()),
              'jenis_kelamin': state.jeniskelamin.toString(),
            },
          );
          var res = await request.send();
          var responseData = await res.stream.toBytes();
          var responseString = String.fromCharCodes(responseData);
          print(responseString);
          if (res.statusCode == 200) {
            if (responseString[0] != "<") {
              final jsonData = jsonDecode(responseString);
              User user = User.fromJson(jsonData["data"]);
              // emit(state.nullImage());

              Timer(Duration(seconds: 4), () {
                init(user);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Tersimpan")));
                emit(state.copyWith(saving: false));
              });
            } else {
              print(responseString);
              emit(state.copyWith(saving: false));
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("API Bermasalah")));
            }
            // init(state.)

            // context.read<UserCubit>().updateuser(context);
          } else {
            print(responseString);
            emit(state.copyWith(saving: false));
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Gagal Menyimpan")));
          }
        });
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
        ratioX: 1,
        ratioY: 1,
      ),
    );
    if (_image != null) {
      emit(state.copyWith(image: File(_croppedImage!.path)));
    }

    // emit(state.copyWith(image: File(_croppedImage!.path)));
    // emit(state.copyWith(image: _croppedImage));
  }

  void getProvinsi() async {
    http.Response response;
    response = await http.get(API.provinsi);
    // print(jsonData);
    final jsonData = jsonDecode(response.body.toString());
    Map<String, dynamic> data = jsonData;
    List<Provinsi> _listProvinsi = data.entries
        .map((e) => Provinsi(id: e.key, provinsi: e.value))
        .toList();
    emit(state.copyWith(listProvince: _listProvinsi));
  }

  void getKota() async {
    // emit(state.copyWith(listCity: []));
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

  void getKecamatan() async {
    // emit(state.copyWith(listUniqueKecamatan: []));
    http.Response response;
    response = await http.get(API.kecamatan(state.city!.id.toString()));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = jsonDecode(response.body.toString());
      // print(jsonData);
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
  }

  void getKelurahan() {
    // emit(state.copyWith(listKelurahan: []));
    List<Kecamatan> _listKecamatan = state.listKecamatan!
        .where((element) => element.kecamatan == state.kecamatanTemp)
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
                    provinsiTemp: state.listProvince![index].provinsi,
                    kotaTemp: "",
                    listCity: [],
                    listUniqueKecamatan: [],
                    city: Kota(),
                    listKecamatan: [],
                    kecamatanTemp: "",
                    listKelurahan: [],
                    kelurahanTemp: "",
                    kodePosTemp: "",
                  ));
                  if (state.changeLocation == true) {
                    getKota();
                  }
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
                    kotaTemp: state.listCity![index].kota,
                    kecamatanTemp: "",
                    listUniqueKecamatan: [],
                    listKecamatan: [],
                    listKelurahan: [],
                    kelurahanTemp: "",
                    kodePosTemp: "",
                  ));
                  if (state.changeLocation == true) {
                    getKecamatan();
                  }

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
                    kelurahanTemp: "",
                    kodePosTemp: "",
                    listKelurahan: [],
                    kecamatanTemp: state.listUniqueKecamatan![index],
                  ));
                  if (state.changeLocation == true) {
                    getKelurahan();
                  }
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
                        kelurahanTemp: state.listKelurahan![index],
                        kodePosTemp: state.listKecamatan!
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
