import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/domain/models/character_model.dart';
import 'package:fluttour/generated/l10n.dart';
import 'package:fluttour/pages/base/p_material.dart';
import 'package:fluttour/pages/profile/profile_edit/profile_edit_bloc.dart';
import 'package:fluttour/pages/profile/profile_edit/profile_edit_event.dart';
import 'package:fluttour/pages/profile/profile_edit/profile_edit_state.dart';
import 'package:fluttour/utils/widgets/w_auth_textfield.dart';
import 'package:fluttour/utils/widgets/w_header.dart';
import 'package:fluttour/utils/widgets/w_primary_button.dart';
import 'package:fluttour/utils/extension/app_extension.dart';
import 'package:fluttour/app_define/app_route.dart';

class PProfileEdit extends StatefulWidget {
  const PProfileEdit({Key? key}) : super(key: key);

  @override
  _PProfileEditState createState() => _PProfileEditState();
}

class _PProfileEditState extends State<PProfileEdit> with HeaderDelegate {
  /// Properties
  final _emailController = TextEditingController();
  final _characterController = TextEditingController();
  late ProfileEditBloc _profileEditBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _profileEditBloc = BlocProvider.of<ProfileEditBloc>(context, listen: false);
    });
  }

  @override
  void onBack() {
    // _editProfileProvider.resetState();
    context.navigator()?.pop();
  }

  Future<void> _textFieldsLatestValue() async {
    final String? email = _emailController.text;
    final String? name = _characterController.text;
    BlocProvider.of<ProfileEditBloc>(context).add(ProfileEditingEvent(email: email, name: name));
  }

  Future<void> _saveProfile() async {
    final String? email = _emailController.text;
    final String? name = _characterController.text;
    BlocProvider.of<ProfileEditBloc>(context).add(ProfileSaveEvent(email: email, name: name));
  }

  @override
  Widget build(BuildContext context) {
    return PMaterial(
      child: Container(
          color: Colors.white,
          child: Container(
              child: Column(children: <Widget>[
                WHeader(
                  title: S.of(context).edit_profile,
                  isShowBackButton: true,
                  delegate: this,
                ),
                Container(
                  child: Expanded(
                    child: Stack(
                      children: <Widget>[
                        BlocBuilder<ProfileEditBloc, ProfileEditState>(
                            buildWhen: (context, state) {
                              return state is ProfileEditInitializedState;
                        }, builder: (context, state) {
                              if (state is ProfileEditInitializedState) {
                                CharacterModel? data = state.characterModel;
                                return Container(
                                  margin: EdgeInsets.only(left: 32.W, right: 32.W, top: 32.H),
                                  child: Column(
                                    children: <Widget>[
                                      WAuthTextField(
                                          controller: _emailController,
                                          labelText: data?.email ?? S.of(context).email,
                                          obscureText: false,
                                          isSecurityTextField: false,
                                          onChange: (text) async {
                                            await _textFieldsLatestValue();
                                          }),
                                      SizedBox(height: 10.H),
                                      WAuthTextField(
                                          controller: _characterController,
                                          labelText: data?.name ?? S.of(context).character,
                                          obscureText: false,
                                          isSecurityTextField: false,
                                          onChange: (text) async {
                                            await _textFieldsLatestValue();
                                          }),
                                      SizedBox(height: 20.H),
                                    ],
                                  ),
                                );
                              }
                              return Container();
                        }),
                        BlocSelector<ProfileEditBloc, ProfileEditState, List<bool>>
                          (selector: (state) {
                            if (state is ProfileEditingState) {
                                return [state.isValidate ?? false, state.isLoading ?? false];
                            }
                            return [false, false];
                        }, builder: (context, isValidate) {
                            return
                              Positioned(
                                left: 20.SP,
                                right: 20.SP,
                                bottom: MediaQuery.of(context).padding.bottom + 20.SP,
                                child: Container(
                                  height: 50.H,
                                  child: WPrimaryButton(
                                    title: "Save",
                                    onPress: () async {
                                      await _saveProfile();
                                    },
                                    isSelected: isValidate[0],
                                    isLoading: isValidate[1],
                                  ),
                                )
                            );
                        })
                      ],
                    ),
                  ),
              )
          ]))
      ),
    );
  }
}