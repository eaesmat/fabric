class RemainingBundleAndToop {
  Data? data;

  RemainingBundleAndToop({this.data});

  RemainingBundleAndToop.fromJson(Map<String, dynamic> json) {
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
  int? toop;

  Data({this.bundle, this.toop});

  Data.fromJson(Map<String, dynamic> json) {
    // Parse bundle
    if (json['bundle'] is int) {
      bundle = json['bundle'];
    } else if (json['bundle'] is String) {
      bundle = int.tryParse(json['bundle']);
    }

    // Parse toop
    if (json['toop'] is int) {
      toop = json['toop'];
    } else if (json['toop'] is String) {
      toop = int.tryParse(json['toop']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bundle'] = this.bundle?.toString();
    data['toop'] = this.toop?.toString();
    return data;
  }
}
