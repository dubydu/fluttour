import 'package:fluttour/app_define/app_route.dart';

enum CredentialKey {
  token
}

extension CredentialKeyExtension on CredentialKey {
  String getKey() {
    switch (this) {
      case CredentialKey.token:
        return 'user_token';
      default:
        return '';
    }
  }
}

enum Tutorial {
  pagination,
  mutations,
  web3
}

extension TutorialExtension on Tutorial {
  String title() {
    switch (this) {
      case Tutorial.pagination:
        return 'Pagination';
      case Tutorial.mutations:
        return 'Mutations';
      case Tutorial.web3:
        return 'Web3';
      default:
        return '';
    }
  }

  String router() {
    switch (this) {
      case Tutorial.pagination:
        return AppRoute.routeFetchData;
      case Tutorial.mutations:
        return AppRoute.routeDataMutations;
      case Tutorial.web3:
        return AppRoute.routeWeb3;
      default:
        return '';
    }
  }
}