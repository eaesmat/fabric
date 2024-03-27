class CustomerSalesModel {
  List<Data>? data;

  CustomerSalesModel({this.data});

  CustomerSalesModel.fromJson(Map<String, dynamic> json) {
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
  double? afghani;
  double? dollor;
  String? date;
  int? begakNumber;
  int? war;

  Data(
      {this.customerId,
      this.afghani,
      this.dollor,
      this.date,
      this.begakNumber,
      this.war});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    afghani = checkDouble(json['afghani']);
    dollor = checkDouble(json['dollor']);
    date = json['date'];
    begakNumber = json['begakNumber'];
    war = json['war'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['afghani'] = this.afghani;
    data['dollor'] = this.dollor;
    data['date'] = this.date;
    data['begakNumber'] = this.begakNumber;
    data['war'] = this.war;
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
