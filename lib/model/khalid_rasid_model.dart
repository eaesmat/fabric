class KhalidRasidModel {
  List<Data>? data;

  KhalidRasidModel({this.data});

  KhalidRasidModel.fromJson(Map<String, dynamic> json) {
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
  int? drawId;
  String? drawDate;
  double? yen;
  double? doller; // Change type to dynamic
  double? exchangerate;
  String? photo;
  String? vendorcompanyName;
  int? vendorcompanyId;
  String? sarafiName;
  int? sarafiId;

  Data({
    this.drawId,
    this.drawDate,
    this.yen,
    this.doller, // Update type
    this.exchangerate,
    this.photo,
    this.vendorcompanyName,
    this.vendorcompanyId,
    this.sarafiName,
    this.sarafiId,
  });

  Data.fromJson(Map<String, dynamic> json) {
    drawId = json['draw_id'];
    drawDate = json['draw_date'];
    yen = _checkDouble(json['yen']);
    doller = _checkDouble(json['doller']); // Update type
    exchangerate = _checkDouble(json['exchangerate']);
    photo = json['photo'];
    vendorcompanyName = json['vendorcompany_name'];
    vendorcompanyId = json['vendorcompany_id'];
    sarafiName = json['saraf_name'];
    sarafiId = json['saraf_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['draw_id'] = this.drawId;
    data['draw_date'] = this.drawDate;
    data['yen'] = this.yen;
    data['doller'] = this.doller; // Update property name
    data['exchangerate'] = this.exchangerate;
    data['photo'] = this.photo;
    data['vendorcompany_name'] = this.vendorcompanyName;
    data['vendorcompany_id'] = this.vendorcompanyId;
    data['saraf_name'] = this.sarafiName;
    data['saraf_id'] = this.sarafiId;
    return data;
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
