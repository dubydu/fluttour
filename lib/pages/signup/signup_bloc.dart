import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/app_define/app_credential.dart';
import 'package:fluttour/data/api/request/base_request.dart';
import 'package:fluttour/data/api/request/signup_request.dart';
import 'package:fluttour/domain/models/character_model.dart';
import 'package:fluttour/pages/signup/signup_delegate.dart';
import 'package:fluttour/pages/signup/signup_event.dart';
import 'package:fluttour/pages/signup/signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  late BaseGraphQLRequest baseRequest;
  late SignUpRequest signUpRequest;

  SignUpBloc({required this.baseRequest, required this.signUpRequest}) : super(SignUpUninitializedState()) {
    on<SignUpEvent>(_mapEventToState);
  }

  /// Delegate
  SignUpDelegate? delegate;

  Future<void> _mapEventToState(
      SignUpEvent event,
      Emitter<SignUpState> emit)
  async {
    try {
      /// SignUpFormInputEvent
      if (event is SignUpFormInputEvent) {
        bool isValidate = (event.email != null && event.email?.trim() != "")
            && (event.name != null && event.name?.trim() != "")
            && (event.pwd!= null && event.pwd?.trim() != "");
        emit(SignUpSaveButtonState(isValidate: isValidate, isLoading: false));

      /// SignUpObscureTextEvent
      } else if (event is SignUpObscureTextEvent) {
        emit(SignUpObscureTextState(isObscure: event.isObscure));

      /// SignUpSavingEvent
      } else if (event is SignUpSavingEvent) {
        emit(SignUpSaveButtonState(isValidate: true, isLoading: true));
        CharacterModel request = CharacterModel(
            name: event.name,
            email: event.email,
            password: event.pwd);
        CharacterModel? result = await signUpRequest.signup(request);
        if (result != null && result.id != null) {
          Credential.singleton.saveToken(result.id!);
          await this.baseRequest.publishCharacter(id: result.id!);
          emit(SignUpSaveButtonState(isValidate: true, isLoading: false));
          this.delegate?.didSignUpSuccess();
        } else {
          this.delegate?.didSignUpFailed('Sign up failed');
        }
      }
    } catch (e) {

    }
  }
}