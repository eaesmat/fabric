class CustomerBalanceModel {
  List<Data>? data;

  CustomerBalanceModel({this.data});

  CustomerBalanceModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? customerId;
  String? firstname;
  String? lastname;
  double? dueDoller;
  double? dueAfghani;

  Data(
      {this.customerId,
      this.firstname,
      this.lastname,
      this.dueDoller,
      this.dueAfghani});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    dueDoller = checkDouble(json['dueDoller']);
    dueAfghani = checkDouble(json['dueAfghani']);
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
