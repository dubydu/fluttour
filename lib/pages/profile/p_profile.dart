import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttour/app_define/app_color.dart';
import 'package:fluttour/app_define/app_credential.dart';
import 'package:fluttour/app_define/app_enum.dart';
import 'package:fluttour/app_define/app_style.dart';
import 'package:fluttour/domain/models/character_model.dart';
import 'package:fluttour/pages/profile/profile_bloc.dart';
import 'package:fluttour/pages/profile/profile_edit/profile_edit_bloc.dart';
import 'package:fluttour/pages/profile/profile_edit/profile_edit_event.dart';
import 'package:fluttour/pages/profile/profile_event.dart';
import 'package:fluttour/pages/profile/profile_state.dart';
import 'package:fluttour/utils/extension/app_extension.dart';
import 'package:fluttour/utils/extension/state_extension.dart';
import 'package:fluttour/pages/base/p_material.dart';
import 'package:fluttour/utils/widgets/w_header.dart';
import 'package:fluttour/utils/widgets/w_primary_button.dart';
import 'package:fluttour/app_define/app_route.dart';

class PProfile extends StatefulWidget {
  const PProfile({Key? key}) : super(key: key);

  @override
  _PProfileState createState() => _PProfileState();
}

class _PProfileState extends State<PProfile> {

  /// ProfileBloc
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _profileBloc = BlocProvider.of<ProfileBloc>(context, listen: false);
      await _fetchProfileData();
    });
  }

  _fetchProfileData() async {
    _profileBloc.add(ProfileFetchingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return PMaterial(
      child: Container(
        color: Colors.white,
        child: BlocConsumer<ProfileBloc, ProfileState> (
          listener: (context, state) {
            if (state is ProfileFetchedState) {
              // TODO -
            }
          },
          builder: (context, state) {
            if (state is ProfileFetchedState) {
              CharacterModel? data = state.model;
              return Container(
                  color: Colors.white,
                  child: Column (
                    children: <Widget>[
                      WHeader(title: Tutorial.mutations.getName(), isShowBackButton: true),
                      if (data == null)
                        Container(padding: EdgeInsets.only(top: 150.H),
                            child: CupertinoActivityIndicator(radius: 16.SP))
                      else
                        Expanded(
                          child: Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(20.SP),
                                    decoration: BoxDecoration(
                                      color: AppColors.gray,
                                      borderRadius: BorderRadius.circular(8.SP),
                                    ),
                                    child: Container(
                                        margin: EdgeInsets.all(20.SP),
                                        child: Container(
                                          child: Stack (
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(right: 40.H),
                                                    child: Text("Hi, ${data.name ?? ""}",
                                                      style: boldTextStyle(20.SP, color: AppColors.darkBlue),),
                                                  ),
                                                  SizedBox(height: 10.H,),
                                                  Container(
                                                    child: Text("${data.email ?? ""}",
                                                      style: boldTextStyle(16.SP, color: AppColors.salmon.withOpacity(0.8)),),
                                                  )
                                                ],
                                              ),
                                              _buildEditProfileButtonWidget(context, data)
                                            ],
                                          ),
                                        )
                                    ),
                                  )
                                ],
                              ),
                              _buildClearProfileButtonWidget(context)
                            ],
                          ),
                        )
                    ],
                  )
              );
            } else {
              return Container(padding: EdgeInsets.only(top: 150.H),
                  child: CupertinoActivityIndicator(radius: 16.SP,));
            }
          },
        )
      )
    );
  }

  Widget _buildEditProfileButtonWidget(BuildContext context, CharacterModel? data) {
    return Positioned(
        top: 0,
        right: 0,
        bottom: 0,
        child: Container(
          alignment: Alignment.centerRight,
          height: 40.H,
          width: 40.H,
          child: InkWell(
            child: Icon(Icons.navigate_next, size: 40.H, color: AppColors.darkBlue,),
            onTap: () async {
              BlocProvider.of<ProfileEditBloc>(context, listen: false).add(ProfileEditInitializedEvent(characterModel: data));
              context.navigator()?.pushNamed(AppRoute.routeEditProfile).then((_) async {
                await this._fetchProfileData();
              });
            },
          ),
        )
    );
  }

  Widget _buildClearProfileButtonWidget(BuildContext context) {
    return Positioned(
        left: 20.SP,
        right: 20.SP,
        bottom: MediaQuery.of(context).padding.bottom + 20.SP,
        child: Container(
          height: 50.H,
          child: WPrimaryButton(
            title: "Clear Token",
            onPress: () async {
              return showConfirmDialog(() async {
                context.navigator()?.pop();
                await Credential.singleton.clearToken();
                context.navigator()?.pushNamedAndRemoveUntil(AppRoute.routeSignup, (route) => false);
              }, 'Are you sure you want to delete the token?');
            },
            isSelected: true,
            isLoading: false,
          ),
        )
    );
  }

  @override
  void deactivate() {
    super.deactivate();
  }
}