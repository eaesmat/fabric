class ColorsModel {
  List<Data>? data;

  ColorsModel({this.data});

  ColorsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? colorId;
  String? colorname;
  String? colordescription;

  Data({this.colorId, this.colorname, this.colordescription});

  Data.fromJson(Map<String, dynamic> json) {
    colorId = json['color_id'];
    colorname = json['colorname'];
    colordescription = json['colordescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color_id'] = this.colorId;
    data['colorname'] = this.colorname;
    data['colordescription'] = this.colordescription;
    return data;
  }
}
