class LoginState {}

class InitState extends LoginState {}

class SignInState extends LoginState {
  bool isSuccess;
  String message;

  SignInState(this.isSuccess, this.message);
}
