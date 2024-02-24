class SaraiMarkaModel {
  List<Data>? data;

  SaraiMarkaModel({this.data});

  SaraiMarkaModel.fromJson(Map<String, dynamic> json) {
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
  int? companyId;
  String? name;
  String? marka;
  String? description;

  Data({this.companyId, this.name, this.marka, this.description});

  Data.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    name = json['name'];
    marka = json['marka'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_id'] = this.companyId;
    data['name'] = this.name;
    data['marka'] = this.marka;
    data['description'] = this.description;
    return data;
  }
}
