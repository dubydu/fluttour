import 'package:bloc/bloc.dart';
import '../../app_define/app_credential.dart';
import '../../data/api/request/profile_request.dart';
import '../../domain/models/character_model.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late ProfileRequest profileRequest;

  ProfileBloc({required this.profileRequest}) : super(ProfileUninitializedState()) {
    profileRequest = ProfileRequest();
    on<ProfileEvent>(_mapSignInWithGoogleToState);
  }

  Future<void> _mapSignInWithGoogleToState(
      ProfileEvent event,
      Emitter<ProfileState> emit)
  async {
    try {
      if (event is ProfileFetchedEvent) {
        String? id = await Credential.singleton.getToken();
        if (id != null) {
          CharacterModel? result = await profileRequest.getProfile(id: id);
          if (result != null) {
            emit(ProfileFetchedState(model: result));
          } else {
            emit(ProfileErrorState());
          }
        }
      }
    } catch (e) {
        emit(ProfileErrorState());
    }
  }
}