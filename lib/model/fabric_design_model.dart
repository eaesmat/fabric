class FabricDesignModel {
  List<Data>? data;

  FabricDesignModel({this.data});

  FabricDesignModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  int? fabricpurchaseId;
  String? designimage;
  String? designname;
  int? userId;
  Fabricpurchase? fabricpurchase;
  List<Fabricdesigncolor>? fabricdesigncolor;

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
      this.fabricpurchase,
      this.fabricdesigncolor});

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
    fabricpurchase = json['fabricpurchase'] != null
        ? Fabricpurchase.fromJson(json['fabricpurchase'])
        : null;
    if (json['fabricdesigncolor'] != null) {
      fabricdesigncolor = <Fabricdesigncolor>[];
      json['fabricdesigncolor'].forEach((v) {
        fabricdesigncolor!.add(Fabricdesigncolor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fabricdesign_id'] = fabricdesignId;
    data['name'] = name;
    data['bundle'] = bundle;
    data['war'] = war;
    data['toop'] = toop;
    data['fabricpurchase_id'] = fabricpurchaseId;
    data['designimage'] = designimage;
    data['designname'] = designname;
    data['user_id'] = userId;
    if (fabricpurchase != null) {
      data['fabricpurchase'] = fabricpurchase!.toJson();
    }
    if (fabricdesigncolor != null) {
      data['fabricdesigncolor'] =
          fabricdesigncolor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fabricpurchase {
  int? fabricpurchaseId;
  int? bundle;
  double? meter;
  double? war;
  double? yenprice;
  double? yenexchange;
  double? ttcommission;
  String? packagephoto;
  String? bankreceiptphoto;
  String? date;
  int? fabricId;
  int? companyId;
  int? vendorcompanyId;
  String? fabricpurchasecode;
  double? dollerprice;
  double? totalyenprice;
  double? totaldollerprice;
  int? userId;

  Fabricpurchase(
      {this.fabricpurchaseId,
      this.bundle,
      this.meter,
      this.war,
      this.yenprice,
      this.yenexchange,
      this.ttcommission,
      this.packagephoto,
      this.bankreceiptphoto,
      this.date,
      this.fabricId,
      this.companyId,
      this.vendorcompanyId,
      this.fabricpurchasecode,
      this.dollerprice,
      this.totalyenprice,
      this.totaldollerprice,
      this.userId});

  Fabricpurchase.fromJson(Map<String, dynamic> json) {
    fabricpurchaseId = checkInt(json['fabricpurchase_id']);
    bundle = checkInt(json['bundle']);
    meter = checkDouble(json['meter']);
    war = checkDouble(json['war']);
    yenprice = checkDouble(json['yenprice']);

    yenexchange = checkDouble(json['yenexchange']);
    ttcommission = checkDouble(json['ttcommission']);
    packagephoto = json['packagephoto'];
    bankreceiptphoto = json['bankreceiptphoto'];
    date = json['date'];
    fabricId = checkInt(json['fabric_id']);
    companyId = checkInt(json['company_id']);
    vendorcompanyId = checkInt(json['vendorcompany_id']);
    fabricpurchasecode = json['fabricpurchasecode'];
    dollerprice = checkDouble(json['dollerprice']);
    totalyenprice = checkDouble(json['totalyenprice']);
    totaldollerprice = checkDouble(json['totaldollerprice']);
    userId = checkInt(json['user_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fabricpurchase_id'] = fabricpurchaseId;
    data['bundle'] = bundle;
    data['meter'] = meter;
    data['war'] = war;
    data['yenprice'] = yenprice;
    data['yenexchange'] = yenexchange;
    data['ttcommission'] = ttcommission;
    data['packagephoto'] = packagephoto;
    data['bankreceiptphoto'] = bankreceiptphoto;
    data['date'] = date;
    data['fabric_id'] = fabricId;
    data['company_id'] = companyId;
    data['vendorcompany_id'] = vendorcompanyId;
    data['fabricpurchasecode'] = fabricpurchasecode;
    data['dollerprice'] = dollerprice;
    data['totalyenprice'] = totalyenprice;
    data['totaldollerprice'] = totaldollerprice;
    data['user_id'] = userId;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fabricdesigncolor_id'] = fabricdesigncolorId;
    data['colorname'] = colorname;
    data['fabricdesign_id'] = fabricdesignId;
    data['toop'] = toop;
    data['war'] = war;
    data['bundle'] = bundle;
    data['photo'] = photo;
    data['user_id'] = userId;
    return data;
  }
}

int? checkInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value);
    } else {
      return null; // or any default value depending on your logic
    }
  }

  double? checkDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value; // Return as is if it's already a double
    } else if (value is String) {
      final parsedValue = double.tryParse(value);

      return parsedValue;
    } else {
      return null; // or any default value depending on your logic
    }
  }

