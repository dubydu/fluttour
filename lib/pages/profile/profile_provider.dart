import 'package:fluttour/app_define/app_credential.dart';
import 'package:fluttour/data/api/request/profile_request.dart';
import 'package:fluttour/domain/models/character_model.dart';
import 'package:fluttour/pages/profile/profile_delegate.dart';
import 'package:fluttour/utils/other/notifier_safety.dart';

class ProfileProvider extends ChangeNotifierSafety {
  ProfileProvider(this._profileRequest);

  late ProfileRequest _profileRequest;

  ProfileDelegate? delegate;

  /// Character Information
  CharacterModel? _characterModel;
  CharacterModel? get characterModel => _characterModel;
  set characterModel(CharacterModel? value) {
    _characterModel = value;
    notifyListeners();
  }

  Future<void> getProfile() async {
    String? id = await Credential.singleton.getToken();
    if (id != null) {
      CharacterModel? result = await _profileRequest.getProfile(id: id);
      print("object  $result");
      if (result != null) {
        characterModel = result;
        await  delegate?.fetchProfileSuccess(result);
      } else {
        await delegate?.fetchProfileFailed("Fetch profile failed");
      }
    }
  }

  @override
  void resetState() {

  }
}