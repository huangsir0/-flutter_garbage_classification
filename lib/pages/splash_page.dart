import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_garbage_classification/util/util.dart';
import 'package:flutter_garbage_classification/widgets/vertical_text.dart';
import 'package:intro_slider/slide_object.dart';
import '../main_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  List<Slide> slides = new List();
  Timer _timer;
  int _countdownTime = 3;

  void startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);

    var callback = (timer) {
      if (_countdownTime < 1) {
        _timer.cancel();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      } else {
        print(_countdownTime.toString());
        setState(() {
          _countdownTime = _countdownTime - 1;
        });
      }
    };

    _timer = Timer.periodic(oneSec, callback);
  }

  @override
  void initState() {
    super.initState();

    //开始倒计时
    startCountdownTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexToColor("#81FBB8"),
          hexToColor("#28C76F"),
        ])),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 90),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 40),
                child: CustomPaint(
                  painter: VerticalText(
                    text: "世界上没有垃圾，只有放错地方的宝藏。",
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 4,
                        wordSpacing: 4),
                    width: 60,
                    height: 500,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height - 120,
                    left: MediaQuery.of(context).size.width - 200),
                child: Text(
                  _countdownTime.toString() + " 秒",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }
}
