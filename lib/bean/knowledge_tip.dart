

//实体类
class KnowledgeTip {
  String message;
  int code;
  List<Data> data;

  KnowledgeTip({this.message, this.code, this.data});

  KnowledgeTip.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String itemName;
  String explains;
  String contains;
  List<String> tips;

  Data({this.itemName, this.explains, this.contains, this.tips});

  Data.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    explains = json['explains'];
    contains = json['contains'];
    tips = json['tips'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemName'] = this.itemName;
    data['explains'] = this.explains;
    data['contains'] = this.contains;
    data['tips'] = this.tips;
    return data;
  }
}
