// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class SecureStorage {
//   final FlutterSecureStorage secureStorage = FlutterSecureStorage();

//     Future<void> saveToken(String token) async {
//     await secureStorage.write(key: "token", value: token);
//   }

//   Future<String?> getToken() async {
//     return await secureStorage.read(key: "token");
//   }

//   Future<void> logout() async {
//     await secureStorage.delete(key: "token");
//   }
// }
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static const String _tokenKey = "token"; // Use the same key everywhere

  /// Save Token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    print("DEBUG: Saving Token -> $token"); // ✅ Log token
    await prefs.setString(_tokenKey, token); // Use _tokenKey
    print("DEBUG: Token Saved Successfully"); // ✅ Confirm save
  }

  /// Retrieve Token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(_tokenKey); // Use _tokenKey
    print("DEBUG: Retrieved Token -> $token"); // ✅ Log token
    return token;
  }

  /// Remove Token (Logout)
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey); // Use _tokenKey
    print("DEBUG: Token Cleared Successfully"); // ✅ Confirm clear
  }

  /// Test Token Storage
  Future<void> testTokenStorage() async {
    String testToken = "test_token_123";
    await saveToken(testToken);
    String? retrievedToken = await getToken();
    print(
        "DEBUG: Test Token -> $retrievedToken"); // Should print "test_token_123"
  }
}
