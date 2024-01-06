class VendorCompanyModel {
  List<Data>? data;

  VendorCompanyModel({this.data});

  VendorCompanyModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vendorcompany_id'] = vendorcompanyId;
    data['name'] = name;
    data['phone'] = phone;
    data['description'] = description;
    return data;
  }
}
