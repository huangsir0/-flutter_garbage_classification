class DataMenu {
  String message;
  int code;
  List<Datas> datas;

  DataMenu({this.message, this.code, this.datas});

  DataMenu.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    if (json['datas'] != null) {
      datas = new List<Datas>();
      json['datas'].forEach((v) {
        datas.add(new Datas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.datas != null) {
      data['datas'] = this.datas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datas {
  String name;
  List<String> contents;

  Datas({this.name, this.contents});

  Datas.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    contents = json['contents'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['contents'] = this.contents;
    return data;
  }
}
