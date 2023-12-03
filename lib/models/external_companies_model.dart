class ExternalCompany {
  List<Data>? data;

  ExternalCompany({this.data});

  ExternalCompany.fromJson(Map<String, dynamic> json) {
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
  int? vendorcompanyId;
  String? name;
  String? phone;
  String? description;

  Data({this.vendorcompanyId, this.name, this.phone, this.description});

  Data.fromJson(Map<String, dynamic> json) {
    vendorcompanyId = json['vendorcompany_id'];
    name = json['name'];
    phone = json['phone'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendorcompany_id'] = this.vendorcompanyId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['description'] = this.description;
    return data;
  }
}
