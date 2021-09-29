import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttour/app_define/app_enum.dart';
import 'package:fluttour/app_define/app_style.dart';
import 'package:fluttour/pages/base/p_material.dart';
import 'package:fluttour/pages/web3/web3_provider.dart';
import 'package:fluttour/utils/widgets/w_header.dart';
import 'package:provider/provider.dart';
import 'package:fluttour/utils/extension/app_extension.dart';
import 'package:fluttour/app_define/app_route.dart';

class Web3Page extends StatefulWidget {
  const Web3Page({Key? key}) : super(key: key);

  @override
  _Web3PageState createState() => _Web3PageState();
}

class _Web3PageState extends State<Web3Page> implements HeaderDelegate {

  late Web3Provider provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      provider = Provider.of<Web3Provider>(context, listen: false);
      await provider.getTokenInfo();
      await provider.listenContract();
      await provider.startTimer();
    });
  }

  @override
  void onBack() {
    provider.resetState();
    context.navigator()?.pop();
  }

  @override
  Widget build(BuildContext context) {
    return PMaterial(
        child: Consumer<Web3Provider>(
          builder: (BuildContext context, Web3Provider provider, _) {
            return Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  WHeader(title: Tutorial.web3.getName(),
                      isShowBackButton: true, delegate: this,),
                  Container(
                    padding: EdgeInsets.only(top: 100.H),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          if (provider.tokenModel?.price != null)
                            Container(alignment: Alignment.center,
                              child: Column(
                                children: <Widget>[
                                  Text('${provider.tokenModel?.name ?? ''} (${provider.tokenModel?.symbol ?? ''})', style: mediumTextStyle(20.SP),),
                                  SizedBox(height: 10.H),
                                  Text('${provider.tokenModel?.price?.toStringAsFixed(2) ?? '0'} USD', style: mediumTextStyle(25.SP),)
                               ]
                              )
                            )
                          else Container(child: CupertinoActivityIndicator(radius: 18.SP, animating: true))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        )
    );
  }
}
