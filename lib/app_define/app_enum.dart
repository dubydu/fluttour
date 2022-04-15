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
  String getName() {
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
}