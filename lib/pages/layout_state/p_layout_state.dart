import 'package:flutter/material.dart';
import 'package:fluttour/pages/layout_state/layout_state_provider.dart';
import 'package:fluttour/app_define/app_assets.dart';
import 'package:fluttour/app_define/app_color.dart';
import 'package:fluttour/app_define/app_enum.dart';
import 'package:fluttour/app_define/app_style.dart';
import 'package:fluttour/pages/base/p_material.dart';
import 'package:fluttour/utils/extension/app_extension.dart';
import 'package:fluttour/utils/widgets/w_header.dart';
import 'package:fluttour/utils/widgets/w_primary_button.dart';
import 'package:provider/provider.dart';

class PLayoutState extends StatefulWidget {
  @override
  _PLayoutStateState createState() => _PLayoutStateState();
}

class _PLayoutStateState extends State<PLayoutState> {
  @override
  Widget build(BuildContext context) {
    return PMaterial(
      child: Consumer<LayoutStateProvider>(
        builder: (BuildContext context, LayoutStateProvider provider, _) {
          final bool isFrontSideSelected = provider.identitySideSelected == Identity.front;
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                WHeader(
                    title: Tutorial.layoutState.getName(),
                    isShowBackButton: true,
                    bgColor: AppColors.grey),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Container(
                        height: 244.H,
                        margin: EdgeInsets.all(14.SP),
                        decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            border: Border.all(color: AppColors.lightGrey),
                            borderRadius: BorderRadius.circular(8.SP)),
                        child: Center(
                          child: identityWidget(isFrontSideSelected: isFrontSideSelected),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10.SP),
                          child: Text(
                              provider.descTitle,
                              style: boldTextStyle(20, color: AppColors.black))
                      ),
                      SizedBox(height: 100.H),
                      Container(
                        margin: EdgeInsets.only(left: 34.W, right: 34.W),
                        child: Column(
                          children: [
                            WPrimaryButton(title: 'Font Side', isSelected: true, onPress: () async {
                              provider.identitySideSelected = Identity.front;
                            }, isLoading: false,),
                            SizedBox(height: 30.H,),
                            WPrimaryButton(title: 'Back Side', isSelected: true, onPress: () async {
                              provider.identitySideSelected = Identity.back;
                            }, isLoading: false),
                          ],
                        ),
                      )
                    ]),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget identityWidget({required bool isFrontSideSelected}) {
    return isFrontSideSelected ? Container(
      height: 89.H,
      child: Image.asset(AppAssets.origin().icIdentityFront, fit: BoxFit.fitHeight,),
    ) : Padding(
      padding: EdgeInsets.all(1.SP),
      child: Image.asset(AppAssets.origin().icIdentityBack, fit: BoxFit.fitHeight,),
    );
  }
}
