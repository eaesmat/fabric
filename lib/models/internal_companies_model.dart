class InternalCompany {
  List<Data>? data;

  InternalCompany({this.data});

  InternalCompany.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_id'] = this.companyId;
    data['name'] = this.name;
    data['marka'] = this.marka;
    data['description'] = this.description;
    if (this.fabricpurchase != null) {
      data['fabricpurchase'] =
          this.fabricpurchase!.map((v) => v.toJson()).toList();
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
    ttcommission = json['ttcommission'];
    packagephoto = json['packagephoto'];
    bankreceiptphoto = json['bankreceiptphoto'];
    date = json['date'];
    fabricId = json['fabric_id'];
    companyId = json['company_id'];
    vendorcompanyId = json['vendorcompany_id'];
    fabricpurchasecode = json['fabricpurchasecode'];
    dollerprice = checkDouble(json['dollerprice']);
    totalyenprice = json['totalyenprice'];
    totaldollerprice = checkDouble(json['totaldollerprice']);
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
