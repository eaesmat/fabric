class Customer {
  List<Data>? data;

  Customer({this.data});

  Customer.fromJson(Map<String, dynamic> json) {
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

  Data(
      {this.customerId,
      this.firstname,
      this.lastname,
      this.photo,
      this.address,
      this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    photo = json['photo'];
    address = json['address'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['photo'] = this.photo;
    data['address'] = this.address;
    data['user_id'] = this.userId;
    return data;
  }
}
