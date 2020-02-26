import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_garbage_classification/bean/garbage_info.dart';
import 'package:flutter_garbage_classification/bean/knowledge_tip.dart';
import 'package:flutter_garbage_classification/blocs/home_page_bloc.dart';
import 'package:flutter_garbage_classification/common/constans.dart';
import 'package:flutter_garbage_classification/util/common.dart';
import 'package:flutter_garbage_classification/util/util.dart';
import 'package:flutter_garbage_classification/widgets/banner_widget.dart';
import 'package:flutter_garbage_classification/widgets/base_dialog.dart';
import 'package:flutter_garbage_classification/widgets/knowledge_widget.dart';
import 'package:flutter_garbage_classification/widgets/search_widget.dart';
import 'package:flutter_garbage_classification/widgets/vertical_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  HomePageBloc _homePageBloc = new HomePageBloc();

  TextEditingController _searchEditingController = new TextEditingController();

  List<String> _kindsTitles = ["干垃圾", "湿垃圾", "可回收垃圾", "有害垃圾"];

  List<String> _kindsKeys = ["gan", "shi", "kehuishou", "youhai"];

  List<String> _labelNames = [
    "ganlaji.jpg",
    "shilaji.jpg",
    "kehuishoulaji.jpg",
    "youhailaji.jpg"
  ];

  List<Color> _colors = [Colors.black54, Colors.brown, Colors.blue, Colors.red];

  //搜索关键字
  String _searchKeyWords = "";

  //当前类别
  String _curKind = "gan";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //从本地文件获取信息，对应资源在assets目录下
    _homePageBloc.fetchKnowledgeTip("knowledge_tips");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        banner_widget(context),
        search_widget(context, _searchEditingController, (keyWord) {
          _searchKeyWords = keyWord;
        }),
        InkWell(
          child: Container(
            height: 50,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 10),
            width: 240,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                    color: Theme
                        .of(context)
                        .primaryColor, width: 1)),
            child: Text(
              "查询",
              style: TextStyle(
                  letterSpacing: 5,
                  fontSize: 18,
                  color: Theme
                      .of(context)
                      .primaryColor),
            ),
          ),
          onTap: () {
            if (_searchEditingController.text.isEmpty) {
              showToast("请输入关键字查询");
            }
            _searchKeyWords = _searchEditingController.text;

            _homePageBloc.fetchGarabe(_searchKeyWords, (GarbageInfo info) {
              //获取到消息的回调，显示Dialog
              _showTipDialog(context, info);
            });
          },
        ),
        Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 30, bottom: 5),
                width: double.infinity,
                height: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Theme
                          .of(context)
                          .primaryColor
                          .withOpacity(.1),
                      width: 100,
                      child: Column(
                        children: kindSelects.toList(),
                      ),
                    ),
                    Expanded(
                        child: Container(
                          color: Colors.white10,
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(10),
                                width: double.infinity,
                                height: 370,
                                color: _colors[_kindsKeys.indexOf(_curKind)]
                                    .withOpacity(.1),
                                child: StreamBuilder(
                                  builder: (BuildContext context,
                                      AsyncSnapshot<KnowledgeTip> shot) {
                                    if (shot.hasData) {
                                      return knowledge_widget(
                                          context,
                                          shot.data,
                                          _kindsKeys.indexOf(_curKind),
                                          _labelNames[_kindsKeys.indexOf(
                                              _curKind)]);
                                    }
                                    return Container(
                                    );
                                  },
                                  stream: _homePageBloc.knowledge,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ))
      ],
    );
  }

  Iterable<Widget> get kindSelects sync* {
    for (String kind in _kindsKeys) {
      yield VerticalWidget(
        selectedColor: _colors[_kindsKeys.indexOf(kind)],
        label: _kindsTitles[_kindsKeys.indexOf(kind)],
        isSelect: _curKind == kind,
        onSelected: (bool value) {
          setState(() {
            if (value) {
              _curKind = kind;
            }
          });
        },
      );
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _homePageBloc.dispose();
  }

  //显示Dialog
  void _showTipDialog(BuildContext context, GarbageInfo info) {
    showDialog(context: context, builder: (BuildContext context) {

      String handle= info.tip.replaceAll('[','').replaceAll(']', '');
      List<String> tips= handle.split("。");
      tips.removeLast();
      print(tips);

      int randomIndex = new Random().nextInt(tips.length);
      return BaseDialog( Container(

        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: <Widget>[
            Container(
               height: 80,
              width: double.infinity,
              alignment: Alignment.center,
              color: Theme.of(context).primaryColor.withOpacity(.7),
              child: Text(info.name,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.white,letterSpacing: 5),),
            ),
            Expanded(
                child: Container(
                  margin: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: Text(info.type,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: hexToColor(MyColors.orangeRedColor),letterSpacing: 5),),
                )),
            Container(
              height: 80,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 15),
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(tips[randomIndex]+"。",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: hexToColor(MyColors.blackColor9)),),
            )
          ],
        ),
      ), MediaQuery
          .of(context)
          .size
          .height * .4, MediaQuery
          .of(context)
          .size
          .width * .8);
    });
  }
}
