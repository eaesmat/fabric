class CustomerCalculationModel {
  Data? data;

  CustomerCalculationModel({this.data});

  CustomerCalculationModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? customerId;
  String? firstname;
  String? lastname;
  double? afghaniDeal;
  double? afghaniPayment;
  double? afghaniDue;
  double? dollorDue;
  double? dollorDeal;
  double? dollorPayment;

  Data(
      {this.customerId,
      this.firstname,
      this.lastname,
      this.afghaniDeal,
      this.afghaniPayment,
      this.afghaniDue,
      this.dollorDue,
      this.dollorDeal,
      this.dollorPayment});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    afghaniDeal = checkDouble(json['afghaniDeal']);
    afghaniPayment = checkDouble(json['afghaniPayment']);
    afghaniDue = checkDouble(json['afghaniDue']);
    dollorDue = checkDouble(json['dollorDue']);
    dollorDeal = checkDouble(json['dollorDeal']);
    dollorPayment = checkDouble(json['dollorPayment']);
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
