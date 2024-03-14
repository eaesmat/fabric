class FabricDesignModel {
  List<Data>? data;

  FabricDesignModel({this.data});

  FabricDesignModel.fromJson(Map<String, dynamic> json) {
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
  int? fabricdesignId;
  String? name;
  int? bundle;
  int? war;
  int? toop;
  String? colors;
  int? colorsLength;
  int? countColor;
  String? status;

  Data(
      {this.fabricdesignId,
      this.name,
      this.bundle,
      this.war,
      this.toop,
      this.colors,
      this.colorsLength,
      this.countColor,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    fabricdesignId = json['fabricdesign_id'];
    name = json['name'];
    bundle = json['bundle'];
    war = json['war'];
    toop = json['toop'];
    colors = json['colors'];
    colorsLength = json['colorsLength'];
    countColor = json['countColor'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fabricdesign_id'] = this.fabricdesignId;
    data['name'] = this.name;
    data['bundle'] = this.bundle;
    data['war'] = this.war;
    data['toop'] = this.toop;
    data['colors'] = this.colors;
    data['colorsLength'] = this.colorsLength;
    data['countColor'] = this.countColor;
    data['status'] = this.status;
    return data;
  }
}
