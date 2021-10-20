import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider with ChangeNotifier {
  final SharedPreferences prefs;
  PreferencesProvider(this.prefs);
  String greet() {
    return "hi";
  }

  bool get isDark => prefs.getBool("darkMode") ?? false;

  Future<void> toggleDarkMode(bool setDark) async {
    await prefs.setBool("darkMode", setDark);
    notifyListeners();
  }

  Future<void> setDeckIcon(List<String> deckIcons) async {
    await prefs.setStringList("deckIcons", deckIcons);
  }

  Future<void> updateAuthRate() async {
    prefs.clear();
    if (prefs.containsKey("authRateLimit")) {
      final int previousValue = prefs.getInt("authRateLimit")!;
      if (previousValue >= 5) {
        if (prefs.containsKey("authRateLimitExpiry")) {
          final DateTime expiryDate =
              DateTime.parse(prefs.getString("authRateLimitExpiry")!);
          if (expiryDate.isBefore(DateTime.now())) {
            await prefs.remove("authRateLimit");
            await prefs.remove("authRateLimitExpiry");
          } else {
            throw Exception("rateLimit");
          }
        } else {
          await prefs.setString(
              "authRateLimitExpiry",
              DateTime.now()
                  .add(Duration(minutes: 5))
                  .toIso8601String()
                  .toString());
          throw Exception("rateLimit");
        }
      } else {
        await prefs.setInt("authRateLimit", previousValue + 1);
      }
    } else {
      await prefs.setInt("authRateLimit", 0);
    }
  }
}
