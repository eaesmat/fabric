class TransportDealModel {
  List<Data>? data;

  TransportDealModel({this.data});

  TransportDealModel.fromJson(Map<String, dynamic> json) {
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
  int? transportdealId;
  String? startdate;
  String? arrivaldate;
  int? fabricpurchaseId;
  double? khatamount;
  double? costperkhat;
  int? transportId;
  String? status;
  int? duration;
  int? bundle;
  String? photo;
  double? totalcost;
  double? warcost;
  int? userId;
  Transport? transport;
  Fabricpurchase? fabricpurchase;
  List<ContainerModel>? container;
  List<Saraiindeal>? saraiindeal;

  Data(
      {this.transportdealId,
      this.startdate,
      this.arrivaldate,
      this.fabricpurchaseId,
      this.khatamount,
      this.costperkhat,
      this.transportId,
      this.status,
      this.duration,
      this.bundle,
      this.photo,
      this.totalcost,
      this.warcost,
      this.userId,
      this.transport,
      this.fabricpurchase,
      this.container,
      this.saraiindeal});

  Data.fromJson(Map<String, dynamic> json) {
    transportdealId = _checkInt(json['transportdeal_id']);
    startdate = json['startdate'];
    arrivaldate = json['arrivaldate'];
    fabricpurchaseId = _checkInt(json['fabricpurchase_id']);
    khatamount = _checkDouble(json['khatamount']);
    costperkhat = _checkDouble(json['costperkhat']);
    transportId = _checkInt(json['transport_id']);
    status = json['status'];
    duration = _checkInt(json['duration']);
    bundle = _checkInt(json['bundle']);
    photo = json['photo'];
    totalcost = _checkDouble(json['totalcost']);
    warcost = _checkDouble(json['warcost']);
    userId = _checkInt(json['user_id']);
    transport = json['transport'] != null
        ? Transport.fromJson(json['transport'])
        : null;
    fabricpurchase = json['fabricpurchase'] != null
        ? Fabricpurchase.fromJson(json['fabricpurchase'])
        : null;
    if (json['container'] != null) {
      container = <ContainerModel>[];
      json['container'].forEach((v) {
        container!.add(ContainerModel.fromJson(v));
      });
    }
    if (json['saraiindeal'] != null) {
      saraiindeal = <Saraiindeal>[];
      json['saraiindeal'].forEach(
        (v) {
          saraiindeal!.add(Saraiindeal.fromJson(v));
        },
      );
    }
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transportdeal_id'] = transportdealId;
    data['startdate'] = startdate;
    data['arrivaldate'] = arrivaldate;
    data['fabricpurchase_id'] = fabricpurchaseId;
    data['khatamount'] = khatamount;
    data['costperkhat'] = costperkhat;
    data['transport_id'] = transportId;
    data['status'] = status;
    data['duration'] = duration;
    data['bundle'] = bundle;
    data['photo'] = photo;
    data['totalcost'] = totalcost;
    data['warcost'] = warcost;
    data['user_id'] = userId;
    if (transport != null) {
      data['transport'] = transport!.toJson();
    }
    if (fabricpurchase != null) {
      data['fabricpurchase'] = fabricpurchase!.toJson();
    }
    if (container != null) {
      data['container'] = container!.map((v) => v.toJson()).toList();
    }
    if (saraiindeal != null) {
      data['saraiindeal'] = saraiindeal!.map((v) => v.toJson()).toList();
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

  double? _checkDouble(dynamic value) {
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

class Transport {
  int? transportId;
  String? name;
  String? description;
  String? phone;

  Transport({this.transportId, this.name, this.description, this.phone});

  Transport.fromJson(Map<String, dynamic> json) {
    transportId = json['transport_id'];
    name = json['name'];
    description = json['description'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transport_id'] = transportId;
    data['name'] = name;
    data['description'] = description;
    data['phone'] = phone;
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
    fabricpurchaseId = _checkInt(json['fabricpurchase_id']);
    bundle = _checkInt(json['bundle']);
    meter = _checkDouble(json['meter']);
    war = _checkDouble(json['war']);
    yenprice = _checkDouble(json['yenprice']);
    yenexchange = _checkDouble(json['yenexchange']);
    ttcommission = _checkDouble(json['ttcommission']);
    packagephoto = json['packagephoto'];
    bankreceiptphoto = json['bankreceiptphoto'];
    date = json['date'];
    fabricId = _checkInt(json['fabric_id']);
    companyId = _checkInt(json['company_id']);
    vendorcompanyId = _checkInt(json['vendorcompany_id']);
    fabricpurchasecode = json['fabricpurchasecode'];
    dollerprice = _checkDouble(json['dollerprice']);
    totalyenprice = _checkDouble(json['totalyenprice']);
    totaldollerprice = _checkDouble(json['totaldollerprice']);
    userId = _checkInt(json['user_id']);
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

  double? _checkDouble(dynamic value) {
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

class ContainerModel {
  int? containerId;
  String? name;
  String? description;
  String? status;
  int? transportdealId;

  ContainerModel(
      {this.containerId,
      this.name,
      this.description,
      this.status,
      this.transportdealId});

  ContainerModel.fromJson(Map<String, dynamic> json) {
    containerId = json['container_id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    transportdealId = json['transportdeal_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['container_id'] = containerId;
    data['name'] = name;
    data['description'] = description;
    data['status'] = status;
    data['transportdeal_id'] = transportdealId;
    return data;
  }
}

class Saraiindeal {
  int? saraiindealId;
  String? indate;
  int? transportdealId;
  int? saraifrom;
  int? saraiId;

  Saraiindeal(
      {this.saraiindealId,
      this.indate,
      this.transportdealId,
      this.saraifrom,
      this.saraiId});

  Saraiindeal.fromJson(Map<String, dynamic> json) {
    saraiindealId = json['saraiindeal_id'];
    indate = json['indate'];
    transportdealId = json['transportdeal_id'];
    saraifrom = json['saraifrom'];
    saraiId = json['sarai_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['saraiindeal_id'] = saraiindealId;
    data['indate'] = indate;
    data['transportdeal_id'] = transportdealId;
    data['saraifrom'] = saraifrom;
    data['sarai_id'] = saraiId;
    return data;
  }
}
