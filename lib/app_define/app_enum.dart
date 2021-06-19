
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
  layoutState,
  gridView,
}

extension TutorialExtension on Tutorial {
  String getName() {
    switch (this) {
      case Tutorial.layoutState:
        return 'Layout\'s State';
      case Tutorial.gridView:
        return 'Grid View';
      case Tutorial.pagination:
        return 'Pagination';
      case Tutorial.mutations:
        return 'Mutations';
      default:
        return '';
    }
  }
}

enum Identity {
  front,
  back
}

extension IdentityExtension on Identity {
  String title() {
    switch (this) {
      case Identity.front:
        return 'Front side of your ID';
      case Identity.back:
        return 'Back side of your ID';
      default:
        return '';
    }
  }
}