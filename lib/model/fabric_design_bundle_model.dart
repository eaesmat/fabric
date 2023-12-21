class FabricDesignBundleModel {
  List<Data>? data;

  FabricDesignBundleModel({this.data});

  FabricDesignBundleModel.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? designbundleId;
  String? bundlename;
  int? bundletoop;
  int? description;
  int? fabricdesignId;
  String? status;
  int? userId;
  Fabricdesign? fabricdesign;

  Data(
      {this.designbundleId,
      this.bundlename,
      this.bundletoop,
      this.description,
      this.fabricdesignId,
      this.status,
      this.userId,
      this.fabricdesign});

  Data.fromJson(Map<String, dynamic> json) {
    designbundleId = json['designbundle_id'];
    bundlename = json['bundlename'];
    bundletoop = json['bundletoop'];
    description = json['description'];
    fabricdesignId = json['fabricdesign_id'];
    status = json['status'];
    userId = json['user_id'];
    fabricdesign = json['fabricdesign'] != null
        ? new Fabricdesign.fromJson(json['fabricdesign'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['designbundle_id'] = this.designbundleId;
    data['bundlename'] = this.bundlename;
    data['bundletoop'] = this.bundletoop;
    data['description'] = this.description;
    data['fabricdesign_id'] = this.fabricdesignId;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    if (this.fabricdesign != null) {
      data['fabricdesign'] = this.fabricdesign!.toJson();
    }
    return data;
  }
}

class Fabricdesign {
  int? fabricdesignId;
  String? name;
  int? bundle;
  int? war;
  int? toop;
  int? fabricpurchaseId;
  String? designimage;
  String? designname;
  int? userId;

  Fabricdesign(
      {this.fabricdesignId,
      this.name,
      this.bundle,
      this.war,
      this.toop,
      this.fabricpurchaseId,
      this.designimage,
      this.designname,
      this.userId});

  Fabricdesign.fromJson(Map<String, dynamic> json) {
    fabricdesignId = json['fabricdesign_id'];
    name = json['name'];
    bundle = json['bundle'];
    war = json['war'];
    toop = json['toop'];
    fabricpurchaseId = json['fabricpurchase_id'];
    designimage = json['designimage'];
    designname = json['designname'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fabricdesign_id'] = this.fabricdesignId;
    data['name'] = this.name;
    data['bundle'] = this.bundle;
    data['war'] = this.war;
    data['toop'] = this.toop;
    data['fabricpurchase_id'] = this.fabricpurchaseId;
    data['designimage'] = this.designimage;
    data['designname'] = this.designname;
    data['user_id'] = this.userId;
    return data;
  }
}
