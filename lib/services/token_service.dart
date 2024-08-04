import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const String _tokenKey = 'token';
  static const String _expiresAtKey = 'expires_at';

  static Future<void> storeToken(String token, int? expiresAt) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_tokenKey, token);
    if(expiresAt != null){
prefs.setInt(_expiresAtKey, expiresAt);
    }
    
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final expiresAt = prefs.getInt(_expiresAtKey);
    if (token != null && expiresAt != null) {
      final currentTime = DateTime.now().millisecondsSinceEpoch / 1000;
      if (expiresAt < currentTime) {
        await removeToken();
        return null;
      }
    }
    return token;
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    
    prefs.remove(_tokenKey);
    prefs.remove(_expiresAtKey);
  }
}
