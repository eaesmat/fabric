class FabricPurchase {
  List<Data>? data;

  FabricPurchase({this.data});

  FabricPurchase.fromJson(Map<String, dynamic> json) {
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
  int? fabricpurchaseId;
  int? bundle;
  int? meter;
  int? war;
  double? yenprice;
  double? yenexchange;
  int? ttcommission;
  String? packagephoto;
  String? bankreceiptphoto;
  String? date;
  int? fabricId;
  int? companyId;
  int? vendorcompanyId;
  String? fabricpurchasecode;
  double? dollerprice;
  int? totalyenprice;
  double? totaldollerprice;
  int? userId;
  Company? company;
  Vendorcompany? vendorcompany;

  Data(
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
      this.userId,
      this.company,
      this.vendorcompany});

  Data.fromJson(Map<String, dynamic> json) {
    fabricpurchaseId = json['fabricpurchase_id'];
    bundle = json['bundle'];
    meter = json['meter'];
    war = json['war'];
    yenprice = checkDouble(json['yenprice']); // Apply checkDouble here
    yenexchange = checkDouble(json['yenexchange']); // Apply checkDouble here
    ttcommission = json['ttcommission'];
    packagephoto = json['packagephoto'];
    bankreceiptphoto = json['bankreceiptphoto'];
    date = json['date'];
    fabricId = json['fabric_id'];
    companyId = json['company_id'];
    vendorcompanyId = json['vendorcompany_id'];
    fabricpurchasecode = json['fabricpurchasecode'];
    dollerprice = checkDouble(json['dollerprice']); // Apply checkDouble here
    totalyenprice = json['totalyenprice'];
    totaldollerprice =
        checkDouble(json['totaldollerprice']); // Apply checkDouble here
    userId = json['user_id'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
    vendorcompany = json['vendorcompany'] != null
        ? new Vendorcompany.fromJson(json['vendorcompany'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fabricpurchase_id'] = this.fabricpurchaseId;
    data['bundle'] = this.bundle;
    data['meter'] = this.meter;
    data['war'] = this.war;
    data['yenprice'] = this.yenprice;
    data['yenexchange'] = this.yenexchange;
    data['ttcommission'] = this.ttcommission;
    data['packagephoto'] = this.packagephoto;
    data['bankreceiptphoto'] = this.bankreceiptphoto;
    data['date'] = this.date;
    data['fabric_id'] = this.fabricId;
    data['company_id'] = this.companyId;
    data['vendorcompany_id'] = this.vendorcompanyId;
    data['fabricpurchasecode'] = this.fabricpurchasecode;
    data['dollerprice'] = this.dollerprice;
    data['totalyenprice'] = this.totalyenprice;
    data['totaldollerprice'] = this.totaldollerprice;
    data['user_id'] = this.userId;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    if (this.vendorcompany != null) {
      data['vendorcompany'] = this.vendorcompany!.toJson();
    }
    return data;
  }
}

class Company {
  int? companyId;
  String? name;
  String? marka;
  String? description;

  Company({this.companyId, this.name, this.marka, this.description});

  Company.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    name = json['name'];
    marka = json['marka'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_id'] = this.companyId;
    data['name'] = this.name;
    data['marka'] = this.marka;
    data['description'] = this.description;
    return data;
  }
}

class Vendorcompany {
  int? fabricpurchaseId;
  int? bundle;
  int? meter;
  int? war;
  double? yenprice;
  double? yenexchange;
  int? ttcommission;
  String? packagephoto;
  String? bankreceiptphoto;
  String? date;
  int? fabricId;
  int? companyId;
  int? vendorcompanyId;
  String? fabricpurchasecode;
  double? dollerprice;
  int? totalyenprice;
  double? totaldollerprice;
  int? userId;

  Vendorcompany(
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

  Vendorcompany.fromJson(Map<String, dynamic> json) {
    fabricpurchaseId = json['fabricpurchase_id'];
    bundle = json['bundle'];
    meter = json['meter'];
    war = json['war'];
    yenprice = checkDouble(json['yenprice']); // Apply checkDouble here
    yenexchange = checkDouble(json['yenexchange']); // Apply checkDouble here
    ttcommission = json['ttcommission'];
    packagephoto = json['packagephoto'];
    bankreceiptphoto = json['bankreceiptphoto'];
    date = json['date'];
    fabricId = json['fabric_id'];
    companyId = json['company_id'];
    vendorcompanyId = json['vendorcompany_id'];
    fabricpurchasecode = json['fabricpurchasecode'];
    dollerprice = checkDouble(json['dollerprice']); // Apply checkDouble here
    totalyenprice = json['totalyenprice'];
    totaldollerprice =
        checkDouble(json['totaldollerprice']); // Apply checkDouble here
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fabricpurchase_id'] = this.fabricpurchaseId;
    data['bundle'] = this.bundle;
    data['meter'] = this.meter;
    data['war'] = this.war;
    data['yenprice'] = this.yenprice;
    data['yenexchange'] = this.yenexchange;
    data['ttcommission'] = this.ttcommission;
    data['packagephoto'] = this.packagephoto;
    data['bankreceiptphoto'] = this.bankreceiptphoto;
    data['date'] = this.date;
    data['fabric_id'] = this.fabricId;
    data['company_id'] = this.companyId;
    data['vendorcompany_id'] = this.vendorcompanyId;
    data['fabricpurchasecode'] = this.fabricpurchasecode;
    data['dollerprice'] = this.dollerprice;
    data['totalyenprice'] = this.totalyenprice;
    data['totaldollerprice'] = this.totaldollerprice;
    data['user_id'] = this.userId;
    return data;
  }
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
