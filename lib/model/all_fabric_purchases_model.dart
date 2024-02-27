class TransportDealsModel {
  List<Data>? data;

  TransportDealsModel({this.data});

  TransportDealsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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
  String? status;
  String? vendorcompany;
  String? marka;
  String? fabricName;

  Data({
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
    this.status,
    this.vendorcompany,
    this.marka,
    this.fabricName,
  });

  Data.fromJson(Map<String, dynamic> json) {
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
    status = json['status'];
    vendorcompany = json['vendorcompany'];
    marka = json['marka'];
    fabricName = json['fabric_name'];
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
    data['status'] = status;
    data['vendorcompany'] = vendorcompany;
    data['marka'] = marka;
    data['fabric_name'] = fabricName;
    return data;
  }
  
  int? checkInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value);
    } else {
      return null;
    }
  }

  double? checkDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value);
    } else {
      return null;
    }
  }
}
