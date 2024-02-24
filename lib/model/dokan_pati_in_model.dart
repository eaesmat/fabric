class DokanPatiInModel {
  List<Data>? data;

  DokanPatiInModel({this.data});

  DokanPatiInModel.fromJson(Map<String, dynamic> json) {
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
  String? inDate;
  String? fabricPurchaseCode;
  String? bundleName;
  String? patiName;
  int? patiWar;

  Data(
      {this.inDate,
      this.fabricPurchaseCode,
      this.bundleName,
      this.patiName,
      this.patiWar});

  Data.fromJson(Map<String, dynamic> json) {
    inDate = json['inDate'];
    fabricPurchaseCode = json['fabricPurchaseCode'];
    bundleName = json['bundleName'];
    patiName = json['patiName'];
    patiWar = json['patiWar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inDate'] = this.inDate;
    data['fabricPurchaseCode'] = this.fabricPurchaseCode;
    data['bundleName'] = this.bundleName;
    data['patiName'] = this.patiName;
    data['patiWar'] = this.patiWar;
    return data;
  }
}
