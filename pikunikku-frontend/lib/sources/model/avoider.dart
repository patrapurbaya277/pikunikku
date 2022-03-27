import 'dart:async';
import 'dart:io';

// import 'package:flutter/cupertino.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
// import 'package:pikunikku/sources/model/user.dart';

class Avoider {
  void catchException({
    required BuildContext context,
    required Function function,
    Function? functionBreak,
  }) async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        function();
      } else {
        connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) {
          function();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Tidak ada koneksi internet", textAlign: TextAlign.center,),
        ));
        }
      }
    } on SocketException catch (e) {
      if (functionBreak != null) {
        functionBreak();
      }
      print("Tes" + e.toString());
      throw ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Tidak ada koneksi internet")));
    } on TimeoutException {
      if (functionBreak != null) {
        functionBreak();
      }
      throw ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Jaringan bermasalah, harap coba lagi")));
    } on FormatException {
      if (functionBreak != null) {
        functionBreak();
      }
      throw ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Tipe data tidak sesuai")));
    } on BadKeyException {
      if (functionBreak != null) {
        functionBreak();
      }
      throw ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error pada API")));
    } on HttpException {
      if (functionBreak != null) {
        functionBreak();
      }
    } catch (e) {
      if (functionBreak != null) {
        functionBreak();
      }
      print(e);
      throw ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
