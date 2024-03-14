class FabricDesignColorModel {
  List<Data>? data;

  FabricDesignColorModel({this.data});

  FabricDesignColorModel.fromJson(Map<String, dynamic> json) {
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
  String? photo;
  int? colorId;

  Data({this.fabricdesigncolorId, this.colorname, this.photo, this.colorId});

  Data.fromJson(Map<String, dynamic> json) {
    fabricdesigncolorId = json['fabricdesigncolor_id'];
    colorname = json['colorname'];
    photo = json['photo'];
    colorId = json['color_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fabricdesigncolor_id'] = this.fabricdesigncolorId;
    data['colorname'] = this.colorname;
    data['photo'] = this.photo;
    data['color_id'] = this.colorId;
    return data;
  }
}
