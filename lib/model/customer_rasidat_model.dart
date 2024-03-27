class CustomerRasidatModel {
  List<Data>? data;

  CustomerRasidatModel({this.data});

  CustomerRasidatModel.fromJson(Map<String, dynamic> json) {
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
  double? dollor;
  double? afghani;
  String? person;
  String? date;
  String? description;
  int? rasidId;

  Data(
      {this.customerId,
      this.dollor,
      this.afghani,
      this.person,
      this.date,
      this.description});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    dollor = checkDouble(json['dollor']);
    afghani = checkDouble(json['afghani']);
    person = json['person'];
    date = json['date'];
    description = json['description'];
    rasidId = json['rasid_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['dollor'] = this.dollor;
    data['afghani'] = this.afghani;
    data['person'] = this.person;
    data['date'] = this.date;
    data['description'] = this.description;
    data['rasid_id'] = this.rasidId;
    return data;
  }

  double? checkDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value; // Return as is if it's already a double
    } else if (value is String) {
      final parsedValue = double.tryParse(value);

      return parsedValue;
    } else {
      return null; // or any default value depending on your logic
    }
  }
}
