import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttour/domain/models/collection_model.dart';
import 'package:fluttour/pages/collection_grid/collection_grid_provider.dart';
import 'package:fluttour/pages/collection_grid/w_collection_item.dart';
import 'package:fluttour/app_define/app_enum.dart';
import 'package:fluttour/app_define/app_mixin.dart';
import 'package:fluttour/pages/base/p_material.dart';
import 'package:fluttour/utils/widgets/w_header.dart';
import 'package:provider/provider.dart';
import 'package:fluttour/utils/extension/app_extension.dart';

class PCollectionGrid extends StatefulWidget {
  @override
  _PCollectionGridState createState() => _PCollectionGridState();
}

class _PCollectionGridState extends State<PCollectionGrid>
    with GridViewDelegate {
  late CollectionGridProvider _collectionGridProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _collectionGridProvider = Provider.of<CollectionGridProvider>(context, listen: false);
      _collectionGridProvider.setupData();
    });
  }

  @override
  void gridView(Widget gridView, didSelectAtItem) {
    CollectionModel item = didSelectAtItem;
    _collectionGridProvider.updateData(item: item);
  }

  @override
  Widget build(BuildContext context) {
    return PMaterial(
      child: Consumer<CollectionGridProvider>(
        builder: (BuildContext context, CollectionGridProvider provider, _) {
          return Column(
            children: <Widget>[
              WHeader(title: Tutorial.gridView.getName(), isShowBackButton: true),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 16.W, right: 16.W),
                  color: Colors.white,
                  child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 3.0,
                          mainAxisSpacing: 3.0,
                          crossAxisCount: 2,
                          childAspectRatio: 1),
                      itemCount: provider.itemList?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return WCollectionItem(
                            item: provider.itemList![index], delegate: this);
                      })
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
