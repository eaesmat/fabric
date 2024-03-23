class ForexCalculationModel {
  List<Data>? data;

  ForexCalculationModel({this.data});

  ForexCalculationModel.fromJson(Map<String, dynamic> json) {
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
  int? sarafiId;
  String? sarafiName;
  int? balance;

  Data({this.sarafiId, this.sarafiName, this.balance});

  Data.fromJson(Map<String, dynamic> json) {
    sarafiId = json['sarafi_id'];
    sarafiName = json['sarafi_name'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sarafi_id'] = this.sarafiId;
    data['sarafi_name'] = this.sarafiName;
    data['balance'] = this.balance;
    return data;
  }
}
