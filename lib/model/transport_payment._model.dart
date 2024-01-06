class TransportPaymentModel {
  List<Data>? data;

  TransportPaymentModel({this.data});

  TransportPaymentModel.fromJson(Map<String, dynamic> json) {
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
  int? transportpaymentId;
  String? date1;
  String? date2;
  String? person;
  int? amount;
  int? transportId;
  int? userId;
  Transport? transport;

  Data(
      {this.transportpaymentId,
      this.date1,
      this.date2,
      this.person,
      this.amount,
      this.transportId,
      this.userId,
      this.transport});

  Data.fromJson(Map<String, dynamic> json) {
    transportpaymentId = json['transportpayment_id'];
    date1 = json['date1'];
    date2 = json['date2'];
    person = json['person'];
    amount = json['amount'];
    transportId = json['transport_id'];
    userId = json['user_id'];
    transport = json['transport'] != null
        ? new Transport.fromJson(json['transport'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transportpayment_id'] = this.transportpaymentId;
    data['date1'] = this.date1;
    data['date2'] = this.date2;
    data['person'] = this.person;
    data['amount'] = this.amount;
    data['transport_id'] = this.transportId;
    data['user_id'] = this.userId;
    if (this.transport != null) {
      data['transport'] = this.transport!.toJson();
    }
    return data;
  }
}

class Transport {
  int? transportId;
  String? name;
  String? description;
  String? phone;

  Transport({this.transportId, this.name, this.description, this.phone});

  Transport.fromJson(Map<String, dynamic> json) {
    transportId = json['transport_id'];
    name = json['name'];
    description = json['description'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transport_id'] = this.transportId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['phone'] = this.phone;
    return data;
  }
}
