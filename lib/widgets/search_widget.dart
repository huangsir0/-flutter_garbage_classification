import 'package:flutter/material.dart';

Widget search_widget(
    BuildContext context,
    TextEditingController _queryTextController,
    ValueChanged<String> onSumbitAction) {
  return Container(
    height: 80,
    width: MediaQuery.of(context).size.width / 2 + 40,
    margin: EdgeInsets.only(top: 10),
    alignment: Alignment.center,
    child: TextField(
      textAlign: TextAlign.center,
      autofocus: false,
      controller: _queryTextController,
      textInputAction: TextInputAction.search,
      cursorColor: Theme.of(context).primaryColor,
      cursorWidth: 2,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),
      onSubmitted: (value) {
        if (null != onSumbitAction) {
          onSumbitAction(value);
        }
      },
      decoration: InputDecoration(
          hintStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w200),
          hintText: "请输入要分类的垃圾"),
    ),
  );
}