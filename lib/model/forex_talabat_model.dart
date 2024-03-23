class ForexTalabatModel {
  List<Data>? data;

  ForexTalabatModel({this.data});

  ForexTalabatModel.fromJson(Map<String, dynamic> json) {
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
  int? drawId;
  String? drawDate;
  int? yen;
  int? exchangerate;
  int? doller;
  String? vendorcompanyName;
  String? name;

  Data(
      {this.drawId,
      this.drawDate,
      this.yen,
      this.exchangerate,
      this.doller,
      this.vendorcompanyName,
      this.name});

  Data.fromJson(Map<String, dynamic> json) {
    drawId = json['draw_id'];
    drawDate = json['draw_date'];
    yen = json['yen'];
    exchangerate = json['exchangerate'];
    doller = json['doller'];
    vendorcompanyName = json['vendorcompany_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['draw_id'] = this.drawId;
    data['draw_date'] = this.drawDate;
    data['yen'] = this.yen;
    data['exchangerate'] = this.exchangerate;
    data['doller'] = this.doller;
    data['vendorcompany_name'] = this.vendorcompanyName;
    data['name'] = this.name;
    return data;
  }
}
