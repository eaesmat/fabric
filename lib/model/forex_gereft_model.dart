class ForexGereftModel {
  List<Data>? data;

  ForexGereftModel({this.data});

  ForexGereftModel.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? depositId;
  double? doller;
  String? date;
  String? description;
  String? byPerson;
  int? byPersonId;

  Data(
      {this.depositId,
      this.doller,
      this.date,
      this.description,
      this.byPerson,
      this.byPersonId});

  Data.fromJson(Map<String, dynamic> json) {
    depositId = json['deposit_id'];
    doller = checkDouble(json['doller']);
    date = json['date'];
    description = json['description'];
    byPerson = json['by_person'];
    byPersonId = json['by_person_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deposit_id'] = this.depositId;
    data['doller'] = this.doller;
    data['date'] = this.date;
    data['description'] = this.description;
    data['by_person'] = this.byPerson;
    data['by_person_id'] = this.byPersonId;
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
