class ContainerModel {
  List<Data>? data;

  ContainerModel({this.data});

  ContainerModel.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? containerId;
  String? name;
  String? description;
  String? status;
  int? transportdealId;
  Transportdeal? transportdeal;

  Data(
      {this.containerId,
      this.name,
      this.description,
      this.status,
      this.transportdealId,
      this.transportdeal});

  Data.fromJson(Map<String, dynamic> json) {
    containerId = json['container_id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    transportdealId = json['transportdeal_id'];
    transportdeal = json['transportdeal'] != null
        ? new Transportdeal.fromJson(json['transportdeal'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['container_id'] = this.containerId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['transportdeal_id'] = this.transportdealId;
    if (this.transportdeal != null) {
      data['transportdeal'] = this.transportdeal!.toJson();
    }
    return data;
  }
}

class Transportdeal {
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

  Transportdeal(
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
      this.userId});

  Transportdeal.fromJson(Map<String, dynamic> json) {
     transportdealId = checkInt(json['transportdeal_id']);
    startdate = json['startdate'];
    arrivaldate = json['arrivaldate'];
    fabricpurchaseId = checkInt(json['fabricpurchase_id']);
    containerId = checkInt(json['container_id']);
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transportdeal_id'] = this.transportdealId;
    data['startdate'] = this.startdate;
    data['arrivaldate'] = this.arrivaldate;
    data['fabricpurchase_id'] = this.fabricpurchaseId;
    data['container_id'] = this.containerId;

    // Applying checkDouble to properties expected to be doubles
    data['khatamount'] = checkDouble(this.khatamount);
    data['costperkhat'] = checkDouble(this.costperkhat);
    data['transport_id'] = this.transportId;
    data['status'] = this.status;
    data['duration'] = this.duration;
    data['bundle'] = this.bundle;
    data['photo'] = this.photo;
    data['totalcost'] = checkDouble(this.totalcost);
    data['warcost'] = checkDouble(this.warcost);
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
