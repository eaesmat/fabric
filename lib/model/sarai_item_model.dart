class SaraiItemModel {
  List<Data>? data;

  SaraiItemModel({this.data});

  SaraiItemModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? indate;
  int? total;
  int? fabricId;
  int? saraiId;
  int? outbundle;
  int? inbundle;

  Data(
      {this.name,
      this.indate,
      this.total,
      this.fabricId,
      this.saraiId,
      this.outbundle,
      this.inbundle});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    indate = json['indate'];
    total = json['total'];
    fabricId = json['fabric_id'];
    saraiId = json['sarai_id'];
    outbundle = json['outbundle'];
    inbundle = json['inbundle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['indate'] = this.indate;
    data['total'] = this.total;
    data['fabric_id'] = this.fabricId;
    data['sarai_id'] = this.saraiId;
    data['outbundle'] = this.outbundle;
    data['inbundle'] = this.inbundle;
    return data;
  }
}
