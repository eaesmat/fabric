class CustomerDealsModel {
  List<GetCustomerTransaction>? getCustomerTransaction;

  CustomerDealsModel({this.getCustomerTransaction});

  CustomerDealsModel.fromJson(Map<String, dynamic> json) {
    if (json['getCustomerTransaction'] != null) {
      getCustomerTransaction = <GetCustomerTransaction>[];
      json['getCustomerTransaction'].forEach((v) {
        getCustomerTransaction!.add(GetCustomerTransaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getCustomerTransaction != null) {
      data['getCustomerTransaction'] =
          getCustomerTransaction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetCustomerTransaction {
  Row? row;
  int? balanceDoller;
  int? balanceAfghani;

  GetCustomerTransaction({this.row, this.balanceDoller, this.balanceAfghani});

  GetCustomerTransaction.fromJson(Map<String, dynamic> json) {
    row = json['row'] != null ? Row.fromJson(json['row']) : null;
    balanceDoller = json['balanceDoller'];
    balanceAfghani = json['balanceAfghani'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (row != null) {
      data['row'] = row!.toJson();
    }
    data['balanceDoller'] = balanceDoller;
    data['balanceAfghani'] = balanceAfghani;
    return data;
  }
}

class Row {
  int? id;
  String? date;
  String? begaknumber;
  int? doller;
  int? afghani;
  String? type;

  Row({this.id, this.date, this.begaknumber, this.doller, this.afghani, this.type});

  Row.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    begaknumber = json['begaknumber'];
    doller = json['doller'];
    afghani = json['afghani'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['begaknumber'] = begaknumber;
    data['doller'] = doller;
    data['afghani'] = afghani;
    data['type'] = type;
    return data;
  }
}
