import 'package:shared_preferences/shared_preferences.dart';

class AppTheme{

  static bool isdarkmodeenable = false;

  static Future<void> getThemevalue() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    isdarkmodeenable= pref.getBool("isdarkmode")??false;
  }
}