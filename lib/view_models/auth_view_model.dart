import 'package:final_project/models/auth/api/auth_api.dart';
import 'package:final_project/models/auth/login_model.dart';
import 'package:final_project/models/auth/register_model.dart';
import 'package:final_project/models/auth/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthApi authApi = AuthApi();

  late UserModel _user;
  UserModel get user => _user;

  Future<void> loginRequest(LoginModel login) async {
    try {
      await authApi.loginRequest(login);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> registerRequest(RegisterModel register) async {
    try {
      await authApi.registerRequest(register);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> logoutRequest() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await authApi.logoutRequest().then(
            (_) => prefs.remove(
              'token',
            ),
          );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> refreshToken() async {
    try {
      await authApi.refreshToken();
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }
}
