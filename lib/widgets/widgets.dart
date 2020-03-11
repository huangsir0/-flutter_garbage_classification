//条目

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget item_setting(
    BuildContext context, String fileUrl, String title, Function onTap,
    {bool clickable = true}) {
  return Material(
    child: InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 70,
        width: double.infinity,
        padding: EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Image(
                    image: AssetImage(fileUrl),
                    fit: BoxFit.cover,
                    color: Theme.of(context).primaryColor,
                  ),
                  height: 25,
                  width: 25,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18, letterSpacing: 1),
                  ),
                )
              ],
            ),
            clickable
                ? IconButton(
                    icon: Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: null)
                : Container(),
          ],
        ),
      ),
    ),
  );
}

Widget edit_widget(
    TextEditingController _queryTextController, String hint, double width,
    {Color color = Colors.black,bool isPsw=false}) {
  return Container(
    height: 40,
    width: width,
    margin: EdgeInsets.only(top: 10),
    alignment: Alignment.center,
    child: TextField(
      obscureText: isPsw,
      textAlign: TextAlign.left,
      autofocus: false,
      controller: _queryTextController,
      cursorWidth: 2,
      cursorColor: color,
      style: TextStyle(color: color, fontSize: 20),
      decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: color)),
          hintStyle: TextStyle(
              color: color, fontSize: 16, fontWeight: FontWeight.w500),
          hintText: hint),
    ),
  );
}

Widget top_bar(BuildContext context, String title, double statusHeight) {
  return Container(
    width: double.infinity,
    //+ 状态栏高度
    height: kToolbarHeight + statusHeight,
    child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          top: statusHeight,
        ),
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop(context);
                }),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 30),
                height: kToolbarHeight,
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        )),
  );
}

/////////////////////////////////////////////////////华丽的分割线//////////////////////////////////////////////////
/////////////////////////////////////////////////////华丽的分割线//////////////////////////////////////////////////
/////////////////////////////////////////////////////华丽的分割线//////////////////////////////////////////////////
//表格
Widget excelAutoWidget(BuildContext context, List<String> titles,
    Map<int, List<String>> maps, double height, ValueChanged<String> onTap) {
  return Container(
    child: Column(
      children: <Widget>[
        //第一行
        Table(
            border: TableBorder.all(
                color: Colors.grey, width: 1.0, style: BorderStyle.solid),
            children: [
              _buildNomalTableRow(context, titles,
                  Theme.of(context).primaryColor.withOpacity(.2), height)
            ]),

        //于下的表内容
        Expanded(
          child: SingleChildScrollView(
            child: Table(
                border: TableBorder.all(
                    color: Colors.grey, width: 1.0, style: BorderStyle.solid),
                children: _getAutoContentRows(context, maps, height, onTap)),
          ),
        )
      ],
    ),
  );
}

//可点击的头部
TableRow _buildAutoTableRow(BuildContext context, List<String> datas,
    Color color, double height, ValueChanged<String> onTap) {
  return TableRow(
      decoration: BoxDecoration(
        color: color,
      ),
      children: _getAutoCell(context, datas, height, onTap));
}

//表头
TableRow _buildNomalTableRow(
    BuildContext context, List<String> datas, Color color, double height) {
  return TableRow(
      decoration: BoxDecoration(
        color: color,
      ),
      children: _getNormalCell(context, datas, height));
}

//内容列
List<TableRow> _getAutoContentRows(BuildContext context,
    Map<int, List<String>> maps, double height, ValueChanged<String> onTap) {
  List<TableRow> _rows = new List();
  maps.forEach((int index, List<String> data) {
    Color color = index % 2 == 0 ? Colors.white : Colors.grey[200];
    _rows.add(_buildAutoTableRow(context, data, color, height, onTap));
  });
  return _rows;
}

//头部不可点击的条目
List<TableCell> _getNormalCell(
    BuildContext context, List<String> datas, double height) {
  List<TableCell> _cells = List();
  for (int i = 0; i < datas.length; i++) {
    _cells.add(TableCell(
      child: Container(
        height: height,
        alignment: Alignment.center,
        child: Text(datas[i],
            style: TextStyle(color: Colors.black, fontSize: 16.0)),
      ),
      verticalAlignment: TableCellVerticalAlignment.middle,
    ));
  }

  return _cells;
}

//头部可以点击的条目
List<TableCell> _getAutoCell(BuildContext context, List<String> datas,
    double height, ValueChanged<String> onTap) {
  List<TableCell> _cells = List();
  for (int i = 0; i < datas.length; i++) {
    _cells.add(TableCell(
      child: i == 0
          ? Container(
        child: InkWell(
          onTap: () {
            onTap(datas[i]);
          },
          child: Container(
            height: height,
            alignment: Alignment.center,
            child: Text(datas[i],
                style: TextStyle(
                    color: i == 0 ? Colors.black : Colors.black,
                    fontSize: 16.0)),
          ),
        ),
      )
          : Container(
        height: height,
        alignment: Alignment.center,
        child: Text(datas[i],
            style: TextStyle(color: Colors.black, fontSize: 16.0)),
      ),
      verticalAlignment: TableCellVerticalAlignment.middle,
    ));
  }

  return _cells;
}
