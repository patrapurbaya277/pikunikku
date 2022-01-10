
part of 'login_cubit.dart';

class LoginState extends Equatable{
  final String email;
  final String password;
  final bool visiblePassword;
  

  LoginState(
      {this.email: "", this.password: "", this.visiblePassword=false});

  @override
  List<Object?> get props => [email, password, visiblePassword];

  LoginState copyWith({
    String? email,
    String? password,
    bool? visiblePassword,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        visiblePassword: visiblePassword??this.visiblePassword,
      );

  @override
  bool? get stringify => true;
}