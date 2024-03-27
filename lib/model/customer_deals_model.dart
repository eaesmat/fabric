class CustomerDealsModel {
  List<Data>? data;

  CustomerDealsModel({this.data});

  CustomerDealsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? customerId;
  double? afghani;
  double? doller;
  String? type;
  String? date;
  int? begakNumber;
  double? balanceDoller;
  double? balanceAfghani;

  Data(
      {this.customerId,
      this.afghani,
      this.doller,
      this.balanceDoller,
      this.balanceAfghani});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    afghani = checkDouble(json['afghani']);
    doller = checkDouble(json['doller']);
    type = json['type'];
    date = json['date'];
    begakNumber = json['begakNumber'];
    balanceDoller = checkDouble(json['balanceDoller']);
    balanceAfghani = checkDouble(json['balanceAfghani']);
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
