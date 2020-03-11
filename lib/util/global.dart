
//全局变量存储
class Global {


  //昵称
  String _nickName;

  //电话
  String _phone;

  //token
  String _token;

  //密码
  String _psw;


  String get nickName => _nickName;

  set nickName(String value) {
    _nickName = value;
  }

  static Global get instance => _getInstance();

  static Global _instance;

  Global._internal();

  static _getInstance() {
    if (null == _instance) {
      _instance = Global._internal();
    }
    return _instance;
  }

  String get phone => _phone;

  set phone(String value) {
    _phone = value;
  }

  String get token => _token;

  set token(String value) {
    _token = value;
  }

  String get psw => _psw;

  set psw(String value) {
    _psw = value;
  }

}
