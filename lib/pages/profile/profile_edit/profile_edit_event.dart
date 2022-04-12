import 'package:fluttour/domain/models/character_model.dart';

abstract class ProfileEditEvent { }

class ProfileEditInitializedEvent extends ProfileEditEvent {
  final CharacterModel? characterModel;
  ProfileEditInitializedEvent({required this.characterModel});
}

class ProfileEditingEvent extends ProfileEditEvent {
  final String? email;
  final String? name;
  ProfileEditingEvent({required this.email, required this.name});
}

class ProfileSaveEvent extends ProfileEditEvent {
  final String? email;
  final String? name;
  ProfileSaveEvent({required this.email, required this.name});
}

class ProfileEditedEvent extends ProfileEditEvent { }