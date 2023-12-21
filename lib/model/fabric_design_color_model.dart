class FabricDesignColor {
  List<Data>? data;

  FabricDesignColor({this.data});

  FabricDesignColor.fromJson(Map<String, dynamic> json) {
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
  int? fabricdesigncolorId;
  String? colorname;
  int? fabricdesignId;
  int? toop;
  int? war;
  int? bundle;
  String? photo;
  int? userId;
  Fabricdesign? fabricdesign;

  Data(
      {this.fabricdesigncolorId,
      this.colorname,
      this.fabricdesignId,
      this.toop,
      this.war,
      this.bundle,
      this.photo,
      this.userId,
      this.fabricdesign});

  Data.fromJson(Map<String, dynamic> json) {
    fabricdesigncolorId = json['fabricdesigncolor_id'];
    colorname = json['colorname'];
    fabricdesignId = json['fabricdesign_id'];
    toop = json['toop'];
    war = json['war'];
    bundle = json['bundle'];
    photo = json['photo'];
    userId = json['user_id'];
    fabricdesign = json['fabricdesign'] != null
        ? new Fabricdesign.fromJson(json['fabricdesign'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fabricdesigncolor_id'] = this.fabricdesigncolorId;
    data['colorname'] = this.colorname;
    data['fabricdesign_id'] = this.fabricdesignId;
    data['toop'] = this.toop;
    data['war'] = this.war;
    data['bundle'] = this.bundle;
    data['photo'] = this.photo;
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
