class VendorCompanyCalculationModel {
  List<Data>? data;

  VendorCompanyCalculationModel({this.data});

  VendorCompanyCalculationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? vendorcompanyId;
  String? vendorcompanyName;
  double? balanceDoller;
  double? balanceYen;

  Data(
      {this.vendorcompanyId,
      this.vendorcompanyName,
      this.balanceDoller,
      this.balanceYen});

  Data.fromJson(Map<String, dynamic> json) {
    vendorcompanyId = json['vendorcompany_id'];
    vendorcompanyName = json['vendorcompany_name'];
    balanceDoller = checkDouble(json['balanceDoller']);
    balanceYen = checkDouble(json['balanceYen']);
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
