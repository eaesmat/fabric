class SaraiFabricBundlesSelectModel {
  List<Data>? data;

  SaraiFabricBundlesSelectModel({this.data});

  SaraiFabricBundlesSelectModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? bundleName;
  int? war;
  int? saraidesignbundleId;

  Data({this.name, this.bundleName, this.war, this.saraidesignbundleId});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bundleName = json['bundle_name'];
    war = json['war'];
    saraidesignbundleId = json['saraidesignbundle_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['bundle_name'] = this.bundleName;
    data['war'] = this.war;
    data['saraidesignbundle_id'] = this.saraidesignbundleId;
    return data;
  }
}
