
// import 'package:equatable/equatable.dart';

part of 'start_cubit.dart';
class StartState extends Equatable{
  final bool? checkingConnection;
  final bool? connectionAvailable;

  final bool? checkingToken;
  final bool? tokenAvailable;

  final String? checkProgress;

  StartState(
      {this.checkingConnection=false, this.connectionAvailable=false, this.checkingToken=false, this.tokenAvailable=false, this.checkProgress="",});

  @override
  List<Object?> get props => [checkingConnection, connectionAvailable, checkingToken,tokenAvailable,checkProgress];

  StartState copyWith({
    bool? checkingConnection,
  bool? connectionAvailable,

  bool? checkingToken,
  bool? tokenAvailable,

 String? checkProgress,
  }) =>
      StartState(
        checkingConnection: checkingConnection??this.checkingConnection, 
        connectionAvailable: connectionAvailable??this.connectionAvailable, 
        checkingToken: checkingToken??this.checkingToken,
        tokenAvailable: tokenAvailable??this.tokenAvailable,
        checkProgress: checkProgress??this.checkProgress,
      );

  @override
  bool? get stringify => true;
}