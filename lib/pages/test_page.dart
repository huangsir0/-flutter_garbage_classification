import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_garbage_classification/bean/data_menu.dart';
import 'package:flutter_garbage_classification/blocs/test_page_bloc.dart';
import 'package:flutter_garbage_classification/util/common.dart';
import 'package:flutter_garbage_classification/util/util.dart';
import 'package:flutter_garbage_classification/widgets/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with AutomaticKeepAliveClientMixin {
  TestPageBloc _testPageBloc = new TestPageBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _testPageBloc.fetchDataMenu("list");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "分类指南",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  getTop("ganlaji.jpg"),
                  getTop("shilaji.jpg"),
                  getTop("kehuishoulaji.jpg"),
                  getTop("youhailaji.jpg"),
                ],
              ),
            ),
            Expanded(
                child: Container(
              child: StreamBuilder(
                builder: (BuildContext context, AsyncSnapshot<DataMenu> shot) {
                  if (shot.hasData) {
                    DataMenu data = shot.data;
                    Map<int, List<String>> tempMap = new Map();
                    List<String> titles = new List();
                    for (int i = 0; i < data.datas.length; i++) {
                      titles.add(data.datas[i].name);
                    }

                    for (int i = 0; i < data.datas[0].contents.length; i++) {
                      List<String> temps = new List();
                      for (int j = 0; j < 4; j++) {
                        temps.add(data.datas[j].contents[i]);
                      }
                      tempMap[i] = temps;
                    }
                    //以上都是在构造数据，Json格式设计的不对，所以才有上面的麻烦
                    return excelAutoWidget(
                        context, titles, tempMap, 80, (key) {});
                  }
                  return Container();
                },
                stream: _testPageBloc.dataMenu,
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await Permission.storage.request().isGranted) {
            //保存图片
            ByteData bytes = await rootBundle.load('assets/images/need.jpeg');
            final result = await ImageGallerySaver.saveImage(
                bytes.buffer.asUint8List()); //这个是核心的保存图片的插件
            print(result); //这个返回值 在保存成功后会返回true
            showToast("保存成功");
          } else {
            showToast("未授权");
          }
        },
        child: Icon(Icons.file_download),
      ),
    );
  }

  Widget getTop(String imgRes) {
    return Container(
      height: 100,
      width: (MediaQuery.of(context).size.width - 40) / 4,
      child: Image.asset("${StringImgRes.base}" + imgRes),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _testPageBloc.dispose();
  }
}
