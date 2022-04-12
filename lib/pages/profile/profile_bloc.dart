import 'package:bloc/bloc.dart';
import '../../app_define/app_credential.dart';
import '../../data/api/request/profile_request.dart';
import '../../domain/models/character_model.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late ProfileRequest profileRequest;

  ProfileBloc({required this.profileRequest}) : super(ProfileUninitializedState()) {
    on<ProfileEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
      ProfileEvent event,
      Emitter<ProfileState> emit)
  async {
    emit(ProfileFetchingState());
    try {
      if (event is ProfileFetchedEvent) {
        String? id = await Credential.singleton.getToken();
        if (id != null) {
          CharacterModel? result = await profileRequest.getProfile(id: id);
          if (result != null) {
            emit(ProfileFetchedState(model: result));
          } else {
            emit(ProfileEmptyState());
          }
        }
      }
    } catch (e) {
        emit(ProfileErrorState());
    }
  }
}