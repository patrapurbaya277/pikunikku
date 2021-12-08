
part of 'login_cubit.dart';

class LoginState extends Equatable{
  final String email;
  final String password;

  LoginState(
      {this.email: "", this.password: "",});

  @override
  List<Object?> get props => [email, password];

  LoginState copyWith({
    String? email,
    String? password,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        
      );

  @override
  bool? get stringify => true;
}