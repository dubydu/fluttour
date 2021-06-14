import 'package:fluttour/data/api/request/signup_request.dart';
import 'package:fluttour/domain/models/character_model.dart';
import 'package:fluttour/pages/signup/signup_delegate.dart';
import 'package:fluttour/utils/other/notifier_safety.dart';

class SignupProvider extends ChangeNotifierSafety {

  SignupProvider(this._signupRequest);

  late SignupRequest _signupRequest;

  /// Delegate
  SignUpDelegate? delegate;

  /// Password Obscure State
  bool _passwordObscureTextState = true;
  bool get passwordObscureTextState => _passwordObscureTextState;

  set passwordObscureTextState(bool value) {
    _passwordObscureTextState = value;
    notifyListeners();
  }

  /// Signup Button State
  bool _isSignUpButtonEnable = false;
  bool get isSignUpButtonEnable => _isSignUpButtonEnable;

  set isSignUpButtonEnable(bool value) {
    _isSignUpButtonEnable = value;
    notifyListeners();
  }

  /// Signup stuff
  String? _emailText;
  String? get emailText => _emailText;

  set emailText(String? value) {
    _emailText = value;
    validateSignUpStuff();
  }

  String? _character;
  String? get character => _character;

  set character(String? value) {
    _character = value;
    validateSignUpStuff();
  }

  String? _password;
  String? get password => _password;

  set password(String? value) {
    _password = value;
    validateSignUpStuff();
  }

  bool _isSignUpButtonLoading = false;

  bool get isSignUpButtonLoading => _isSignUpButtonLoading;

  set isSignUpButtonLoading(bool value) {
    _isSignUpButtonLoading = value;
    notifyListeners();
  }

  /// Validate stuff
  validateSignUpStuff() {
    isSignUpButtonEnable = (emailText != null && emailText?.trim() != "")
        && (character != null && character?.trim() != "")
        && (password != null && password?.trim() != "");
  }

  Future<CharacterModel?> signup() async {
    this.isSignUpButtonLoading = true;
    CharacterModel request = CharacterModel(
        name: this.character,
        email: this.emailText,
        password: this.password);
    CharacterModel? result = await _signupRequest.signup(request);
    if (result != null) {
      this.isSignUpButtonLoading = false;
      this.delegate?.didSignInSuccess();
    } else {
      this.delegate?.didSignInFailed();
    }
  }

  @override
  void resetState() {

  }
}