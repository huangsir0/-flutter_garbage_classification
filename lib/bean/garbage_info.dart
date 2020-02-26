



//垃圾实体类
//此实体类区别于Json实体类的构造，因为这个是爬虫解析获取的实体类内容
class GarbageInfo{

  //垃圾名字
  String _name;


  //垃圾的图片
  String _imgUrl;

  //垃圾的类型
  String  _type;

  //垃圾处理技巧
  String _tip;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get imgUrl => _imgUrl;

  set imgUrl(String value) {
    _imgUrl = value;
  }

  String get tip => _tip;

  set tip(String value) {
    _tip = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  @override
  String toString() {
    return 'GarbageInfo{_name: $_name, _imgUrl: $_imgUrl, _type: $_type, _tip: $_tip}';
  }


}