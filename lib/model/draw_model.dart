class DrawModel {
  List<Data>? data;

  DrawModel({this.data});

  DrawModel.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? drawId;
  String? drawDate;
  double? doller;
  String? description;
  String? photo;
  int? sarafiId;
  double? yen;
  double? exchangerate;
  int? vendorcompanyId;
  int? userId;
  Vendorcompany? vendorcompany;
  Sarafi? sarafi;

  Data({
    this.drawId,
    this.drawDate,
    this.doller,
    this.description,
    this.photo,
    this.sarafiId,
    this.yen,
    this.exchangerate,
    this.vendorcompanyId,
    this.userId,
    this.vendorcompany,
    this.sarafi,
  });

  Data.fromJson(Map<String, dynamic> json) {
    drawId = json['draw_id'];
    drawDate = json['draw_date'];
    doller = checkDouble(json['doller']);
    description = json['description'];
    photo = json['photo'];
    sarafiId = json['sarafi_id'];
    yen = checkDouble(json['yen']);
    exchangerate = checkDouble(json['exchangerate']);
    vendorcompanyId = json['vendorcompany_id'];
    userId = json['user_id'];
    vendorcompany = json['vendorcompany'] != null
        ? Vendorcompany.fromJson(json['vendorcompany'])
        : null;
    sarafi = json['sarafi'] != null ? Sarafi.fromJson(json['sarafi']) : null;
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['draw_id'] = drawId;
  data['draw_date'] = drawDate;
  data['doller'] = doller;
  data['description'] = description;
  data['photo'] = photo;
  data['sarafi_id'] = sarafiId;
  data['yen'] = checkDouble(yen); // Updated check for yen field
  data['exchangerate'] = exchangerate;
  data['vendorcompany_id'] = vendorcompanyId;
  data['user_id'] = userId;
  if (vendorcompany != null) {
    data['vendorcompany'] = vendorcompany!.toJson();
  }
  if (sarafi != null) {
    data['sarafi'] = sarafi!.toJson();
  }
  return data;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['vendorcompany_id'] = vendorcompanyId;
    data['name'] = name;
    data['phone'] = phone;
    data['description'] = description;
    return data;
  }
}

class Sarafi {
  int? sarafiId;
  String? fullname;
  String? description;
  String? phone;
  String? shopno;
  String? location;

  Sarafi({
    this.sarafiId,
    this.fullname,
    this.description,
    this.phone,
    this.shopno,
    this.location,
  });

  Sarafi.fromJson(Map<String, dynamic> json) {
    sarafiId = json['sarafi_id'];
    fullname = json['fullname'];
    description = json['description'];
    phone = json['phone'];
    shopno = json['shopno'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sarafi_id'] = sarafiId;
    data['fullname'] = fullname;
    data['description'] = description;
    data['phone'] = phone;
    data['shopno'] = shopno;
    data['location'] = location;
    return data;
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
