import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static const String _tokenKey = "token";

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
}
