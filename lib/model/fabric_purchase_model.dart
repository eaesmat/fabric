class FabricPurchaseModel {
  List<Data>? data;

  FabricPurchaseModel({this.data});

  FabricPurchaseModel.fromJson(Map<String, dynamic> json) {
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
  Company? company;
  Vendorcompany? vendorcompany;
  Fabric? fabric;

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
    this.company,
    this.vendorcompany,
    this.fabric,
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
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
    vendorcompany = json['vendorcompany'] != null
        ? new Vendorcompany.fromJson(json['vendorcompany'])
        : null;
    fabric =
        json['fabric'] != null ? new Fabric.fromJson(json['fabric']) : null;
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
    if (this.fabric != null) {
      data['fabric'] = this.fabric!.toJson();
    }
    return data;
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
}

class Company {
  int? companyId;
  String? name;
  String? marka;
  String? description;

  Company({this.companyId, this.name, this.marka, this.description});

  Company.fromJson(Map<String, dynamic> json) {
    companyId = checkInt(json['company_id']);
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

  int? checkInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value);
    } else {
      return null; // or any default value depending on your logic
    }
  }
}

class Vendorcompany {
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

  Vendorcompany({
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

  Vendorcompany.fromJson(Map<String, dynamic> json) {
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
      return double.tryParse(value);
    } else {
      return null; // or any default value depending on your logic
    }
  }
}

class Fabric {
  int? fabricId;
  String? name;
  String? description;
  String? abr;

  Fabric({this.fabricId, this.name, this.description, this.abr});

  Fabric.fromJson(Map<String, dynamic> json) {
    fabricId = checkInt(json['fabric_id']);
    name = json['name'];
    description = json['description'];
    abr = json['abr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fabric_id'] = this.fabricId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['abr'] = this.abr;
    return data;
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
}
