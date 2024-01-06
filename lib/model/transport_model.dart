class TransportModel {
  List<Data>? data;

  TransportModel({this.data});

  TransportModel.fromJson(Map<String, dynamic> json) {
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
  int? transportId;
  String? name;
  String? description;
  String? phone;

  Data({this.transportId, this.name, this.description, this.phone});

  Data.fromJson(Map<String, dynamic> json) {
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
