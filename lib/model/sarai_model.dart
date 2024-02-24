class SaraiModel {
  List<Data>? data;

  SaraiModel({this.data});

  SaraiModel.fromJson(Map<String, dynamic> json) {
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
  int? saraiId;
  String? name;
  String? location;
  String? description;
  String? phone;
  String? type;

  Data({this.saraiId, this.name, this.location, this.description, this.phone});

  Data.fromJson(Map<String, dynamic> json) {
    saraiId = json['sarai_id'];
    name = json['name'];
    location = json['location'];
    description = json['description'];
    phone = json['phone'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sarai_id'] = this.saraiId;
    data['name'] = this.name;
    data['location'] = this.location;
    data['description'] = this.description;
    data['phone'] = this.phone;
    data['type'] = this.type;
    return data;
  }
}
