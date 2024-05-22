class AuthService {
  // Ensure only one single service is running in our app
  static final AuthService _singleton = AuthService._internal();

  factory AuthService() {
    return _singleton;
  }

  AuthService._internal();

  Future<bool> login(String username, String password) async {
    return false;
  }
}
