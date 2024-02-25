abstract class LoginEvent {}

class InitEvent extends LoginEvent {}

class SignInEvent extends LoginEvent {
  final String mssv;
  final String password;

  SignInEvent(this.mssv, this.password);
}
