abstract class SignUpEvent { }

class SignUpFormInputEvent extends SignUpEvent {
  String? name;
  String? email;
  String? pwd;
  SignUpFormInputEvent({this.name, this.email, this.pwd});
}

class SignUpObscureTextEvent extends SignUpEvent {
  bool isObscure = false;
  SignUpObscureTextEvent({required this.isObscure});
}

class SignUpSavingEvent extends SignUpEvent {
  String? name;
  String? email;
  String? pwd;
  SignUpSavingEvent({this.name, this.email, this.pwd});
}