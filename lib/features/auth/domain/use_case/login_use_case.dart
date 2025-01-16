class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<bool> execute(String email, String password) async {
    final user = await repository.getUser(email);
    return user != null && user.password == password;
  }
}
