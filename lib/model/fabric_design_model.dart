class FabricDesignModel {
  List<Data>? data;
  List<FabricAndBundleButtonColors>? fabricAndBundleButtonColors;
  int? countColorButton;

  FabricDesignModel(
      {this.data, this.fabricAndBundleButtonColors, this.countColorButton});

  FabricDesignModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    if (json['FabricAndBundleButtonColors'] != null) {
      fabricAndBundleButtonColors = <FabricAndBundleButtonColors>[];
      json['FabricAndBundleButtonColors'].forEach((v) {
        fabricAndBundleButtonColors!
            .add(new FabricAndBundleButtonColors.fromJson(v));
      });
    }
    countColorButton = json['countColorButton'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.fabricAndBundleButtonColors != null) {
      data['FabricAndBundleButtonColors'] =
          this.fabricAndBundleButtonColors!.map((v) => v.toJson()).toList();
    }
    data['countColorButton'] = this.countColorButton;
    return data;
  }
}

class Data {
  int? fabricdesignId;
  String? name;
  int? bundle;
  int? war;
  int? toop;
  String? status;
  String? designimage;

  Data(
      {this.fabricdesignId,
      this.name,
      this.bundle,
      this.war,
      this.toop,
      this.status,
      this.designimage});

  Data.fromJson(Map<String, dynamic> json) {
    fabricdesignId = json['fabricdesign_id'];
    name = json['name'];
    bundle = json['bundle'];
    war = json['war'];
    toop = json['toop'];
    status = json['status'];
    designimage = json['designimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fabricdesign_id'] = this.fabricdesignId;
    data['name'] = this.name;
    data['bundle'] = this.bundle;
    data['war'] = this.war;
    data['toop'] = this.toop;
    data['status'] = this.status;
    data['designimage'] = this.designimage;
    return data;
  }
}

class FabricAndBundleButtonColors {
  int? fabricdesigncolorId;
  int? fabricdesignId;
  String? toop;
  String? war;
  String? bundle;
  String? photo;
  int? userId;
  int? colorId;
  String? colorname;
  String? colordescription;

  FabricAndBundleButtonColors(
      {this.fabricdesigncolorId,
      this.fabricdesignId,
      this.toop,
      this.war,
      this.bundle,
      this.photo,
      this.userId,
      this.colorId,
      this.colorname,
      this.colordescription});

  FabricAndBundleButtonColors.fromJson(Map<String, dynamic> json) {
    fabricdesigncolorId = json['fabricdesigncolor_id'];
    fabricdesignId = json['fabricdesign_id'];
    toop = json['toop'];
    war = json['war'];
    bundle = json['bundle'];
    photo = json['photo'];
    userId = json['user_id'];
    colorId = json['color_id'];
    colorname = json['colorname'];
    colordescription = json['colordescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fabricdesigncolor_id'] = this.fabricdesigncolorId;
    data['fabricdesign_id'] = this.fabricdesignId;
    data['toop'] = this.toop;
    data['war'] = this.war;
    data['bundle'] = this.bundle;
    data['photo'] = this.photo;
    data['user_id'] = this.userId;
    data['color_id'] = this.colorId;
    data['colorname'] = this.colorname;
    data['colordescription'] = this.colordescription;
    return data;
  }
}
