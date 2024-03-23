class UserModel {
  List<Data>? data;

  UserModel({this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? username;
  String? password;
  String? name;
  String? surname;
  String? address;
  String? dob;
  String? email;
  String? privilage;
  String? status;
  String? purchase;
  String? system;
  String? transport;
  String? stock;
  String? customers;
  String? sarafi;
  String? dues;
  String? phone;
  String? sales;
  String? manager;
  String? reports;
  String? sarai;
  String? mazar;
  String? thirdfloor;
  String? firstfloor;
  String? description;
  String? userImage;

  Data(
      {this.userId,
      this.username,
      this.password,
      this.name,
      this.surname,
      this.address,
      this.dob,
      this.email,
      this.privilage,
      this.status,
      this.purchase,
      this.system,
      this.transport,
      this.stock,
      this.customers,
      this.sarafi,
      this.dues,
      this.phone,
      this.sales,
      this.manager,
      this.reports,
      this.sarai,
      this.mazar,
      this.thirdfloor,
      this.firstfloor,
      this.description,
      this.userImage});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    password = json['password'];
    name = json['name'];
    surname = json['surname'];
    address = json['address'];
    dob = json['dob'];
    email = json['email'];
    privilage = json['privilage'];
    status = json['status'];
    purchase = json['purchase'];
    system = json['system'];
    transport = json['transport'];
    stock = json['stock'];
    customers = json['customers'];
    sarafi = json['sarafi'];
    dues = json['dues'];
    phone = json['phone'];
    sales = json['sales'];
    manager = json['manager'];
    reports = json['reports'];
    sarai = json['sarai'];
    mazar = json['mazar'];
    thirdfloor = json['thirdfloor'];
    firstfloor = json['firstfloor'];
    description = json['description'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['password'] = this.password;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['address'] = this.address;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['privilage'] = this.privilage;
    data['status'] = this.status;
    data['purchase'] = this.purchase;
    data['system'] = this.system;
    data['transport'] = this.transport;
    data['stock'] = this.stock;
    data['customers'] = this.customers;
    data['sarafi'] = this.sarafi;
    data['dues'] = this.dues;
    data['phone'] = this.phone;
    data['sales'] = this.sales;
    data['manager'] = this.manager;
    data['reports'] = this.reports;
    data['sarai'] = this.sarai;
    data['mazar'] = this.mazar;
    data['thirdfloor'] = this.thirdfloor;
    data['firstfloor'] = this.firstfloor;
    data['description'] = this.description;
    data['user_image'] = this.userImage;
    return data;
  }
}
