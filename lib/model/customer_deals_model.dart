class CustomerDealsModel {
  List<Data>? data;

  CustomerDealsModel({this.data});

  CustomerDealsModel.fromJson(Map<String, dynamic> json) {
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
  String? type;
  String? date;
  int? begaknumber;
  dynamic afghani; // Changed type to dynamic
  dynamic doller; // Changed type to dynamic
  int? afghaniPayment;
  int? dollerPayment;
  int? balanceDoller;
  int? balanceAfghani;
  int? afghaniPurchase;
  int? dollerPurchase;

  Data({
    this.type,
    this.date,
    this.begaknumber,
    this.afghani,
    this.doller,
    this.afghaniPayment,
    this.dollerPayment,
    this.balanceDoller,
    this.balanceAfghani,
    this.afghaniPurchase,
    this.dollerPurchase,
  });

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    date = json['date'];
    begaknumber = json['begaknumber'];
    afghani = json['afghani'];
    doller = json['doller'];
    afghaniPayment = json['afghaniPayment'];
    dollerPayment = json['dollerPayment'];
    balanceDoller = json['balanceDoller'];
    balanceAfghani = json['balanceAfghani'];
    afghaniPurchase = json['afghaniPurchase'];
    dollerPurchase = json['dollerPurchase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = type;
    data['date'] = date;
    data['begaknumber'] = begaknumber;
    data['afghani'] = afghani;
    data['doller'] = doller;
    data['afghaniPayment'] = afghaniPayment;
    data['dollerPayment'] = dollerPayment;
    data['balanceDoller'] = balanceDoller;
    data['balanceAfghani'] = balanceAfghani;
    data['afghaniPurchase'] = afghaniPurchase;
    data['dollerPurchase'] = dollerPurchase;
    return data;
  }
}
