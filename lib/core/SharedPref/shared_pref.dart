import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static const String _tokenKey = "token";
  static const String _isLoginKey = "isLogin";
  static const String _userNameKey = "userName";
  static const String _hasSeenOnboardingKey = "hasSeenOnboarding";

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    print("DEBUG: Saving Token -> $token");
    await prefs.setString(_tokenKey, token);
    print("DEBUG: Token Saved Successfully");
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_tokenKey);
    print("DEBUG: Retrieved Token -> $token");
    return token;
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    print("DEBUG: Token Cleared Successfully");
  }

  Future<void> testTokenStorage() async {
    String testToken = "test_token_123";
    await saveToken(testToken);
    String? retrievedToken = await getToken();
    print("DEBUG: Test Token -> $retrievedToken");
  }

  // Authentication-related methods
  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoginKey) ?? false;
  }

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoginKey, true);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoginKey, false);
    await prefs.remove(_userNameKey);
  }

  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey) ?? "";
  }

  Future<void> setUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, userName);
  }

  // Onboarding-related methods
  Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasSeenOnboardingKey) ?? false;
  }

  Future<void> setHasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenOnboardingKey, true);
    print("DEBUG: Onboarding marked as seen");
  }
}
