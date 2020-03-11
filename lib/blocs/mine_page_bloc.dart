import 'package:flutter_garbage_classification/bean/user.dart';
import 'package:flutter_garbage_classification/util/database_helper.dart';
import 'package:flutter_garbage_classification/util/settings.dart';
import 'package:flutter_garbage_classification/util/util.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import 'base_bloc.dart';

class MinePageBloc extends BaseBloc {
  //
  final _user = PublishSubject<User>();

  //监听
  Observable<User> get user => _user.stream;

  //获取用户信息,这有连个阶段，一个阶段是从共享参数中取到之前存过的手机号，再依据手机号从数据库查找用户信息
  void fetchUserInfo() async {
    User info = await Future(() async {
      String phone = await AppSetting.instance.getUserPhone();
      return phone;
    }).then((phone) async {
      if (!isNullOrEmpty(phone)) {
        User user = await DatabaseHelper.instance.getUser(phone);
        return user;
      }
      return new User();
    }).catchError((e) {
      print(e);
    });
    if (!_user.isClosed) {
      _user.sink.add(info);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _user.close();
  }
}
