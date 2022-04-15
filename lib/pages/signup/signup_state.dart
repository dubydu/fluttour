abstract class SignUpState { }

class SignUpUninitializedState extends SignUpState { }

class SignUpSaveButtonState extends SignUpState {
  bool isValidate = false;
  bool isLoading = false;
  SignUpSaveButtonState({required this.isValidate, required this.isLoading});
}

class SignUpObscureTextState extends SignUpState {
  bool isObscure = false;
  SignUpObscureTextState({required this.isObscure});
}