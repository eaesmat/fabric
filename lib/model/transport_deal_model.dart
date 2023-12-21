class TransportDealModel {
  List<Data>? data;

  TransportDealModel({this.data});

  TransportDealModel.fromJson(Map<String, dynamic> json) {
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
  int? transportdealId;
  String? startdate;
  String? arrivaldate;
  int? fabricpurchaseId;
  int? containerId;
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
  List<Container>? container;

  Data(
      {this.transportdealId,
      this.startdate,
      this.arrivaldate,
      this.fabricpurchaseId,
      this.containerId,
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
      this.container});

  Data.fromJson(Map<String, dynamic> json) {
    transportdealId = json['transportdeal_id'];
    startdate = json['startdate'];
    arrivaldate = json['arrivaldate'];
    fabricpurchaseId = json['fabricpurchase_id'];
    containerId = json['container_id'];
    khatamount = json['khatamount'];
    costperkhat = json['costperkhat'];
    transportId = json['transport_id'];
    status = json['status'];
    duration = json['duration'];
    bundle = json['bundle'];
    photo = json['photo'];
    totalcost = json['totalcost'];
    warcost = json['warcost'];
    userId = json['user_id'];
    transport = json['transport'] != null
        ? new Transport.fromJson(json['transport'])
        : null;
    fabricpurchase = json['fabricpurchase'] != null
        ? new Fabricpurchase.fromJson(json['fabricpurchase'])
        : null;
    if (json['container'] != null) {
      container = <Container>[];
      json['container'].forEach((v) {
        container!.add(new Container.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transportdeal_id'] = this.transportdealId;
    data['startdate'] = this.startdate;
    data['arrivaldate'] = this.arrivaldate;
    data['fabricpurchase_id'] = this.fabricpurchaseId;
    data['container_id'] = this.containerId;
    data['khatamount'] = this.khatamount;
    data['costperkhat'] = this.costperkhat;
    data['transport_id'] = this.transportId;
    data['status'] = this.status;
    data['duration'] = this.duration;
    data['bundle'] = this.bundle;
    data['photo'] = this.photo;
    data['totalcost'] = this.totalcost;
    data['warcost'] = this.warcost;
    data['user_id'] = this.userId;
    if (this.transport != null) {
      data['transport'] = this.transport!.toJson();
    }
    if (this.fabricpurchase != null) {
      data['fabricpurchase'] = this.fabricpurchase!.toJson();
    }
    if (this.container != null) {
      data['container'] = this.container!.map((v) => v.toJson()).toList();
    }
    return data;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transport_id'] = this.transportId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['phone'] = this.phone;
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
      final parsedValue = double.tryParse(value);

      return parsedValue;
    } else {
      return null; // or any default value depending on your logic
    }
  }
}

class Container {
  int? containerId;
  String? name;
  String? description;
  String? status;
  int? transportdealId;

  Container(
      {this.containerId,
      this.name,
      this.description,
      this.status,
      this.transportdealId});

  Container.fromJson(Map<String, dynamic> json) {
    containerId = json['container_id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    transportdealId = json['transportdeal_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['container_id'] = this.containerId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['transportdeal_id'] = this.transportdealId;
    return data;
  }
}
