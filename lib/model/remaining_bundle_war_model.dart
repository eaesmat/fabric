class RemainBundleAndWarModel {
  RemainBundleAndWar? remainBundleAndWar;

  RemainBundleAndWarModel({this.remainBundleAndWar});

  RemainBundleAndWarModel.fromJson(Map<String, dynamic> json) {
    remainBundleAndWar = json['remainBundleAndWar'] != null
        ? new RemainBundleAndWar.fromJson(json['remainBundleAndWar'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.remainBundleAndWar != null) {
      data['remainBundleAndWar'] = this.remainBundleAndWar!.toJson();
    }
    return data;
  }
}

class RemainBundleAndWar {
  String? bundle;
  String? war;

  RemainBundleAndWar({this.bundle, this.war});

  RemainBundleAndWar.fromJson(Map<String, dynamic> json) {
    bundle = json['bundle'];
    war = json['war'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bundle'] = this.bundle;
    data['war'] = this.war;
    return data;
  }
}
