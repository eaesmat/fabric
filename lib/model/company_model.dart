class CompanyModel {
  List<Data>? data;

  CompanyModel({this.data});

  CompanyModel.fromJson(Map<String, dynamic> json) {
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
  int? companyId;
  String? name;
  String? marka;
  String? description;
  List<Fabricpurchase>? fabricpurchase;

  Data({
    this.companyId,
    this.name,
    this.marka,
    this.description,
    this.fabricpurchase,
  });

  Data.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    name = json['name'];
    marka = json['marka'];
    description = json['description'];
    if (json['fabricpurchase'] != null) {
      fabricpurchase = <Fabricpurchase>[];
      json['fabricpurchase'].forEach((v) {
        fabricpurchase!.add(Fabricpurchase.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_id'] = companyId;
    data['name'] = name;
    data['marka'] = marka;
    data['description'] = description;
    if (fabricpurchase != null) {
      data['fabricpurchase'] =
          fabricpurchase!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fabricpurchase {
  int? fabricpurchaseId;
  int? bundle;
  int? meter;
  int? war;
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

  Fabricpurchase({
    this.fabricpurchaseId,
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
    this.userId,
  });

  Fabricpurchase.fromJson(Map<String, dynamic> json) {
    fabricpurchaseId = json['fabricpurchase_id'];
    bundle = json['bundle'];
    meter = json['meter'];
    war = json['war'];
    yenprice = checkDouble(json['yenprice']);
    yenexchange = checkDouble(json['yenexchange']);
    ttcommission = checkDouble(json['ttcommission']);
    packagephoto = json['packagephoto'];
    bankreceiptphoto = json['bankreceiptphoto'];
    date = json['date'];
    fabricId = json['fabric_id'];
    companyId = json['company_id'];
    vendorcompanyId = json['vendorcompany_id'];
    fabricpurchasecode = json['fabricpurchasecode'];
    dollerprice = checkDouble(json['dollerprice']);
    totalyenprice = checkDouble(json['dollerprice']);
    totaldollerprice = checkDouble(json['totaldollerprice']);
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

  double checkDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.parse(value);
    } else {
      return value;
    }
  }
}
