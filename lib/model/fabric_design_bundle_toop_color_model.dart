class FabricDesignBundleToopColorModel {
  List<Data>? data;

  FabricDesignBundleToopColorModel({this.data});

  FabricDesignBundleToopColorModel.fromJson(Map<String, dynamic> json) {
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
  String? colorname;
  int? fabricdesigncolorId;

  Data({this.colorname, this.fabricdesigncolorId});

  Data.fromJson(Map<String, dynamic> json) {
    colorname = json['colorname'];
    fabricdesigncolorId = json['fabricdesigncolor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['colorname'] = this.colorname;
    data['fabricdesigncolor_id'] = this.fabricdesigncolorId;
    return data;
  }
}
