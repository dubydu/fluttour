import 'package:fluttour/app_define/app_enum.dart';
import 'package:localstorage/localstorage.dart';

class Credential {

  // PRIVATE PROPERTIES
  // -----------------
  // Local storage
  static final Credential singleton = Credential._internal();

  factory Credential() {
    return singleton;
  }

  Credential._internal();

  final LocalStorage storage = new LocalStorage('base_key');

  // PUBLIC PROPERTIES
  // -----------------
  // Token
  Future<String?> getToken() async {
    if (await storage.ready == true) {
      return storage.getItem(CredentialKey.token.getKey());
    }
    return null;
  }

  Future<void> saveToken(String value) async {
    if (await storage.ready == true) {
      storage.setItem(CredentialKey.token.getKey(), value);
    }
  }
}