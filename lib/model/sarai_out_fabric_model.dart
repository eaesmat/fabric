class SaraiOutFabricModel {
  List<Data>? data;

  SaraiOutFabricModel({this.data});

  SaraiOutFabricModel.fromJson(Map<String, dynamic> json) {
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
  String? outdate;
  int? designbundleId;
  String? bundlename;
  int? bundletoop;
  int? description;
  int? fabricdesignId;
  int? userId;
  int? bundlewar;
  String? status;
  String? saraitoname;
  String? customername;
  String? branchname;
  String? fabricpurchasecode;
  String? indate;

  Data(
      {this.outdate,
      this.designbundleId,
      this.bundlename,
      this.bundletoop,
      this.description,
      this.fabricdesignId,
      this.userId,
      this.bundlewar,
      this.status,
      this.saraitoname,
      this.customername,
      this.branchname,
      this.fabricpurchasecode,
      this.indate});

  Data.fromJson(Map<String, dynamic> json) {
    outdate = json['outdate'];
    designbundleId = json['designbundle_id'];
    bundlename = json['bundlename'];
    bundletoop = json['bundletoop'];
    description = json['description'];
    fabricdesignId = json['fabricdesign_id'];
    userId = json['user_id'];
    bundlewar = json['bundlewar'];
    status = json['status'];
    saraitoname = json['saraitoname'];
    customername = json['customername'];
    branchname = json['branchname'];
    fabricpurchasecode = json['fabricpurchasecode'];
    indate = json['indate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['outdate'] = this.outdate;
    data['designbundle_id'] = this.designbundleId;
    data['bundlename'] = this.bundlename;
    data['bundletoop'] = this.bundletoop;
    data['description'] = this.description;
    data['fabricdesign_id'] = this.fabricdesignId;
    data['user_id'] = this.userId;
    data['bundlewar'] = this.bundlewar;
    data['status'] = this.status;
    data['saraitoname'] = this.saraitoname;
    data['customername'] = this.customername;
    data['branchname'] = this.branchname;
    data['fabricpurchasecode'] = this.fabricpurchasecode;
    data['indate'] = this.indate;
    return data;
  }
}
