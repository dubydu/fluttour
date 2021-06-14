import 'package:fluttour/environments/environement.dart';

class AppConfig {
  static final AppConfig shared = AppConfig._private();

  factory AppConfig({required Environment env}) {
    shared.env = env;
    return shared;
  }

  AppConfig._private();
  Environment? env;
}