part of 'user_cubit.dart';

class UserState extends Equatable {
  
  final User? user;
  final bool? status;
  final String? message;
  final String? token;

  UserState({this.user, this.status=false, this.message="Cannot login", this.token});

  @override
  List<Object?> get props => [user, status, message, token];

  UserState copyWith(
          {User? user, bool? status, String? message, String? token, bool? loading}) =>
      UserState(
          user: user??this.user,
          status: status??false,
          message: message??"error",
          token: token??"",);

  @override
  bool? get stringify => true;

}
