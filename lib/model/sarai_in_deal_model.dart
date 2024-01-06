class SaraiInDealModel {
  List<Data>? data;

  SaraiInDealModel({this.data});

  SaraiInDealModel.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? saraiindealId;
  String? indate;
  int? transportdealId;
  Saraifrom? saraifrom;
  int? saraiId;
  Saraifrom? sarai;
  Transportdeal? transportdeal;

  Data(
      {this.saraiindealId,
      this.indate,
      this.transportdealId,
      this.saraifrom,
      this.saraiId,
      this.sarai,
      this.transportdeal});

  Data.fromJson(Map<String, dynamic> json) {
    saraiindealId = _checkInt(json['saraiindeal_id']);
    indate = json['indate'];
    transportdealId = _checkInt(json['transportdeal_id']);
    saraifrom = json['saraifrom'] != null
        ? Saraifrom.fromJson(json['saraifrom'])
        : null;
    saraiId = _checkInt(json['sarai_id']);
    sarai = json['sarai'] != null ? Saraifrom.fromJson(json['sarai']) : null;
    transportdeal = json['transportdeal'] != null
        ? Transportdeal.fromJson(json['transportdeal'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['saraiindeal_id'] = saraiindealId;
    data['indate'] = indate;
    data['transportdeal_id'] = transportdealId;
    if (saraifrom != null) {
      data['saraifrom'] = saraifrom!.toJson();
    }
    data['sarai_id'] = saraiId;
    if (sarai != null) {
      data['sarai'] = sarai!.toJson();
    }
    if (transportdeal != null) {
      data['transportdeal'] = transportdeal!.toJson();
    }
    return data;
  }
}

class Saraifrom {
  int? saraiId;
  String? name;
  String? location;
  String? description;
  String? phone;

  Saraifrom(
      {this.saraiId, this.name, this.location, this.description, this.phone});

  Saraifrom.fromJson(Map<String, dynamic> json) {
    saraiId = _checkInt(json['sarai_id']);
    name = json['name'];
    location = json['location'];
    description = json['description'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sarai_id'] = saraiId;
    data['name'] = name;
    data['location'] = location;
    data['description'] = description;
    data['phone'] = phone;
    return data;
  }
}

class Transportdeal {
  int? transportdealId;
  String? startdate;
  String? arrivaldate;
  int? fabricpurchaseId;
  double? khatamount;
  int? costperkhat;
  int? transportId;
  String? status;
  int? duration;
  int? bundle;
  String? photo;
  double? totalcost;
  double? warcost;
  int? userId;

  Transportdeal(
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
      this.userId});

  Transportdeal.fromJson(Map<String, dynamic> json) {
    transportdealId = _checkInt(json['transportdeal_id']);
    startdate = json['startdate'];
    arrivaldate = json['arrivaldate'];
    fabricpurchaseId = _checkInt(json['fabricpurchase_id']);
    khatamount = _checkDouble(json['khatamount']);
    costperkhat = _checkInt(json['costperkhat']);
    transportId = _checkInt(json['transport_id']);
    status = json['status'];
    duration = _checkInt(json['duration']);
    bundle = _checkInt(json['bundle']);
    photo = json['photo'];
    totalcost = _checkDouble(json['totalcost']);
    warcost = _checkDouble(json['warcost']);
    userId = _checkInt(json['user_id']);
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
    return data;
  }
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
