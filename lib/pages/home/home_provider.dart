
import 'package:fluttour/app_define/app_enum.dart';
import 'package:fluttour/utils/other/notifier_safety.dart';

class HomeProvider extends ChangeNotifierSafety {

  List<Tutorial> _listTutorial = <Tutorial>[];

  List<Tutorial> get listTutorial => _listTutorial;

  set listTutorial(List<Tutorial> value) {
    _listTutorial = value;
    notifyListeners();
  }

  void setupData() {
    listTutorial = Tutorial.values;
  }

  @override
  void resetState() {
  }
}