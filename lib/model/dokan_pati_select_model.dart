class DokanPatiSelectModel {
  List<Data>? data;

  DokanPatiSelectModel({this.data});

  DokanPatiSelectModel.fromJson(Map<String, dynamic> json) {
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
  String? bundlename;
  String? patiname;
  int? war;

  Data({this.bundlename, this.patiname, this.war});

  Data.fromJson(Map<String, dynamic> json) {
    bundlename = json['bundlename'];
    patiname = json['patiname'];
    war = json['war'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bundlename'] = this.bundlename;
    data['patiname'] = this.patiname;
    data['war'] = this.war;
    return data;
  }
}