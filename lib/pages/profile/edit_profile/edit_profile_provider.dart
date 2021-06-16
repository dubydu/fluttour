import 'package:fluttour/app_define/app_credential.dart';
import 'package:fluttour/data/api/request/base_request.dart';
import 'package:fluttour/data/api/request/profile_request.dart';
import 'package:fluttour/domain/models/character_model.dart';
import 'package:fluttour/pages/profile/edit_profile/edit_profile_delegate.dart';
import 'package:fluttour/utils/other/notifier_safety.dart';

class EditProfileProvider extends ChangeNotifierSafety {
  EditProfileProvider(this._baseRequest, this._profileRequest);

  late BaseRequest _baseRequest;
  late ProfileRequest _profileRequest;

  /// EditProfileDelegate
  EditProfileDelegate? delegate;

  /// Edit profile stuff
  String? _emailText;
  String? get emailText => _emailText;
  set emailText(String? value) {
    _emailText = value;
    validateEditProfileStuff();
  }

  String? _character;
  String? get character => _character;
  set character(String? value) {
    _character = value;
    validateEditProfileStuff();
  }

  bool _isEditButtonEnable = false;
  bool get isEditButtonEnable => _isEditButtonEnable;
  set isEditButtonEnable(bool value) {
    _isEditButtonEnable = value;
    notifyListeners();
  }

  /// Validate stuff
  validateEditProfileStuff() {
    isEditButtonEnable = (emailText != null && emailText?.trim() != "")
        && (character != null && character?.trim() != "");
  }

  /// Character Information
  CharacterModel? _characterModel;
  CharacterModel? get characterModel => _characterModel;
  set characterModel(CharacterModel? value) {
    _characterModel = value;
    notifyListeners();
  }

  /// Sign up Loading button
  bool _isSignUpButtonLoading = false;
  bool get isSignUpButtonLoading => _isSignUpButtonLoading;
  set isSignUpButtonLoading(bool value) {
    _isSignUpButtonLoading = value;
    notifyListeners();
  }

  Future<void> updateProfile() async {
    isSignUpButtonLoading = true;
    String? id = await Credential.singleton.getToken();
    if (id != null) {
      CharacterModel? result = await _profileRequest.editProfile(id: id, email: emailText!, name: character!);
      this.characterModel = result;
      if (result != null) {
        await _baseRequest.publishCharacter(id: id);
        delegate?.updateProfileSuccess(result);
      } else {
        delegate?.updateProfileFailed("Update profile failed");
      }
    }
    isSignUpButtonLoading = false;
  }

  @override
  void resetState() {

  }
}