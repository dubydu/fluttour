import 'package:flutter/cupertino.dart';
import '../../domain/models/character_model.dart';

abstract class ProfileState { }

class ProfileUninitializedState extends ProfileState { }

class ProfileFetchingState extends ProfileState { }

class ProfileFetchedState extends ProfileState {
  final CharacterModel? model;
  ProfileFetchedState({@required this.model});
}

class ProfileEmptyState extends ProfileState { }

class ProfileErrorState extends ProfileState { }