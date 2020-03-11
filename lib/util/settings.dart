import 'package:shared_preferences/shared_preferences.dart';

class AppSetting {
  //存储的Key
  //用户名
  static const app_user_phone = "app_user_phone";

  //密码
  static const app_user_psd = "app_user_psd";

  static AppSetting get instance => _getInstance();

  //带下划线的是私有变量
  static AppSetting _instance;

  // 构造
  AppSetting._internal() {}

  static _getInstance() {
    if (null == _instance) _instance = AppSetting._internal();
    return _instance;
  }


  //////////////////存储

  //用户名
  Future<void> setUserPhone(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(app_user_phone, phone);

    return null;
  }


  //密码
  Future<void> setUserPsw(String psw) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(app_user_psd, psw);

    return null;
  }


  /////////////////////获取
  //密码
  Future<String> getUserPsw() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(app_user_psd);
  }


  //用户名
  Future<String> getUserPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(app_user_phone);
  }
}
