part of 'user_cubit.dart';

class UserState extends Equatable {
  
  final User? user;
  final bool? status;
  final String? message;
  final String? token;
  final bool? loading;
  final bool? authSuccess;

  UserState({this.user, this.status=false, this.message, this.token, this.loading=false, this.authSuccess});

  @override
  List<Object?> get props => [user, status, message, token, loading, authSuccess];

  UserState copyWith(
          {User? user, bool? status, String? message, String? token, bool? loading, bool? authSuccess}) =>
      UserState(
          user: user??this.user,
          status: status??false,
          message: message??"",
          token: token??this.token,
          loading: loading??false,
          authSuccess: authSuccess??false);

  @override
  bool? get stringify => true;

}
