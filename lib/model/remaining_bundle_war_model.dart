class RemainingBundleAndWar {
  Data? data;

  RemainingBundleAndWar({this.data});

  RemainingBundleAndWar.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? bundle;
  int? war;

  Data({this.bundle, this.war});

  Data.fromJson(Map<String, dynamic> json) {
    // Parse bundle
    if (json['bundle'] is int) {
      bundle = json['bundle'];
    } else if (json['bundle'] is String) {
      bundle = int.tryParse(json['bundle']);
    }

    // Parse war
    if (json['war'] is int) {
      war = json['war'];
    } else if (json['war'] is String) {
      war = int.tryParse(json['war']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bundle'] = this.bundle?.toString();
    data['war'] = this.war?.toString();
    return data;
  }
}
