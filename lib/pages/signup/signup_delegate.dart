mixin SignUpDelegate {
  Future<void> didSignUpSuccess();
  Future<void> didSignUpFailed(String mgs);
}