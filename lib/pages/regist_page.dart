import 'package:flutter/material.dart';
import 'package:flutter_garbage_classification/bean/user.dart';
import 'package:flutter_garbage_classification/util/database_helper.dart';
import 'package:flutter_garbage_classification/util/util.dart';
import 'dart:ui';

import 'package:flutter_garbage_classification/widgets/verfiication_code_widget.dart';
import 'package:flutter_garbage_classification/widgets/widgets.dart';

class RegistPage extends StatefulWidget {
  @override
  _RegistPageState createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  //控制显示页面
  int _curPage = 0;
  GlobalKey<FormState> _firstKey = new GlobalKey<FormState>();
  GlobalKey<FormState> _secondKey = new GlobalKey<FormState>();

  GlobalKey<CodeReviewState> _globalKey = new GlobalKey<CodeReviewState>();

  String _userName;

  String _phone;

  String _verifyCode;

  String _psw;

  String _code = '1245';

  //图形验证码是否可以点击
  bool _clickable = true;

  List<String> titles = ["填写用户信息", "设置密码"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    DatabaseHelper.instance.close();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Container(
            child: Column(
              children: <Widget>[
                top_bar(context, "用户注册",
                    MediaQueryData.fromWindow(window).padding.top),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    titles[_curPage],
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                _curPage == 0 ? _first() : _second()
              ],
            ),
          ),
          resizeToAvoidBottomInset: false,
        ),
        onWillPop: () async {
          if (_curPage == 1) {
            setState(() {
              _curPage = 0;
            });
          } else {
            return true;
          }
          return false;
        });
  }

  //第一页
  Widget _first() {
    return Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.only(right: 20, left: 20),
        child: Form(
            key: _firstKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: TextFormField(
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                        labelText: "请输入用户名",
                        helperStyle: TextStyle(color: Colors.red)),
                    validator: (value) =>
                        value.trim().isEmpty ? '用户名不能为空' : null,
                    onSaved: (value) {
                      _userName = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                        labelText: "请输入手机号",
                        helperStyle: TextStyle(color: Colors.red)),
                    validator: (value) =>
                        value.trim().isEmpty ? '手机号不能为空' : null,
                    onSaved: (value) {
                      _phone = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                              labelText: "请输入验证码",
                              helperStyle: TextStyle(color: Colors.red)),
                          validator: (value) => value.trim().length > 0
                              ? value != _code ? "验证码不正确" : null
                              : '验证码长度不能为空',
                          onSaved: (value) {
                            _verifyCode = value;
                          },
                        ),
                      ),
                      Container(
                        height: 80,
                        margin: EdgeInsets.only(top: 20, left: 10),
                        alignment: Alignment.center,
                        child: InkWell(
                            onTap: () {
                              setState(() {});
                            },
                            child: Container(
                                margin: EdgeInsets.only(top: 20, left: 10),
                                width: 80,
                                height: 40,
                                child: CodeReview(
                                  key: _globalKey,
                                  text: _code,
                                  onTap: () {
                                    if (!_clickable) return;
                                    _clickable = false;
                                    Future.delayed(new Duration(seconds: 1),
                                        () {
                                      _clickable = true;
                                      _code = Util.getString(4);
                                      setState(() {
                                        _globalKey.currentState
                                            .changeData(_code);
                                      });
                                    });
                                  },
                                ))),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: InkWell(
                    onTap: () {
                      if (_firstKey.currentState.validate()) {
                        _firstKey.currentState.save();
                        setState(() {
                          _curPage = 1;
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 20,
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
                        "下一步",
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
            )));
  }

  //第二页
  Widget _second() {
    return Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.only(right: 20, left: 20),
        child: Form(
            key: _secondKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: TextFormField(
                    obscureText: true,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                        labelText: "请输入密码",
                        helperStyle: TextStyle(color: Colors.red)),
                    validator: (value) {
                      _psw = value;
                      return value.trim().isEmpty ? '密码不能为空' : null;
                    },
                    onSaved: (value) {
                      _psw = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: TextFormField(
                    obscureText: true,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                        labelText: "请确认密码",
                        helperStyle: TextStyle(color: Colors.red)),
                    validator: (value) => value.trim().isEmpty
                        ? '密码不能为空'
                        : value != _psw ? "密码不一致" : null,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: InkWell(
                    onTap: () async {
                      if (_secondKey.currentState.validate()) {
                        _secondKey.currentState.save();
                        //存入数据库
                        User user = new User();
                        user.phone = _phone;
                        user.nickname = _userName;
                        user.password = _psw;
                        //将数据存入数据库

                        print(user.toString());
                        bool result =
                            await DatabaseHelper.instance.insert(user);
                        if (result) {
                          showToast("注册成功");
                        } else {
                          showToast("该手机号已注册");
                        }
                        Future.delayed(new Duration(milliseconds: 800))
                            .then((_) {
                          Navigator.of(context).pop(this);
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 20,
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
                        "完成",
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
            )));
  }
}
