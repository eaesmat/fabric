class CustomerModel {
  List<Data>? data;

  CustomerModel({this.data});

  CustomerModel.fromJson(Map<String, dynamic> json) {
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
  int? customerId;
  String? firstname;
  String? lastname;
  String? photo;
  String? address;
  int? userId;
  String? brunch;
  String? province;
  String? phone;
  List<Customerdeal>? customerdeal;
  List<Customerpayment>? customerpayment;

  Data(
      {this.customerId,
      this.firstname,
      this.lastname,
      this.photo,
      this.address,
      this.userId,
      this.brunch,
      this.province,
      this.phone,
      this.customerdeal,
      this.customerpayment});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    photo = json['photo'];
    address = json['address'];
    userId = json['user_id'];
    brunch = json['brunch'];
    province = json['province'];
    phone = json['phone'];
    if (json['customerdeal'] != null) {
      customerdeal = <Customerdeal>[];
      json['customerdeal'].forEach((v) {
        customerdeal!.add(new Customerdeal.fromJson(v));
      });
    }
    if (json['customerpayment'] != null) {
      customerpayment = <Customerpayment>[];
      json['customerpayment'].forEach((v) {
        customerpayment!.add(new Customerpayment.fromJson(v));
      });
    }
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
    if (this.customerdeal != null) {
      data['customerdeal'] = this.customerdeal!.map((v) => v.toJson()).toList();
    }
    if (this.customerpayment != null) {
      data['customerpayment'] =
          this.customerpayment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customerdeal {
  int? customerdealId;
  int? customerId;
  int? bundlecount;
  int? paticount;
  int? totalwar;
  int? totalcostdollar;
  int? begaknumber;
  String? date;
  int? userId;
  int? totalcostafghani;

  Customerdeal(
      {this.customerdealId,
      this.customerId,
      this.bundlecount,
      this.paticount,
      this.totalwar,
      this.totalcostdollar,
      this.begaknumber,
      this.date,
      this.userId,
      this.totalcostafghani});

  Customerdeal.fromJson(Map<String, dynamic> json) {
    customerdealId = json['customerdeal_id'];
    customerId = json['customer_id'];
    bundlecount = json['bundlecount'];
    paticount = json['paticount'];
    totalwar = json['totalwar'];
    totalcostdollar = json['totalcostdollar'];
    begaknumber = json['begaknumber'];
    date = json['date'];
    userId = json['user_id'];
    totalcostafghani = json['totalcostafghani'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerdeal_id'] = this.customerdealId;
    data['customer_id'] = this.customerId;
    data['bundlecount'] = this.bundlecount;
    data['paticount'] = this.paticount;
    data['totalwar'] = this.totalwar;
    data['totalcostdollar'] = this.totalcostdollar;
    data['begaknumber'] = this.begaknumber;
    data['date'] = this.date;
    data['user_id'] = this.userId;
    data['totalcostafghani'] = this.totalcostafghani;
    return data;
  }
}

class Customerpayment {
  int? customerpaymentId;
  String? date;
  String? person;
  String? description;
  int? amountdollar;
  int? customerId;
  int? userId;
  int? amountafghani;

  Customerpayment(
      {this.customerpaymentId,
      this.date,
      this.person,
      this.description,
      this.amountdollar,
      this.customerId,
      this.userId,
      this.amountafghani});

  Customerpayment.fromJson(Map<String, dynamic> json) {
    customerpaymentId = json['customerpayment_id'];
    date = json['date'];
    person = json['person'];
    description = json['description'];
    amountdollar = json['amountdollar'];
    customerId = json['customer_id'];
    userId = json['user_id'];
    amountafghani = json['amountafghani'];
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
    return data;
  }
}
