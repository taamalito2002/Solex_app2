import '../models/user_model.dart';

class AuthService {
  final List<User> _users = [
    User(email: "test@example.com", password: "123456"),
  ];

  // LOGIN
  bool login(String email, String password) {
    for (var user in _users) {
      if (user.email == email && user.password == password) {
        return true;
      }
    }
    return false;
  }

  // REGISTER
  bool register(User user) {
    if (_users.any((u) => u.email == user.email)) return false;
    _users.add(user);
    return true;
  }

  // Dentro de AuthService
bool usersExist(String email) {
  return _users.any((u) => u.email == email);
}

}

