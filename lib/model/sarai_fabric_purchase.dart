class SaraiFabricPurchaseModel {
  List<Data>? data;

  SaraiFabricPurchaseModel({this.data});

  SaraiFabricPurchaseModel.fromJson(Map<String, dynamic> json) {
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
  int? fabricpurchaseId;
  String? fabricpurchasecode;
  int? bundle;

  Data({this.fabricpurchaseId, this.fabricpurchasecode, this.bundle});

  Data.fromJson(Map<String, dynamic> json) {
    fabricpurchaseId = json['fabricpurchase_id'];
    fabricpurchasecode = json['fabricpurchasecode'];
    bundle = json['bundle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fabricpurchase_id'] = this.fabricpurchaseId;
    data['fabricpurchasecode'] = this.fabricpurchasecode;
    data['bundle'] = this.bundle;
    return data;
  }
}
