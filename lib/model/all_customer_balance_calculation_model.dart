class AllCustomerBalanceCalculationModel {
  Data? data;

  AllCustomerBalanceCalculationModel({this.data});

  AllCustomerBalanceCalculationModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  double? allTotalCostAfghani;
  double? allTotalCostDoller;
  double? allPaymentAfghani;
  double? allPaymentDoller;
  double? allDueAfghani;
  double? allDueDoller;

  Data(
      {this.allTotalCostAfghani,
      this.allTotalCostDoller,
      this.allPaymentAfghani,
      this.allPaymentDoller,
      this.allDueAfghani,
      this.allDueDoller});

  Data.fromJson(Map<String, dynamic> json) {
    allTotalCostAfghani = checkDouble(json['allTotalCostAfghani']);
    allTotalCostDoller = checkDouble(json['allTotalCostDoller']);
    allPaymentAfghani = checkDouble(json['allPaymentAfghani']);
    allPaymentDoller = checkDouble(json['allPaymentDoller']);
    allDueAfghani = checkDouble(json['allDueAfghani']);
    allDueDoller = checkDouble(json['allDueDoller']);
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
