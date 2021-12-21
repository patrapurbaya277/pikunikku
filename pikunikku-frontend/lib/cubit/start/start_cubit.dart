// import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'start_state.dart';

class StartCubit extends Cubit<StartState> {
  StartCubit() : super(StartState());

  

  void checkAvailability() {
    emit(state.copyWith(
      checkProgress: "Checking Connection",
      checkingConnection: true,
    ));
    // checkConnection();
    if(state.connectionAvailable==true){
      emit(state.copyWith(checkingConnection: false, checkProgress: "Checking User Availability", checkingToken: true));

    }else{
      emit(state.copyWith(checkingConnection: false));
    }
  }

  // void checkConnection() async {
  //   try {
  //     final result = await InternetAddress.lookup('example.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       emit(state.copyWith(connectionAvailable: true,));
  //     }
  //   } on SocketException catch (_) {
  //     emit(state.copyWith(connectionAvailable: false,));
  //   }
  // }

  void checkToken()async{
    
  }
}
