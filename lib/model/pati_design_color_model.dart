class PatiDesignColorModel {
  List<Data>? data;

  PatiDesignColorModel({this.data});

  PatiDesignColorModel.fromJson(Map<String, dynamic> json) {
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
  int? patiId;
  int? designbundleId;
  int? userId;
  Designbundle? designbundle;
  Fabricdesigncolor? fabricdesigncolor;
  Pati? pati;

  Data(
      {this.patidesigncolorId,
      this.fabricdesigncolorId,
      this.war,
      this.patiId,
      this.designbundleId,
      this.userId,
      this.designbundle,
      this.fabricdesigncolor,
      this.pati});

  Data.fromJson(Map<String, dynamic> json) {
    patidesigncolorId = json['patidesigncolor_id'];
    fabricdesigncolorId = json['fabricdesigncolor_id'];
    war = json['war'];
    patiId = json['pati_id'];
    designbundleId = json['designbundle_id'];
    userId = json['user_id'];
    designbundle = json['designbundle'] != null
        ? new Designbundle.fromJson(json['designbundle'])
        : null;
    fabricdesigncolor = json['fabricdesigncolor'] != null
        ? new Fabricdesigncolor.fromJson(json['fabricdesigncolor'])
        : null;
    pati = json['pati'] != null ? new Pati.fromJson(json['pati']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patidesigncolor_id'] = this.patidesigncolorId;
    data['fabricdesigncolor_id'] = this.fabricdesigncolorId;
    data['war'] = this.war;
    data['pati_id'] = this.patiId;
    data['designbundle_id'] = this.designbundleId;
    data['user_id'] = this.userId;
    if (this.designbundle != null) {
      data['designbundle'] = this.designbundle!.toJson();
    }
    if (this.fabricdesigncolor != null) {
      data['fabricdesigncolor'] = this.fabricdesigncolor!.toJson();
    }
    if (this.pati != null) {
      data['pati'] = this.pati!.toJson();
    }
    return data;
  }
}

class Designbundle {
  int? designbundleId;
  String? bundlename;
  int? bundletoop;
  int? description;
  int? fabricdesignId;
  String? status;
  int? userId;

  Designbundle(
      {this.designbundleId,
      this.bundlename,
      this.bundletoop,
      this.description,
      this.fabricdesignId,
      this.status,
      this.userId});

  Designbundle.fromJson(Map<String, dynamic> json) {
    designbundleId = json['designbundle_id'];
    bundlename = json['bundlename'];
    bundletoop = json['bundletoop'];
    description = json['description'];
    fabricdesignId = json['fabricdesign_id'];
    status = json['status'];
    userId = json['user_id'];
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
    return data;
  }
}

class Fabricdesigncolor {
  int? fabricdesigncolorId;
  String? colorname;
  int? fabricdesignId;
  int? toop;
  int? war;
  int? bundle;
  String? photo;
  int? userId;

  Fabricdesigncolor(
      {this.fabricdesigncolorId,
      this.colorname,
      this.fabricdesignId,
      this.toop,
      this.war,
      this.bundle,
      this.photo,
      this.userId});

  Fabricdesigncolor.fromJson(Map<String, dynamic> json) {
    fabricdesigncolorId = json['fabricdesigncolor_id'];
    colorname = json['colorname'];
    fabricdesignId = json['fabricdesign_id'];
    toop = json['toop'];
    war = json['war'];
    bundle = json['bundle'];
    photo = json['photo'];
    userId = json['user_id'];
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
    return data;
  }
}

class Pati {
  int? patiId;
  String? patiname;
  String? description;
  int? toop;
  String? bundlecode;

  Pati(
      {this.patiId,
      this.patiname,
      this.description,
      this.toop,
      this.bundlecode});

  Pati.fromJson(Map<String, dynamic> json) {
    patiId = json['pati_id'];
    patiname = json['patiname'];
    description = json['description'];
    toop = json['toop'];
    bundlecode = json['bundlecode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pati_id'] = this.patiId;
    data['patiname'] = this.patiname;
    data['description'] = this.description;
    data['toop'] = this.toop;
    data['bundlecode'] = this.bundlecode;
    return data;
  }
}
