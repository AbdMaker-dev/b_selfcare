import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_deails_model.dart';

// @Named("LocaHelper")
@injectable
class LocaHelper {
  var prefs;
  Future<SharedPreferences> getSharedPreferences() async {
    prefs ??= await SharedPreferences.getInstance();
    return prefs;
  }

  Future<bool> saveToken(String? token, {DateTime? expiryDate}) async {
    if (token != null) {
      var pf = await getSharedPreferences();
      if(expiryDate != null){
        await pf.setString('tokenExpiryDate', expiryDate.toIso8601String());
      }
      return  await pf.setString("token", token);
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

  Future<void> saveCustomerData(UserDetailsModel data) async {
    var pf = await getSharedPreferences();
    pf.setString("customer", jsonEncode(data.toJson()));
  }

  Future<UserDetailsModel?> getCustomerData() async {
    var pf = await getSharedPreferences();
    var data = pf.getString("customer");
    if (data != null) {
      return UserDetailsModel.fromJson(jsonDecode(data));
    } else {
      return null;
    }
  }

  logOut() async {
    var pf = await getSharedPreferences();
    await pf.remove("token");
    await pf.remove("customer");
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
