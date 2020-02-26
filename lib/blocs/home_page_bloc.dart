import 'package:flutter/foundation.dart';
import 'package:flutter_garbage_classification/bean/garbage_info.dart';
import 'package:flutter_garbage_classification/bean/knowledge_tip.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import 'base_bloc.dart';

class HomePageBloc extends BaseBloc {
  final _knowledge = PublishSubject<KnowledgeTip>();

  //监听
  Observable<KnowledgeTip> get knowledge => _knowledge.stream;

  //搜索垃圾分类信息
  void fetchGarabe(String name,ValueChanged<GarbageInfo> onResult) async {
    GarbageInfo info = await netApi.searchGarbageInfo(name);

    if (onResult!=null) {
      onResult(info);
    }
  }

  void fetchKnowledgeTip(String fileName) async {
    KnowledgeTip info = await netApi.fetchKnowledgeTip(fileName);

    if (!_knowledge.isClosed) {
      _knowledge.sink.add(info);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _knowledge.close();
  }
}
