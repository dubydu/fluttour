import 'package:flutter/material.dart';
import 'package:fluttour/domain/models/character_model.dart';
import 'package:fluttour/generated/l10n.dart';
import 'package:fluttour/pages/profile/edit_profile/edit_profile_delegate.dart';
import 'package:fluttour/pages/profile/edit_profile/edit_profile_provider.dart';
import 'package:fluttour/pages/base/p_material.dart';
import 'package:fluttour/utils/widgets/w_auth_textfield.dart';
import 'package:fluttour/utils/widgets/w_header.dart';
import 'package:fluttour/utils/widgets/w_primary_button.dart';
import 'package:provider/provider.dart';
import 'package:fluttour/utils/extension/app_extension.dart';
import 'package:fluttour/utils/extension/state_extension.dart';
import 'package:fluttour/app_define/app_route.dart';

class PEditProfile extends StatefulWidget {
  const PEditProfile({Key? key}) : super(key: key);

  @override
  _PEditProfileState createState() => _PEditProfileState();
}

class _PEditProfileState extends State<PEditProfile> with EditProfileDelegate {

  /// Properties
  late EditProfileProvider _editProfileProvider;
  late TextEditingController _emailController;
  late TextEditingController _characterController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _editProfileProvider = Provider.of<EditProfileProvider>(context, listen: false);
      _editProfileProvider.delegate = this;
    });
    _emailController = TextEditingController();
    _characterController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return PMaterial(
      child: Consumer<EditProfileProvider>(
        builder: (BuildContext context, EditProfileProvider provider, _) {
            return Container(
              color: Colors.white,
              child: Container (
                child: Column(
                  children: <Widget>[
                    WHeader(title: S.of(context).edit_profile, isShowBackButton: true,),
                    Container(
                      child: Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 32.W,
                                  right: 32.W, top: 32.H),
                              child: Column(
                                children: <Widget>[
                                  WAuthTextField(controller: _emailController,
                                      labelText: provider.characterModel?.email ?? S.of(context).email,
                                      obscureText: false,
                                      isSecurityTextField: false,
                                      onChange: (text) async {
                                        _editProfileProvider.emailText = text;
                                      }),
                                  SizedBox(height: 10.H),
                                  WAuthTextField(controller: _characterController,
                                      labelText: provider.characterModel?.name ?? S.of(context).character,
                                      obscureText: false,
                                      isSecurityTextField: false,
                                      onChange: (text) async {
                                        _editProfileProvider.character = text;
                                      }),
                                  SizedBox(height: 20.H),
                                ],
                              ),
                            ),
                            Positioned(
                                left: 20.SP,
                                right: 20.SP,
                                bottom: MediaQuery.of(context).padding.bottom + 20.SP,
                                child: Container(
                                  height: 50.H,
                                  child: WPrimaryButton(
                                    title: "Save",
                                    onPress: () async {
                                      await provider.updateProfile();
                                    },
                                    isSelected: provider.isEditButtonEnable,
                                    isLoading: provider.isSignUpButtonLoading,
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
        },
      )
    );
  }

  @override
  Future<void> updateProfileFailed(String mgs) async {
    return await showErrorDialog('<${S.of(context).edit_profile}>', mgs);
  }

  @override
  Future<void> updateProfileSuccess(CharacterModel result) async {
    context.navigator()?.pop();
  }
}