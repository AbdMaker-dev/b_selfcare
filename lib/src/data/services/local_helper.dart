import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class LocaHelper {
  SharedPreferences? prefs;

  Future<SharedPreferences> getSharedPreferences() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs!;
  }

  Future<bool> saveToken(String? token, {DateTime? expiryDate}) async {
    if (token != null) {
      var pf = await getSharedPreferences();
      if (expiryDate != null) {
        await pf.setString('tokenExpiryDate', expiryDate.toIso8601String());
      }
      return await pf.setString("token", token);
    }
    return false;
  }

  Future<String?> getToken() async {
    var pf = await getSharedPreferences();
    return pf.getString("token");
  }

  Future<String?> getExpireDate() async {
    var pf = await getSharedPreferences();
    return pf.getString("tokenExpiryDate");
  }

  /// Retourne true si un token existe et n'est pas expiré.
  /// Efface automatiquement le token si expiré.
  Future<bool> isTokenValid() async {
    final pf = await getSharedPreferences();
    final token = pf.getString("token");
    if (token == null || token.isEmpty) return false;

    final expiryStr = pf.getString("tokenExpiryDate");
    if (expiryStr == null) return false;

    final expiry = DateTime.tryParse(expiryStr);
    if (expiry == null) return false;

    if (DateTime.now().isAfter(expiry)) {
      await logOut();
      return false;
    }

    return true;
  }

  logOut() async {
    var pf = await getSharedPreferences();
    await pf.remove("token");
    await pf.remove("tokenExpiryDate");
  }

  saveLang(String l) async {
    var pf = await getSharedPreferences();
    pf.setString("lang", l);
  }

  Future<String?> getLang() async {
    var pf = await getSharedPreferences();
    return pf.getString("lang");
  }
}
