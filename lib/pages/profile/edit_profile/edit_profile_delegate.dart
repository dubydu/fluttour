import 'package:fluttour/domain/models/character_model.dart';

mixin EditProfileDelegate {
  Future<void> updateProfileSuccess(CharacterModel result);
  Future<void> updateProfileFailed(String mgs);
}