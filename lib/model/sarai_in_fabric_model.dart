class SaraiInFabricModel {
  List<Data>? data;

  SaraiInFabricModel({this.data});

  SaraiInFabricModel.fromJson(Map<String, dynamic> json) {
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
  String? fabricpurchasecode;
  int? designbundleId;
  String? bundlename;
  int? bundletoop;
  int? description;
  int? fabricdesignId;
  int? userId;
  int? bundlewar;
  String? status;
  String? indate;

  Data(
      {this.fabricpurchasecode,
      this.designbundleId,
      this.bundlename,
      this.bundletoop,
      this.description,
      this.fabricdesignId,
      this.userId,
      this.bundlewar,
      this.status,
      this.indate});

  Data.fromJson(Map<String, dynamic> json) {
    fabricpurchasecode = json['fabricpurchasecode'];
    designbundleId = json['designbundle_id'];
    bundlename = json['bundlename'];
    bundletoop = json['bundletoop'];
    description = json['description'];
    fabricdesignId = json['fabricdesign_id'];
    userId = json['user_id'];
    bundlewar = json['bundlewar'];
    status = json['status'];
    indate = json['indate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fabricpurchasecode'] = this.fabricpurchasecode;
    data['designbundle_id'] = this.designbundleId;
    data['bundlename'] = this.bundlename;
    data['bundletoop'] = this.bundletoop;
    data['description'] = this.description;
    data['fabricdesign_id'] = this.fabricdesignId;
    data['user_id'] = this.userId;
    data['bundlewar'] = this.bundlewar;
    data['status'] = this.status;
    data['indate'] = this.indate;
    return data;
  }
}
