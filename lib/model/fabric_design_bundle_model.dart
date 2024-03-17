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
  int? bundlewar;
  int? userId;
  String? toopwar;
  int? countFabricDesignColorId;
  String? designBundleWar;
  String? status;

  Data(
      {this.designbundleId,
      this.bundlename,
      this.bundletoop,
      this.description,
      this.fabricdesignId,
      this.bundlewar,
      this.userId,
      this.toopwar,
      this.countFabricDesignColorId,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    designbundleId = json['designbundle_id'];
    bundlename = json['bundlename'];
    bundletoop = json['bundletoop'];
    description = json['description'];
    fabricdesignId = json['fabricdesign_id'];
    bundlewar = json['bundlewar'];
    userId = json['user_id'];
    toopwar = json['toopwar'];
    countFabricDesignColorId = json['countFabricDesignColorId'];
    designBundleWar = json['designBundleWar'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['designbundle_id'] = this.designbundleId;
    data['bundlename'] = this.bundlename;
    data['bundletoop'] = this.bundletoop;
    data['description'] = this.description;
    data['fabricdesign_id'] = this.fabricdesignId;
    data['bundlewar'] = this.bundlewar;
    data['user_id'] = this.userId;
    data['toopwar'] = this.toopwar;
    data['countFabricDesignColorId'] = this.countFabricDesignColorId;
    data['designBundleWar'] = this.designBundleWar;
    data['status'] = this.status;
    return data;
  }
}
