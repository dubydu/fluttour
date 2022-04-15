import 'package:fluttour/domain/models/character_model.dart';

abstract class ProfileEditState { }

class ProfileEditUninitializedState extends ProfileEditState { }

class ProfileEditInitializedState extends ProfileEditState {
  final CharacterModel? characterModel;
  ProfileEditInitializedState({required this.characterModel});
}

class ProfileEditingState extends ProfileEditState {
  bool isValidate = false;
  bool isLoading = false;
  ProfileEditingState({required this.isValidate, required this.isLoading});
}

class ProfileEditErrorState extends ProfileEditState { }