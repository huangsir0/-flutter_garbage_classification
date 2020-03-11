import 'dart:ui';

import 'package:flutter/material.dart';

class MyColors {
  //主色
  static final String mainColor = "#00d060";

  //配色黄
  static final String yelloColor = "#F8d238";

  //配色黄绿
  static final String greenYelloColor = "#8de26a";

  //配色橙红
  static final String orangeRedColor = "#f58c77";

  //黑色系列
  static final String blackColor9 = "#3b3b3b";

  static final String blackColor7 = "#848484";

  static final String blackColor4 = "#8de26a";

  static final String blackColor1 = "#f58c77";
}

//本地图片地址路径
class StringImgRes {
  //轮播图列表
  static const List<String> banner_list = [
    banner_home_banner1,
    banner_home_banner2
  ];

  //轮播图
  static const banner_home_banner1 = "assets/images/banner1.png";
  static const banner_home_banner2 = "assets/images/banner2.png";

  static const dialog_top = "assets/images/splash.png";


  static const head = "assets/images/head.jpeg";
  static const lianxi = "assets/images/lianxi.png";
  static const qiehuan = "assets/images/qiehuan.png";
  static const shoucang = "assets/images/shoucang.png";
  static const zhanghao = "assets/images/zhanghao.png";

  static const initHead = "assets/images/inithead.png";


  static const base= "assets/images/";



}


//转MaterailColoc 的辅助
Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

