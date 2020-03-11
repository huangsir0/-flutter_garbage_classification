import 'package:flutter/material.dart';
import 'package:flutter_garbage_classification/bean/user.dart';
import 'package:flutter_garbage_classification/blocs/mine_page_bloc.dart';
import 'package:flutter_garbage_classification/pages/change_psw_page.dart';
import 'package:flutter_garbage_classification/pages/regist_page.dart';
import 'package:flutter_garbage_classification/util/database_helper.dart';
import 'package:flutter_garbage_classification/util/global.dart';
import 'package:flutter_garbage_classification/util/settings.dart';
import 'package:flutter_garbage_classification/util/util.dart';
import 'package:flutter_garbage_classification/widgets/base_dialog.dart';
import 'package:flutter_garbage_classification/widgets/widgets.dart';

import 'package:flutter_garbage_classification/util/common.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
  //用户信息
  User _user = new User();

  MinePageBloc _minePageBloc = new MinePageBloc();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _pswController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //获取用户信息
    _minePageBloc.fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            InkWell(
              child: Container(
                  alignment: Alignment.center,
                  height: 200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Theme.of(context).primaryColor.withOpacity(.5),
                    Theme.of(context).primaryColor.withOpacity(.7),
                    Theme.of(context).primaryColor.withOpacity(.9),
                  ])),
                  width: double.infinity,
                  child: StreamBuilder(
                    builder: (BuildContext context, AsyncSnapshot<User> shot) {
                      _user = shot.data;
                      if (!isNullOrEmpty(_user.token)) {
                        Global.instance.phone = _user.phone;
                        Global.instance.token = _user.token;
                        Global.instance.psw = _user.password;
                        Global.instance.nickName = _user.nickname;
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 80,
                            width: 80,
                            alignment: Alignment.center,
                            child: CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage(
                                  isNullOrEmpty(_user.token)
                                      ? StringImgRes.initHead
                                      : StringImgRes.head,
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              isNullOrEmpty(_user.nickname)
                                  ? "登录/注册"
                                  : _user.nickname,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        ],
                      );
                    },
                    initialData: _user,
                    stream: _minePageBloc.user,
                  )),
              onTap: () {
                if (isNullOrEmpty(_user.token)) {
                  //去登录注册
                  _showLoginDialog();
                } else {
                  //显示用户信息
                  showDialog(
                      context: context,
                      child: BaseDialog(_aboutMeDialog(), 350,
                          MediaQuery.of(context).size.width * 0.7));
                }
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            item_setting(
              context,
              StringImgRes.zhanghao,
              "账号与安全",
              () {
                if (!isNullOrEmpty(Global.instance.token)) {
                  showDialog(
                      context: context,
                      child: BaseDialog(_aboutMeDialog(), 350,
                          MediaQuery.of(context).size.width * 0.7));
                } else {
                  _showLoginDialog();
                }
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
            ),
            item_setting(context, StringImgRes.shoucang, "收藏", () {}),
            Container(
              margin: EdgeInsets.only(top: 5),
            ),
            item_setting(context, StringImgRes.lianxi, "联系官方", () {}),
            Container(
              margin: EdgeInsets.only(top: 5),
            ),
            item_setting(context, StringImgRes.qiehuan, "切换账号", () {
              _showLoginDialog();
            }),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: InkWell(
                onTap: () {
                  _loginOut(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  alignment: Alignment.center,
                  height: 48,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(colors: [
                        Theme.of(context).primaryColor.withOpacity(.7),
                        Theme.of(context).primaryColor
                      ])),
                  child: Text(
                    "退出登录",
                    style: TextStyle(
                        letterSpacing: 10,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _minePageBloc.dispose();
  }

  //退出登录
  void _loginOut(BuildContext context) async {
    if (Global.instance.token.isNotEmpty) {
      Global.instance.token = "";
      var people = await DatabaseHelper.instance.getUser(Global.instance.phone);
      people.token = "";
      await DatabaseHelper.instance.update(people);
      _minePageBloc.fetchUserInfo();
    } else {
      showToast("请先登录");
    }
  }

  //显示登录Dialog
  void _showLoginDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BaseDialog(
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      Theme.of(context).primaryColor.withOpacity(.5),
                      Theme.of(context).primaryColor.withOpacity(.7),
                      Theme.of(context).primaryColor.withOpacity(.9),
                    ])),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        "用户登录",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 2),
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            edit_widget(_phoneController, "手机号", 240,
                                color: Colors.white),
                            edit_widget(_pswController, "密码", 240,
                                color: Colors.white, isPsw: true),
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              child: InkWell(
                                onTap: () async {
                                  if (_phoneController.text.isEmpty) {
                                    showToast("请输入手机号");
                                    return;
                                  }
                                  if (_pswController.text.isEmpty) {
                                    showToast("请输入密码");
                                    return;
                                  }

                                  var people = await DatabaseHelper.instance
                                      .getUser(_phoneController.text);
                                  if (people == null) {
                                    showToast("该账号尚未注册");
                                    return;
                                  }
                                  if (people.phone == _phoneController.text &&
                                      people.password == _pswController.text) {
                                    showToast("登陆成功");
                                    people.token = "12345"; //标识用户已登录的标识
                                    await DatabaseHelper.instance
                                        .update(people);
                                    await AppSetting.instance
                                        .setUserPhone(people.phone);
                                    await AppSetting.instance
                                        .setUserPsw(people.password);
                                    Global.instance.phone = people.phone;
                                    Global.instance.token = people.token;
                                    Global.instance.psw = people.password;
                                    Global.instance.nickName = people.nickname;
                                    Navigator.of(context).pop(context);
                                    _minePageBloc.fetchUserInfo();
                                  } else {
                                    showToast("手机号或者密码错误");
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.white),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "登录",
                                    style: TextStyle(
                                        letterSpacing: 4,
                                        fontSize: 16,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                    Container(
                      height: 60,
                      width: double.infinity,
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return new RegistPage();
                              }));
                            },
                            child: Container(
                              height: 20,
                              child: Text(
                                "新用户注册",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (_phoneController.text.isEmpty) {
                                showToast("请输入手机号");
                                return;
                              }
                              Navigator.of(context).pop(context);
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return new ChangePswPage(
                                  phone: _phoneController.text,
                                );
                              }));
                            },
                            child: Container(
                              height: 20,
                              child: Text(
                                "忘记密码？",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              340,
              MediaQuery.of(context).size.width * .75);
        });
  }

  Widget _aboutMeDialog() {
    return Column(
      children: <Widget>[
//        Container(
//          margin: EdgeInsets.only(top: 20),
//          alignment: Alignment.center,
//          child: Text(
//            "账号与安全",
//            style: TextStyle(
//                fontSize: 18,
//                letterSpacing: 2,
//                color: Theme.of(context).primaryColor),
//          ),
//        ),
        Expanded(
            child: SingleChildScrollView(
                child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 20),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                      StringImgRes.head,
                    )),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "用户名：",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16),
                      ),
                      Text(
                        Global.instance.nickName,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16),
                      ),
                    ],
                  )),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "手机号：",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16),
                      ),
                      Text(
                        Global.instance.phone,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16),
                      ),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop(context);
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) {
                        return new ChangePswPage(
                          phone: _user.phone,
                        );
                      }));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      width: 120,
                      height: 30,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Theme.of(context).primaryColor.withOpacity(0.4),
                            Theme.of(context).primaryColor
                          ]),
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).primaryColor),
                      child: Text(
                        "修改密码",
                        style: TextStyle(letterSpacing: 3, color: Colors.white),
                      ),
                    )),
              )
            ],
          ),
        )))
      ],
    );
  }
}
