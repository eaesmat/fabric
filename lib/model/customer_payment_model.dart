class CustomerPaymentModel {
  List<Data>? data;

  CustomerPaymentModel({this.data});

  CustomerPaymentModel.fromJson(Map<String, dynamic> json) {
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
  int? customerpaymentId;
  String? date;
  String? person;
  String? description;
  int? amountdollar;
  int? customerId;
  int? userId;
  int? amountafghani;
  Customer? customer;

  Data(
      {this.customerpaymentId,
      this.date,
      this.person,
      this.description,
      this.amountdollar,
      this.customerId,
      this.userId,
      this.amountafghani,
      this.customer});

  Data.fromJson(Map<String, dynamic> json) {
    customerpaymentId = json['customerpayment_id'];
    date = json['date'];
    person = json['person'];
    description = json['description'];
    amountdollar = json['amountdollar'];
    customerId = json['customer_id'];
    userId = json['user_id'];
    amountafghani = json['amountafghani'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerpayment_id'] = this.customerpaymentId;
    data['date'] = this.date;
    data['person'] = this.person;
    data['description'] = this.description;
    data['amountdollar'] = this.amountdollar;
    data['customer_id'] = this.customerId;
    data['user_id'] = this.userId;
    data['amountafghani'] = this.amountafghani;
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
