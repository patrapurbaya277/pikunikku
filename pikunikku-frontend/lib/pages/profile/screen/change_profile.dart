// import 'dart:io';

// import 'dart:html';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pikunikku/cubit/edit_profile/edit_cubit.dart';
import 'package:pikunikku/cubit/user/user_cubit.dart';
import 'package:pikunikku/pages/profile/widgets/birthday_edit.dart';
import 'package:pikunikku/pages/profile/widgets/gender_edit.dart';
import 'package:pikunikku/pages/profile/widgets/location_edit.dart';
import 'package:pikunikku/pages/profile/widgets/profile_stat.dart';
import 'package:pikunikku/pages/register/widgets/register_field.dart';
import 'package:pikunikku/sources/api/url.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({Key? key}) : super(key: key);

  @override
  _ChangeProfileState createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  // FocusNode nameFocus = FocusNode();

  Future<bool> _onWillPop(EditState editState) async {
    if (editState.changed == true) {
      return await showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("Peringatan"),
                content:
                    Text("Apakah anda ingin menyimpan perubahan data profil ?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text("Batalkan")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        context.read<EditCubit>().setChanged(false);
                      },
                      child: Text("Tidak")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                        // context.read<EditCubit>().profileEdit(context);
                        context.read<EditCubit>().editProfile(context);
                        // context.read<EditCubit>().setChanged(false);
                      },
                      child: Text("Simpan")),
                ],
              ));
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // context.read<EditCubit>().initLocation();
    return BlocListener<EditCubit, EditState>(
      listener: (BuildContext context, editState) {
        if (editState.nama != editState.oldUser!.nama ||
            editState.jeniskelamin != editState.oldUser!.jenisKelamin ||
            editState.tglLahir != editState.oldUser!.tglLahir ||
            editState.noHp != editState.oldUser!.noHp ||
            editState.kodePos != editState.oldUser!.kodePos ||
            editState.alamat != editState.oldUser!.alamat||
            editState.image!=null
            ) {
          context.read<EditCubit>().setChanged(true);
        } else {
          context.read<EditCubit>().setChanged(false);
        }
      },
      child: BlocBuilder<EditCubit, EditState>(builder: (context, editState) {
        return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
          if (editState.changed == false) {
            context.read<EditCubit>().getProvinsi();
            context.read<EditCubit>().init(state.user!);
          }
          return WillPopScope(
            onWillPop: () => _onWillPop(editState),
            child: Stack(
              children: [
                Scaffold(
                  appBar: AppBar(
                    title: Text(
                      "Ubah Profil",
                      style: TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    leading: InkWell(
                      onTap: () {
                        if (editState.changed == true) {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text("Peringatan"),
                                    content: Text(
                                        "Apakah anda ingin menyimpan perubahan data profil ?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Batalkan")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            context
                                                .read<EditCubit>()
                                                .setChanged(false);
                                          },
                                          child: Text("Tidak")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            context
                                                .read<EditCubit>()
                                                .editProfile(context);
                                          },
                                          child: Text("Simpan")),
                                    ],
                                  ));
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: editState.changed == true
                      ? Container(
                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff00adef)),
                            ),
                            onPressed: () {
                              // context.read<EditCubit>().profileEdit(context);
                              context.read<EditCubit>().editProfile(context);
                            },
                            child: Text("Simpan"),
                          ),
                        )
                      : SizedBox(),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                  height: 150,
                                  width: 150,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: Color(0xff00adef)),
                                      image: editState.image==null?editState.oldUser!.picture=="null"?DecorationImage(
                                          image: AssetImage(
                                            "assets/images/user_default.png",
                                          ),
                                          fit: BoxFit.cover):null:null),
                                  child: editState.oldUser!.picture != "null"
                                      ? editState.image != null
                                          ? Image.file(
                                              File(editState.image!.path))
                                          : Image.network(
                                              URL.imageProfile +
                                                  state.user!.picture,
                                              fit: BoxFit.cover)
                                      : SizedBox()),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    context
                                        .read<EditCubit>()
                                        .pickImage(context);
                                  },
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff00ADEF)),
                                    child: Icon(
                                      Icons.photo_camera_outlined,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ProfileStat(
                          label: "Nama",
                          value: editState.nama,
                          onTap: () {
                            context.read<EditCubit>().changeNama(
                                  context,
                                  editState.nama,
                                );
                          },
                          // focusNode: nameFocus,
                        ),
                        // ProfileStat(
                        //     label: "Jenis Kelamin",
                        //     value: editState.jeniskelamin),
                        GenderEdit(),
                        BirthdayEdit(),
                        ProfileStat(
                            label: "Nomor Handphone",
                            value: editState.noHp,
                            onTap: () {
                              context
                                  .read<EditCubit>()
                                  .changeNoHp(context, editState.noHp);
                            }),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lokasi",
                              style: TextStyle(
                                  color: Color(0xff00adef), fontSize: 21),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 15),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "${editState.kota} ${editState.kodePos}, ${editState.provinsi}",
                                    textAlign: TextAlign.start,
                                  )),
                                  Expanded(
                                      child: editState.listProvince != null
                                          ? ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Color(0xff00ADEF))),
                                              onPressed: () {
                                                context
                                                    .read<EditCubit>()
                                                    .changeLocationMode(true);
                                              },
                                              child: Text(
                                                "Ubah Data Lokasi",
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : SizedBox())
                                ],
                              ),
                            ),
                            ProfileStat(
                              label: "Alamat",
                              onTap: () {
                                context
                                    .read<EditCubit>()
                                    .changeAlamat(context, editState.alamat);
                              },
                              value: editState.alamat,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 70,
                        )
                      ],
                    ),
                  ),
                ),
                editState.changeLocation == false
                    ? SizedBox()
                    : Scaffold(
                        backgroundColor: Colors.black.withOpacity(0.5),
                        body: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            margin: EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LocationEdit(
                                  defaultValue: "Pilih Provinsi",
                                  label: "Provinsi",
                                  value: editState.provinsiTemp != null &&
                                          editState.provinsiTemp != ""
                                      ? editState.province!.provinsi
                                      : "Pilih Provinsi",
                                  buildContent: context
                                      .read<EditCubit>()
                                      .listProvinsiContent(context),
                                  showButton: true,
                                ),
                                LocationEdit(
                                  defaultValue: "Pilih Kota/Kabupaten",
                                  label: "Kota/Kabupaten",
                                  value: editState.kotaTemp != null &&
                                          editState.kotaTemp != ""
                                      ? editState.city!.kota
                                      : "Pilih Kota/Kabupaten",
                                  buildContent: context
                                      .read<EditCubit>()
                                      .listKotaContent(context),
                                  showButton: editState.provinsiTemp != "" &&
                                          editState.listCity != null &&
                                          editState.listCity!.length != 0
                                      ? true
                                      : false,
                                ),
                                LocationEdit(
                                  defaultValue: "Pilih Kecamatan",
                                  label: "Kecamatan",
                                  value: editState.kecamatanTemp ??
                                      "Pilih Kecamatan",
                                  buildContent: context
                                      .read<EditCubit>()
                                      .listKecamatanContent(context),
                                  showButton: editState.kotaTemp != "" &&
                                          editState.listKecamatan != null &&
                                          editState.listKecamatan!.length != 0
                                      ? true
                                      : false,
                                ),
                                LocationEdit(
                                  defaultValue: "Pilih Kelurahan",
                                  label: "Kelurahan",
                                  value: editState.kelurahanTemp,
                                  buildContent: context
                                      .read<EditCubit>()
                                      .listKelurahanContent(context),
                                  showButton: editState.kecamatanTemp != "" &&
                                          editState.kecamatan != null &&
                                          editState.kecamatan != ""
                                      ? true
                                      : false,
                                ),
                                RegisterField(
                                  label: "Kode Pos",
                                  color: Color(0xff00adef),
                                  showField: false,
                                  text: editState.kodePosTemp != null &&
                                          editState.kodePosTemp != ""
                                      ? editState.kodePosTemp
                                      : "(Akan terisi secara otomatis)",
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            context
                                                .read<EditCubit>()
                                                .changeLocationMode(false);
                                          },
                                          child: Text("Batal")),
                                      TextButton(
                                        style: ButtonStyle(
                                            overlayColor:
                                                editState.kodePosTemp == ""
                                                    ? MaterialStateProperty.all(
                                                        Colors.transparent)
                                                    : null),
                                        onPressed: () {
                                          if (editState.kodePosTemp != "") {
                                            context
                                                .read<EditCubit>()
                                                .changeLocation();
                                            context
                                                .read<EditCubit>()
                                                .changeLocationMode(false);
                                          }
                                        },
                                        child: Text("Simpan",
                                            style: TextStyle(
                                              color: editState.kodePosTemp == ""
                                                  ? Colors.grey
                                                  : Colors.blue,
                                            )),
                                      )
                                    ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                editState.saving == true
                    ? Scaffold(
                        backgroundColor: Colors.black.withOpacity(0.8),
                        body: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Colors.white,
                              ),
                              Text(
                                "Sedang Menyimpan",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          );
        });
      }),
    );
  }
}
