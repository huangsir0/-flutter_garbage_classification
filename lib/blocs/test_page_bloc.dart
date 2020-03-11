import 'package:flutter/foundation.dart';
import 'package:flutter_garbage_classification/bean/data_menu.dart';
import 'package:flutter_garbage_classification/bean/garbage_info.dart';
import 'package:flutter_garbage_classification/bean/knowledge_tip.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import 'base_bloc.dart';

class TestPageBloc extends BaseBloc {
  final _dataMenu = PublishSubject<DataMenu>();

  //监听
  Observable<DataMenu> get dataMenu => _dataMenu.stream;

  void fetchDataMenu(String fileName) async {
    DataMenu info = await netApi.fetchDataMenu(fileName);

    if (!_dataMenu.isClosed) {
      _dataMenu.sink.add(info);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _dataMenu.close();
  }
}
