import 'package:flutter/material.dart';
import 'package:flutter_garbage_classification/bean/chat_message.dart';
import 'package:flutter_garbage_classification/bean/garbage_info.dart';
import 'package:flutter_garbage_classification/blocs/home_page_bloc.dart';
import 'package:flutter_garbage_classification/util/common.dart';
import 'package:flutter_garbage_classification/util/global.dart';
import 'package:flutter_garbage_classification/util/util.dart';

class ThematicPage extends StatefulWidget {
  @override
  _ThematicPageState createState() => _ThematicPageState();
}

class _ThematicPageState extends State<ThematicPage>
    with AutomaticKeepAliveClientMixin {
  TextEditingController _textController = TextEditingController();

  //聊天信息
  List<ChatMessage> _messages = new List();
  HomePageBloc _homePageBloc = new HomePageBloc();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "这是什么垃圾",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          Flexible(
              child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemBuilder: (_, int index) {
              if (_messages[index].type_user == ME)
                return _buildChatRight(_messages[index].content);
              else
                return _buildChatLeft(_messages[index].content);
            },
            itemCount: _messages.length,
          )),
          Divider(height: 1.0),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildEditText(),
          )
        ]),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  //////UI布局
  Widget _buildEditText() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
              child: TextField(
            //输入框
            controller: _textController,
            onSubmitted: _handleSubmitted,
            decoration: InputDecoration.collapsed(hintText: '请输入查询的垃圾'),
          )),
          GestureDetector(
              onTap: () => _handleSubmitted(_textController.text),
              child: Container(
                //发送按钮
                //margin: const EdgeInsets.symmetric(horizontal: 4.0),
                padding: const EdgeInsets.only(
                    left: 12.0, top: 10, right: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Text(
                  "发送",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              )),
        ],
      ),
    );
  }

  _handleSubmitted(String text) {
    if (text.isEmpty) return;
    print(text);
    setState(() {
      //_messages.insert(0, ChatMessage(user_me, ME, TYPE_TEXT, text));
      _messages.add(ChatMessage("haha", ME, text));
    });
    _textController.clear();
    _homePageBloc.fetchGarabe(text, (GarbageInfo info) {
      //获取到消息的回调，显示Dialog
      setState(() {
        _messages.add(ChatMessage("root", OTHER, info.type));
      });
    });
  }

  //聊天左侧布局
  Widget _buildChatLeft(message) {
    return Container(
      margin: const EdgeInsets.only(left: 5.0, right: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, //对齐方式，左上对齐
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://pp.myapp.com/ma_icon/0/icon_42284557_1517984341/96'),
            radius: 20.0,
          ),
          Flexible(
              child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            decoration: BoxDecoration(
              //设置背景
              color: Theme.of(context).primaryColor,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(10.0)),
            ),
          ))
        ],
      ),
    );
  }

  //聊天右侧布局
  Widget _buildChatRight(message) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end, //对齐方式，左上对齐
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
              child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(
                  fontSize: 14, color: Theme.of(context).primaryColor),
            ),
            decoration: BoxDecoration(
              //设置背景
              color: Colors.white,
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(10.0)),
            ),
          )),
          CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                isNullOrEmpty(Global.instance.token)
                    ? StringImgRes.initHead
                    : StringImgRes.head,
              ))
//          CircleAvatar(
//            backgroundImage: NetworkImage(
//                'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2182894899,3428535748&fm=58&bpow=445&bpoh=605'),
//            radius: 20.0,
//          ),
        ],
      ),
    );
  }
}
