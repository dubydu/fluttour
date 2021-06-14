// @dart=2.9
import 'package:fluttour/environments/environement.dart';
import 'package:fluttour/main.dart' as App;
import 'package:fluttour/app_define/app_config.dart';

Future<void> main() async {
  AppConfig(env: Environment.development());
  await App.main();
}