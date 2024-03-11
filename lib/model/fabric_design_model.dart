class FabricDesignModel {
  List<Data>? data;
  int? countColorButton;
  List<FabricAndBundleButtonColors>? fabricAndBundleButtonColors;

  FabricDesignModel(
      {this.data, this.countColorButton, this.fabricAndBundleButtonColors});

  FabricDesignModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    countColorButton = json['countColorButton'];
    if (json['FabricAndBundleButtonColors'] != null) {
      fabricAndBundleButtonColors = <FabricAndBundleButtonColors>[];
      json['FabricAndBundleButtonColors'].forEach((v) {
        fabricAndBundleButtonColors!
            .add(new FabricAndBundleButtonColors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['countColorButton'] = this.countColorButton;
    if (this.fabricAndBundleButtonColors != null) {
      data['FabricAndBundleButtonColors'] =
          this.fabricAndBundleButtonColors!.map((v) => v.toJson()).toList();
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
  int? fabricpurchaseId;
  String? designimage;
  String? designname;
  int? userId;
  String? status;

  Data(
      {this.fabricdesignId,
      this.name,
      this.bundle,
      this.war,
      this.toop,
      this.fabricpurchaseId,
      this.designimage,
      this.designname,
      this.userId,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    fabricdesignId = json['fabricdesign_id'];
    name = json['name'];
    bundle = json['bundle'];
    war = json['war'];
    toop = json['toop'];
    fabricpurchaseId = json['fabricpurchase_id'];
    designimage = json['designimage'];
    designname = json['designname'];
    userId = json['user_id'];
    status = json['status'];
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
    data['status'] = this.status;
    return data;
  }
}

class FabricAndBundleButtonColors {
  int? colorId;
  int? fabricdesignId;
  int? fabricdesigncolorId;
  int? userId;
  String? colorname;

  FabricAndBundleButtonColors(
      {this.colorId,
      this.fabricdesignId,
      this.fabricdesigncolorId,
      this.userId,
      this.colorname});

  FabricAndBundleButtonColors.fromJson(Map<String, dynamic> json) {
    colorId = json['color_id'];
    fabricdesignId = json['fabricdesign_id'];
    fabricdesigncolorId = json['fabricdesigncolor_id'];
    userId = json['user_id'];
    colorname = json['colorname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color_id'] = this.colorId;
    data['fabricdesign_id'] = this.fabricdesignId;
    data['fabricdesigncolor_id'] = this.fabricdesigncolorId;
    data['user_id'] = this.userId;
    data['colorname'] = this.colorname;
    return data;
  }
}
