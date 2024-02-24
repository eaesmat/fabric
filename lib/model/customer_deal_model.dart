class CustomerDealModel {
  List<Data>? data;

  CustomerDealModel({this.data});

  CustomerDealModel.fromJson(Map<String, dynamic> json) {
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
  int? customerdealId;
  int? customerId;
  int? bundlecount;
  int? paticount;
  int? totalwar;
  int? totalcost;
  int? begaknumber;
  String? date;
  int? userId;
  String? currency;
  int? begakpayment;
  int? begakdue;
  String? begakphoto;
  String? description;
  Customer? customer;

  Data(
      {this.customerdealId,
      this.customerId,
      this.bundlecount,
      this.paticount,
      this.totalwar,
      this.totalcost,
      this.begaknumber,
      this.date,
      this.userId,
      this.currency,
      this.begakpayment,
      this.begakdue,
      this.begakphoto,
      this.description,
      this.customer});

  Data.fromJson(Map<String, dynamic> json) {
    customerdealId = json['customerdeal_id'];
    customerId = json['customer_id'];
    bundlecount = json['bundlecount'];
    paticount = json['paticount'];
    totalwar = json['totalwar'];
    totalcost = json['totalcost'];
    begaknumber = json['begaknumber'];
    date = json['date'];
    userId = json['user_id'];
    currency = json['currency'];
    begakpayment = json['begakpayment'];
    begakdue = json['begakdue'];
    begakphoto = json['begakphoto'];
    description = json['description'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerdeal_id'] = this.customerdealId;
    data['customer_id'] = this.customerId;
    data['bundlecount'] = this.bundlecount;
    data['paticount'] = this.paticount;
    data['totalwar'] = this.totalwar;
    data['totalcost'] = this.totalcost;
    data['begaknumber'] = this.begaknumber;
    data['date'] = this.date;
    data['user_id'] = this.userId;
    data['currency'] = this.currency;
    data['begakpayment'] = this.begakpayment;
    data['begakdue'] = this.begakdue;
    data['begakphoto'] = this.begakphoto;
    data['description'] = this.description;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Customer {
  int? customerId;
  String? firstname;
  String? lastname;
  String? photo;
  String? address;
  int? userId;
  String? brunch;
  String? province;
  String? phone;

  Customer(
      {this.customerId,
      this.firstname,
      this.lastname,
      this.photo,
      this.address,
      this.userId,
      this.brunch,
      this.province,
      this.phone});

  Customer.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    photo = json['photo'];
    address = json['address'];
    userId = json['user_id'];
    brunch = json['brunch'];
    province = json['province'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['photo'] = this.photo;
    data['address'] = this.address;
    data['user_id'] = this.userId;
    data['brunch'] = this.brunch;
    data['province'] = this.province;
    data['phone'] = this.phone;
    return data;
  }
}
