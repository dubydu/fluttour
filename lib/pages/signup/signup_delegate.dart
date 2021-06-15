mixin SignUpDelegate {
  Future<void> didSignInSuccess();
  Future<void> didSignInFailed(String mgs);
}