import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/app_define/app_credential.dart';
import 'package:fluttour/data/api/request/profile_request.dart';
import 'package:fluttour/data/api/request/base_request.dart';
import 'package:fluttour/domain/models/character_model.dart';
import 'profile_edit_event.dart';
import 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  late BaseGraphQLRequest baseRequest;
  late ProfileRequest profileRequest;

  ProfileEditBloc({required this.baseRequest, required this.profileRequest}) :
        super(ProfileEditUninitializedState()) {
    on<ProfileEditEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
      ProfileEditEvent event,
      Emitter<ProfileEditState> emit)
  async {
    try {
      /// ProfileEditingEvent
      if (event is ProfileEditingEvent) {
        final bool isValidate = (event.email != null && event.email?.trim() != "")
            && (event.name != null && event.name?.trim() != "");
        emit(ProfileEditingState(isValidate: isValidate, isLoading: false));

      /// ProfileEditInitializedEvent
      } else if (event is ProfileEditInitializedEvent) {
        emit(ProfileEditInitializedState(characterModel: event.characterModel));

      /// ProfileSaveEvent
      } else if (event is ProfileSaveEvent) {
        emit(ProfileEditingState(isValidate: true, isLoading: true));
        String? id = await Credential.singleton.getToken();
        if (id != null) {
          CharacterModel? result = await profileRequest.editProfile(id: id, email: event.email!, name: event.name!);
          if (result != null) {
            bool isPublishSuccess = await baseRequest.publishCharacter(id: id);
            if (isPublishSuccess == true) {
              emit(ProfileEditInitializedState(characterModel: result));
              emit(ProfileEditingState(isValidate: false, isLoading: false));
            }
          } else {
            emit(ProfileEditErrorState());
          }
        }
      }
    } catch (e) {
      emit(ProfileEditErrorState());
    }
  }
}