import 'package:flutter_garbage_classification/util/database_helper.dart';

class User {
  //电话号码
  String phone;

  //密码
  String password;

  //token,根据token判断用户当前是否登录
  String token;

  //昵称
  String nickname;

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    User user = new User();
    user.phone = map['phone'];
    user.password = map['password'];
    user.token = map['token'];
    user.nickname=map['nickname'];
    return user;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnPhone: phone,
      columnPsw: password,
      columnNickName:nickname,
      columnToken: token,
    };
    return map;
  }

  @override
  String toString() {
    return 'User{phone: $phone, password: $password, token: $token, nickname: $nickname}';
  }


}
