class FabricPurchaseModel {
  List<Data>? data;

  FabricPurchaseModel({this.data});

  FabricPurchaseModel.fromJson(Map<String, dynamic> json) {
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
        json['company'] != null ? Company.fromJson(json['company']) : null;
    vendorcompany = json['vendorcompany'] != null
        ? Vendorcompany.fromJson(json['vendorcompany'])
        : null;
    fabric =
        json['fabric'] != null ? Fabric.fromJson(json['fabric']) : null;
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
    if (company != null) {
      data['company'] = company!.toJson();
    }
    if (vendorcompany != null) {
      data['vendorcompany'] = vendorcompany!.toJson();
    }
    if (fabric != null) {
      data['fabric'] = fabric!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_id'] = companyId;
    data['name'] = name;
    data['marka'] = marka;
    data['description'] = description;
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
 int? vendorcompanyId;
  String? name;
  String? phone;
  String? description;

  Vendorcompany({
    this.vendorcompanyId,
    this.name,
    this.phone,
    this.description,
    
  });

  Vendorcompany.fromJson(Map<String, dynamic> json) {
    vendorcompanyId = json['vendorcompany_id'];
    name = json['name'];
    phone = json['phone'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
   data['vendorcompany_id'] = vendorcompanyId;
    data['name'] = name;
    data['phone'] = phone;
    data['description'] = description;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fabric_id'] = fabricId;
    data['name'] = name;
    data['description'] = description;
    data['abr'] = abr;
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
