class KhalidCalculationModel {
  double? totalDollerPirce;
  double? submitDoller;
  double? balance;
  double? kldhmd;

  KhalidCalculationModel(
      {this.totalDollerPirce, this.submitDoller, this.balance, this.kldhmd});

  KhalidCalculationModel.fromJson(Map<String, dynamic> json) {
    totalDollerPirce = checkDouble(json['totalDollerPirce']);
    submitDoller = checkDouble(json['submitDoller']);
    balance = checkDouble(json['balance']);
    kldhmd = checkDouble(json['kldhmd']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalDollerPirce'] = this.totalDollerPirce;
    data['submitDoller'] = this.submitDoller;
    data['balance'] = this.balance;
    data['kldhmd'] = this.kldhmd;
    return data;
  }

  double? checkDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value; // Return as is if it's already a double
    } else if (value is String) {
      return double.tryParse(value);
    } else {
      return null; // or any default value depending on your logic
    }
  }
}
