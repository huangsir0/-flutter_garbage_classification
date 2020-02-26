import 'package:flutter/material.dart';

class ThematicPage extends StatefulWidget {
  @override
  _ThematicPageState createState() => _ThematicPageState();
}

class _ThematicPageState extends State<ThematicPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("专题"),
      ),
      body: Center(
        child: Text("专题"),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
