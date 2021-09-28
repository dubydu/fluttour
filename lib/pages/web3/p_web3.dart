import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttour/app_define/app_enum.dart';
import 'package:fluttour/app_define/app_style.dart';
import 'package:fluttour/pages/base/p_material.dart';
import 'package:fluttour/pages/web3/web3_provider.dart';
import 'package:fluttour/utils/widgets/w_header.dart';
import 'package:provider/provider.dart';
import 'package:fluttour/utils/extension/app_extension.dart';

class Web3Page extends StatefulWidget {
  const Web3Page({Key? key}) : super(key: key);

  @override
  _Web3PageState createState() => _Web3PageState();
}

class _Web3PageState extends State<Web3Page> {

  late Web3Provider provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      provider = Provider.of<Web3Provider>(context, listen: false);
      await provider.getTokenInfo();
      await provider.listenContract();
    });
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
                      isShowBackButton: true),
                  Container(
                    padding: EdgeInsets.only(top: 100.H),
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          if (provider.axsModel?.price != null)
                            Container(alignment: Alignment.center,
                              child: Column(
                                children: <Widget>[
                                  Text('${provider.axsModel?.name ?? ''}  (${provider.axsModel?.symbol ?? ''})', style: mediumTextStyle(20.SP),),
                                  SizedBox(height: 10.H),
                                  Text('${provider.axsModel?.price?.toStringAsFixed(2) ?? '0'} USD', style: mediumTextStyle(25.SP),)
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
