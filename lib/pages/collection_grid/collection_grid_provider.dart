import 'package:fluttour/domain/models/collection_model.dart';
import 'package:fluttour/utils/other/notifier_safety.dart';

class CollectionGridProvider extends ChangeNotifierSafety {

  //#region Public Properties
  //---------------------
  List<CollectionModel>? _itemList;

  List<CollectionModel>? get itemList => _itemList;

  set itemList(List<CollectionModel>? value) {
    _itemList = value;
    notifyListeners();
  }

  void setupData() {
    List<CollectionModel> data = <CollectionModel>[];
    List.generate(25, (int index) => {
      data.add(CollectionModel(title: 'Item $index', isSelected: false))
    });
    itemList = data;
  }

  void updateData({required CollectionModel item}) {
    if (itemList == null) {
      return;
    }
    final int indexSelected = itemList!.indexWhere((element) => element == item) ;
    itemList![indexSelected].isSelected = true;
    notifyListeners();
  }

  @override
  void resetState() {
    // TODO: implement resetState
  }
}