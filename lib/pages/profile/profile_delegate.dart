import 'package:fluttour/domain/models/character_model.dart';

mixin ProfileDelegate {
  Future<void> fetchProfileSuccess(CharacterModel result);
  Future<void> fetchProfileFailed(String mgs);
}