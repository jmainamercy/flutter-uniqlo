import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniqlo/model/user.dart';
import 'package:uniqlo/service/auth_api.dart';

enum AuthStatus { unauthenticated, authenticating, authenticated }

class AuthViewmodel extends ChangeNotifier {
  late final AuthApi _authApi;
  bool isLoading = false;

  User? user;
  String? errorMessage;

  static const String accessTokenKey = "access_token_key";
  static const String refreshTokenKey = "refresh_token_key";

  AuthStatus authStatus = AuthStatus.authenticating;

  AuthViewmodel({AuthApi? authApi}) {
    _authApi = authApi ?? AuthApi();
    autologin();
  }

  Future<bool> login(String username, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      var result = await _authApi.login(username, password);
      user = result.user;
      await saveUserTokens(result.accessToken, result.refreshToken);
      authStatus = AuthStatus.authenticated;
      return true;
    } on AuthException catch (e) {
      errorMessage = e.message;
      authStatus = AuthStatus.unauthenticated;
      return false;
    } catch (e) {
      errorMessage = e.toString();
      authStatus = AuthStatus.unauthenticated;
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveUserTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessTokenKey, accessToken);
    await prefs.setString(refreshTokenKey, refreshToken);
  }

  Future<void> autologin() async {
    String? accessToken;
    String? refreshToken;

    try {
      final prefs = await SharedPreferences.getInstance();
      accessToken = prefs.getString(accessTokenKey);
      refreshToken = prefs.getString(refreshTokenKey);

      if (accessToken == null || refreshToken == null) {
        authStatus = AuthStatus.unauthenticated;
        notifyListeners();
        return;
      }

      try {
        user = await _authApi.fetchCurrentUser(accessToken);
        authStatus = AuthStatus.authenticated;
      } catch (_) {
        final tokenResponse = await _authApi.refresh(refreshToken);
        accessToken = tokenResponse.accessToken;
        refreshToken = tokenResponse.refreshToken;
        await saveUserTokens(accessToken, refreshToken);

        user = await _authApi.fetchCurrentUser(accessToken);
        authStatus = AuthStatus.authenticated;
      }
    } catch (_) {
      await logout();
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(accessTokenKey);
    await prefs.remove(refreshTokenKey);

    user = null;
    authStatus = AuthStatus.unauthenticated;

    notifyListeners();
  }
}
