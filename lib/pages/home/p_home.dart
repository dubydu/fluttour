import 'package:flutter/material.dart';
import 'package:fluttour/generated/l10n.dart';
import 'package:fluttour/pages/home/home_provider.dart';
import 'package:fluttour/pages/home/w_tutorial_item.dart';
import 'package:fluttour/utils/other/dynamic_size.dart';
import 'package:fluttour/app_define/app_enum.dart';
import 'package:fluttour/pages/base/p_material.dart';
import 'package:fluttour/utils/widgets/w_header.dart';
import 'package:provider/provider.dart';
import 'package:fluttour/utils/extension/app_extension.dart';
import 'package:fluttour/app_define/app_route.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with DynamicSize {

  late HomeProvider _homeProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _homeProvider = Provider.of<HomeProvider>(context, listen: false);
      _homeProvider.setupData();
      // await Credential().saveToken('DEMO_TOKEN_3');
    });
  }

  @override
  Widget build(BuildContext context) {
    initDynamicSize(context);
    return PMaterial(
      child: Container(
        color: Colors.white,
        child: Column (
          children: <Widget>[
            WHeader(title: S.of(context).app_title),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 17.W, right: 17.W),
                child: Selector<HomeProvider, List<Tutorial>>(
                  selector: (_, HomeProvider provider) => provider.listTutorial,
                  builder: (_, List<Tutorial> data, __) {
                    return _buildListView(data);
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListView(List<Tutorial> data) {
    return ListView.builder(
        itemCount:  data.length,
        itemBuilder: (BuildContext context, int index) {
          return WTutorialItem(tutorial: data[index], onPressItem: () {
            return context.navigator()?.pushNamed(Tutorial.values[index].router());
          });
        }
    );
  }
}
