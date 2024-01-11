class PatiModel {
  List<Data>? data;

  PatiModel({this.data});

  PatiModel.fromJson(Map<String, dynamic> json) {
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
  int? patiId;
  String? patiname;
  String? description;
  int? toop;
  String? bundlecode;
  List<Patidesigncolor>? patidesigncolor;

  Data(
      {this.patiId,
      this.patiname,
      this.description,
      this.toop,
      this.bundlecode,
      this.patidesigncolor});

  Data.fromJson(Map<String, dynamic> json) {
    patiId = json['pati_id'];
    patiname = json['patiname'];
    description = json['description'];
    toop = _checkInt(json['toop']);
    bundlecode = json['bundlecode'];
    if (json['patidesigncolor'] != null) {
      patidesigncolor = <Patidesigncolor>[];
      json['patidesigncolor'].forEach((v) {
        patidesigncolor!.add(new Patidesigncolor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pati_id'] = this.patiId;
    data['patiname'] = this.patiname;
    data['description'] = this.description;
    data['toop'] = this.toop;
    data['bundlecode'] = this.bundlecode;
    if (this.patidesigncolor != null) {
      data['patidesigncolor'] =
          this.patidesigncolor!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  int? _checkInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value);
    } else {
      return null;
    }
  }
}

class Patidesigncolor {
  int? patidesigncolorId;
  int? fabricdesigncolorId;
  int? war;
  int? patiId;
  int? designbundleId;
  int? userId;

  Patidesigncolor(
      {this.patidesigncolorId,
      this.fabricdesigncolorId,
      this.war,
      this.patiId,
      this.designbundleId,
      this.userId});

  Patidesigncolor.fromJson(Map<String, dynamic> json) {
    patidesigncolorId = json['patidesigncolor_id'];
    fabricdesigncolorId = json['fabricdesigncolor_id'];
    war = json['war'];
    patiId = json['pati_id'];
    designbundleId = json['designbundle_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patidesigncolor_id'] = this.patidesigncolorId;
    data['fabricdesigncolor_id'] = this.fabricdesigncolorId;
    data['war'] = this.war;
    data['pati_id'] = this.patiId;
    data['designbundle_id'] = this.designbundleId;
    data['user_id'] = this.userId;
    return data;
  }

   
}
