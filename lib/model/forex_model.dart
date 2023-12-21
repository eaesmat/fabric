// ignore_for_file: unnecessary_new

class ForexModel {
  List<Data>? data;

  ForexModel({this.data});

  ForexModel.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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
  int? sarafiId;
  String? fullname;
  String? description;
  String? phone;
  String? shopno;
  String? location;

  Data(
      {this.sarafiId,
      this.fullname,
      this.description,
      this.phone,
      this.shopno,
      this.location});

  Data.fromJson(Map<String, dynamic> json) {
    sarafiId = json['sarafi_id'];
    fullname = json['fullname'];
    description = json['description'];
    phone = json['phone'];
    shopno = json['shopno'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sarafi_id'] = sarafiId;
    data['fullname'] = fullname;
    data['description'] = description;
    data['phone'] = phone;
    data['shopno'] = shopno;
    data['location'] = location;
    return data;
  }
}
