import 'package:flutter/material.dart';
import 'package:flutter_garbage_classification/main/home_page.dart';
import 'package:flutter_garbage_classification/main/mine_page.dart';
import 'package:flutter_garbage_classification/main/test_page.dart';
import 'package:flutter_garbage_classification/main/thematic_page.dart';

import 'common/constans.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  var _curIndex = 0;

  var _tabs = ["首页", "专题", "测试", "我的"];

  PageController _pageController;

  List<Widget> _pages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = new PageController(initialPage: _curIndex);
    _pages = [HomePage(), ThematicPage(), TestPage(), MinePage()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        controller: _pageController,
        itemCount: _tabs.length,
        onPageChanged: (index) {
          setState(() {
            _curIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: Icon(MyIcons.home), title: Text(_tabs[0])),
        BottomNavigationBarItem(
            icon: Icon(MyIcons.catagary), title: Text(_tabs[1])),
        BottomNavigationBarItem(
            icon: Icon(MyIcons.test), title: Text(_tabs[2])),
        BottomNavigationBarItem(
            icon: Icon(MyIcons.mine), title: Text(_tabs[3])),
      ],
      currentIndex: _curIndex,
      type: BottomNavigationBarType.fixed,
      fixedColor: Theme.of(context).primaryColor,
      onTap: (index){
        setState(() {
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 200), curve: Curves.linear);
        });
      },),

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
