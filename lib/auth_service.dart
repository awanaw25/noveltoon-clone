import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> register(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    return true;
  }

  Future<bool> signIn(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');

    return storedEmail == email && storedPassword == password;
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }
}
