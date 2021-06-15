import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttour/app_define/app_color.dart';
import 'package:fluttour/app_define/app_enum.dart';
import 'package:fluttour/app_define/app_style.dart';
import 'package:fluttour/domain/models/character_model.dart';
import 'package:fluttour/generated/l10n.dart';
import 'package:fluttour/pages/profile/profile_delegate.dart';
import 'package:fluttour/utils/extension/app_extension.dart';
import 'package:fluttour/pages/profile/profile_provider.dart';
import 'package:fluttour/utils/widgets/p_material.dart';
import 'package:fluttour/utils/widgets/w_header.dart';
import 'package:provider/provider.dart';
import 'package:fluttour/app_define/app_route.dart';

class PProfile extends StatefulWidget {
  const PProfile({Key? key}) : super(key: key);

  @override
  _PProfileState createState() => _PProfileState();
}

class _PProfileState extends State<PProfile> with ProfileDelegate {

  /// ProfileProvider
  late ProfileProvider _profileProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
      _profileProvider.delegate = this;
      await _profileProvider.getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PMaterial(
        child: Consumer<ProfileProvider>(
          builder: (BuildContext context, ProfileProvider provider, _) {
            return Container(
              color: Colors.white,
              child: Column (
                children: <Widget>[
                  WHeader(title: Tutorial.mutations.getName(), isShowBackButton: true),
                  if (provider.characterModel == null)
                    Container(padding: EdgeInsets.only(top: 150.H),
                        child: CupertinoActivityIndicator(radius: 16.SP,))
                  else
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(20.SP),
                            decoration: BoxDecoration(
                              color: AppColors.gray,
                              borderRadius: BorderRadius.circular(8.SP),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(20.SP),
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      child: Text("Hi, ${provider.characterModel?.name ?? ""}",
                                        style: boldTextStyle(20.SP, color: AppColors.darkBlue),),
                                  ),
                                  SizedBox(height: 10.H,),
                                  Container(
                                    child: Text("${provider.characterModel?.email ?? ""}",
                                      style: boldTextStyle(16.SP, color: AppColors.salmon.withOpacity(0.5)),),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ],
              )
            );
          },
        )
    );
  }

  @override
  Future<void> fetchProfileFailed(String mgs) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('<${Tutorial.mutations.getName()}> $mgs'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                context.navigator()?.pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Future<void> fetchProfileSuccess(CharacterModel result) async {

  }
}
