
import 'package:fluttour/app_define/app_enum.dart';
import 'package:fluttour/utils/other/notifier_safety.dart';

class LayoutStateProvider extends ChangeNotifierSafety {

  //#region Public Properties
  //---------------------
  /// Description title
  String _descTitle = Identity.front.title();

  String get descTitle => _descTitle;

  set descTitle(String value) {
    _descTitle = value;
    notifyListeners();
  }

  /// Description title
  Identity _identitySideSelected = Identity.front;

  Identity get identitySideSelected => _identitySideSelected;

  set identitySideSelected(Identity value) {
    _descTitle = value.title();
    _identitySideSelected = value;
    notifyListeners();
  }

  @override
  void resetState() {
    // TODO: implement resetState
  }
}