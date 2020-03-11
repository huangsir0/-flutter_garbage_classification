import 'package:flutter/material.dart';
import 'package:flutter_garbage_classification/bean/user.dart';
import 'package:flutter_garbage_classification/util/database_helper.dart';
import 'package:flutter_garbage_classification/util/util.dart';
import 'dart:ui';
import 'package:flutter_garbage_classification/widgets/verfiication_code_widget.dart';
import 'package:flutter_garbage_classification/widgets/widgets.dart';

class ChangePswPage extends StatefulWidget {
  final String phone;

  const ChangePswPage({Key key, this.phone}) : super(key: key);

  @override
  _ChangePswPageState createState() => _ChangePswPageState();
}

class _ChangePswPageState extends State<ChangePswPage> {
  GlobalKey<FormState> _secondKey = new GlobalKey<FormState>();

  String _psw;

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
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            top_bar(
                context, "修改密码", MediaQueryData.fromWindow(window).padding.top),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                "重置密码",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            _second()
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
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
                      }),
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
                        //存入数据库
                        User user =await DatabaseHelper.instance.getUser(widget.phone);
                        user.password = _psw;
                        //将数据存入数据库
                        print(user.toString());
                        await DatabaseHelper.instance.update(user);
                        showToast("修改密码成功");
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
