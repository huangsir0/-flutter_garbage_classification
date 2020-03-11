import 'dart:math';
import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

Color hexToColor(String s) {
  // 如果传入的十六进制颜色值不符合要求，返回默认值
  if (s == null ||
      s.length != 7 ||
      int.tryParse(s.substring(1, 7), radix: 16) == null) {
    s = '#999999';
  }

  return new Color(int.parse(s.substring(1, 7), radix: 16) + 0xFF000000);
}

showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      fontSize: 16.0);
}

//正则匹配的类
class Rex {
  //匹配正则,以"thumbURL"开头，.jpg结束的字符
  static final String imgRex = '"thumbURL".*?.jpg';

  //从庞大的网页数据中获取自己所需数据
  static List<String> matchImgUrl(String source) {
    RegExp regExp = new RegExp(imgRex);

    Iterable<Match> matches = regExp.allMatches(source);

    List<String> urls = new List();

    for (Match match in matches) {
      print(match.group(0));
      if (match.group(0)?.isNotEmpty) {
        urls.add(match.group(0));
      }
    }

    //返回图片地址
    return urls;
  }
}

class Util {

  static Random _random = new Random();

  static String getString(int digitCount) {
    String s = "";
    for (var i = 0; i < digitCount; i++) {
      s += _random.nextInt(10).toString();
    }
    return s;
  }
}

//为空判断
bool isNullOrEmpty(String msg) {
  if (msg == null) return true;
  return msg.length == 0;
}
