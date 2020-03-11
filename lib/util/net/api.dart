import 'package:flutter_garbage_classification/bean/data_menu.dart';
import 'package:flutter_garbage_classification/bean/garbage_info.dart';
import 'package:flutter_garbage_classification/bean/knowledge_tip.dart';
import 'package:html/parser.dart';

import '../util.dart';
import 'http_respository.dart';

var net = DioFactory.instance;

//网络请求部分，或者其它一些耗时操作
class Api {


  //获取垃圾分类信息，爬虫
  Future<GarbageInfo> searchGarbageInfo(String name) async {
    GarbageInfo data=
    await Future(() async {
      GarbageInfo info = new GarbageInfo();
      //首先去百度图片搜索引擎搜索图片
      var response = await net.getString("${StringApi.baiDuImg}${name}");
      List<String> imgUrls= Rex.matchImgUrl(response);
      //分割字符串
      String tempStr = '"thumbURL":"';
      info.imgUrl=imgUrls.length>0?imgUrls[0].substring(tempStr.length,imgUrls[0].length):"";
      return info;

    }).then((GarbageInfo last ) async {
      //在查询垃圾的分类
      var response;
      response = await net.getString("${StringApi.searchApi}${name}");
      var document = parse(response);
      last.name = document.querySelectorAll(".redes")[0].text.trim();
      last.type = document.querySelectorAll(".redes")[1].text.trim();
      //此网址的图片地址用不了，所以换百度搜索引擎的图片
//      info.imgUrl =
//          "${StringApi.baseUrl}${document.querySelector(".catpic").querySelectorAll(">img")[0].attributes['src']}";
      last.tip = document.querySelector(".xiao").text.trim();
      print(last.toString());

      return last;
    }).catchError((e) => print(e));

    return data;
  }


  //获取首页 垃圾处理技巧实体类
  Future<KnowledgeTip> fetchKnowledgeTip(String fileName) async{

    KnowledgeTip data;

    try{
      var response = await net.localGet(fileName);

      data = KnowledgeTip.fromJson(response);


    }catch(e){

      print(e);
    }

    return data;
  }


  Future<DataMenu> fetchDataMenu(String fileName) async{

    DataMenu data;

    try{
      var response = await net.localGet(fileName);

      data = DataMenu.fromJson(response);


    }catch(e){

      print(e);
    }

    return data;
  }


}

//接口
class StringApi {
  //搜索的接口
  static final String searchApi = "https://smartmll.com/?s=";

  //域名基地址
  static final String baseUrl = "https://smartmll.com/";

  //百度引擎的搜索地址
  static final String baiDuImg =
      "http://image.baidu.com/search/index?tn=baiduimage&fm=result&ie=utf-8&word=";
}
