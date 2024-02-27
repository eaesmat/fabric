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
  int? containerno;
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
  int? saraiId;
  String? name;
  String? location;
  String? description;
  String? phone;
  String? type;
  String? fabricpurchasecode;
  double? war;
  String? containerName;

  Data({
    this.transportdealId,
    this.startdate,
    this.arrivaldate,
    this.fabricpurchaseId,
    this.containerno,
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
    this.saraiId,
    this.name,
    this.location,
    this.description,
    this.phone,
    this.type,
    this.fabricpurchasecode,
    this.war,
    this.containerName,
  });

  Data.fromJson(Map<String, dynamic> json) {
    transportdealId = checkInt(json['transportdeal_id']);
    startdate = json['startdate'];
    arrivaldate = json['arrivaldate'];
    fabricpurchaseId = checkInt(json['fabricpurchase_id']);
    containerno = checkInt(json['containerno']);
    khatamount = checkDouble(json['khatamount']);
    costperkhat = checkDouble(json['costperkhat']);
    transportId = checkInt(json['transport_id']);
    status = json['status'];
    duration = checkInt(json['duration']);
    bundle = checkInt(json['bundle']);
    photo = json['photo'];
    totalcost = checkDouble(json['totalcost']);
    warcost = checkDouble(json['warcost']);
    userId = checkInt(json['user_id']);
    saraiId = checkInt(json['sarai_id']);
    name = json['name'];
    location = json['location'];
    description = json['description'];
    phone = json['phone'];
    type = json['type'];
    fabricpurchasecode = json['fabricpurchasecode'];
    war = checkDouble(json['war']);
    containerName = json['container_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transportdeal_id'] = this.transportdealId;
    data['startdate'] = this.startdate;
    data['arrivaldate'] = this.arrivaldate;
    data['fabricpurchase_id'] = this.fabricpurchaseId;
    data['containerno'] = this.containerno;
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
    data['sarai_id'] = this.saraiId;
    data['name'] = this.name;
    data['location'] = this.location;
    data['description'] = this.description;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['fabricpurchasecode'] = this.fabricpurchasecode;
    data['war'] = this.war;
    data['container_name'] = this.containerName;
    return data;
  }
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
