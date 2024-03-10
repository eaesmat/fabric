class KhalidGereftModel {
  List<Data>? data;

  KhalidGereftModel({this.data});

  KhalidGereftModel.fromJson(Map<String, dynamic> json) {
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
  int? sarafiId;
  double? doller;
  int? vendorcompanyId;
  String? description;
  String? sarafName;
  String? dokan;

  Data(
      {this.drawId,
      this.drawDate,
      this.sarafiId,
      this.doller,
      this.vendorcompanyId,
      this.description,
      this.sarafName});

  Data.fromJson(Map<String, dynamic> json) {
    drawId = json['draw_id'];
    drawDate = json['draw_date'];
    sarafiId = json['sarafi_id'];
    doller = checkDouble(json['doller']);
    vendorcompanyId = json['vendorcompany_id'];
    description = json['description'];
    sarafName = json['saraf_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['draw_id'] = this.drawId;
    data['draw_date'] = this.drawDate;
    data['sarafi_id'] = this.sarafiId;
    data['doller'] = this.doller;
    data['vendorcompany_id'] = this.vendorcompanyId;
    data['description'] = this.description;
    data['saraf_name'] = this.sarafName;
    return data;
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
