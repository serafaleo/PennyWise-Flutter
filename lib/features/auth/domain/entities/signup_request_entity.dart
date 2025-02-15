class SignupRequestEntity {
  final String email;
  final String password;
  final String passwordConfirmation;

  SignupRequestEntity({required this.email, required this.password, required this.passwordConfirmation});
}
