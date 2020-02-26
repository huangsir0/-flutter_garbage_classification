import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_garbage_classification/bean/knowledge_tip.dart';
import 'package:flutter_garbage_classification/util/common.dart';

Widget knowledge_widget(BuildContext context, KnowledgeTip knowledgeTip,
    int index, String labelName) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Column(
      children: <Widget>[
        Container(
          height: 30,
          width: 30,
          child: Image.asset("${StringImgRes.base}${labelName}"),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Text(knowledgeTip.data[index].explains),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Text(
            "${knowledgeTip.data[index].itemName}包括:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Text(knowledgeTip.data[index].contains),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
          child: Text(
            "${knowledgeTip.data[index].itemName}投放提示:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items(knowledgeTip.data[index].tips).toList()),
        ))
      ],
    ),
  );
}

Iterable<Widget> items(List<String> items) sync* {
  for (int i = 1; i <= items.length; i++) {
    yield Container(
      margin: EdgeInsets.all(5),
      child: Text(
        "${i}: ${items[i - 1]}",
        style: TextStyle(),
      ),
    );
  }
}
