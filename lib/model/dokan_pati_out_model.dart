class DokanPatiOutModel {
  List<Data>? data;

  DokanPatiOutModel({this.data});

  DokanPatiOutModel.fromJson(Map<String, dynamic> json) {
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
  String? outDate;
  String? fabricPurchaseCode;
  String? bundleName;
  String? patiName;
  int? patiWar;
  String? placeTo;

  Data(
      {this.outDate,
      this.fabricPurchaseCode,
      this.bundleName,
      this.patiName,
      this.patiWar,
      this.placeTo});

  Data.fromJson(Map<String, dynamic> json) {
    outDate = json['outDate'];
    fabricPurchaseCode = json['fabricPurchaseCode'];
    bundleName = json['bundleName'];
    patiName = json['patiName'];
    patiWar = json['patiWar'];
    placeTo = json['placeTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['outDate'] = this.outDate;
    data['fabricPurchaseCode'] = this.fabricPurchaseCode;
    data['bundleName'] = this.bundleName;
    data['patiName'] = this.patiName;
    data['patiWar'] = this.patiWar;
    data['placeTo'] = this.placeTo;
    return data;
  }
}
