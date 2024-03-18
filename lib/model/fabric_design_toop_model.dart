class FabricDesignToopModel {
  List<Data>? data;

  FabricDesignToopModel({this.data});

  FabricDesignToopModel.fromJson(Map<String, dynamic> json) {
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
  int? patidesigncolorId;
  int? fabricdesigncolorId;
  int? war;
  String? colorname;
  String? status;

  Data(
      {this.patidesigncolorId,
      this.fabricdesigncolorId,
      this.war,
      this.colorname,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    patidesigncolorId = json['patidesigncolor_id'];
    fabricdesigncolorId = json['fabricdesigncolor_id'];
    war = json['war'];
    colorname = json['colorname'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patidesigncolor_id'] = this.patidesigncolorId;
    data['fabricdesigncolor_id'] = this.fabricdesigncolorId;
    data['war'] = this.war;
    data['colorname'] = this.colorname;
    data['status'] = this.status;
    return data;
  }
}
