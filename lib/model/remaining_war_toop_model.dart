class RemainingToopAndWar {
  Data? data;

  RemainingToopAndWar({this.data});

  RemainingToopAndWar.fromJson(Map<String, dynamic> json) {
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
  int? toop;
  int? war;

  Data({this.toop, this.war});

  Data.fromJson(Map<String, dynamic> json) {
    // Parse toop
    if (json['toop'] is int) {
      toop = json['toop'];
    } else if (json['toop'] is String) {
      toop = int.tryParse(json['toop']);
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
    data['toop'] = this.toop?.toString();
    data['war'] = this.war?.toString();
    return data;
  }
}
