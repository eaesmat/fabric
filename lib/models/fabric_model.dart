class Fabric {
  List<Data>? data;

  Fabric({this.data});

  Fabric.fromJson(Map<String, dynamic> json) {
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
  int? fabricId;
  String? name;
  String? description;
  String? abr;
  List<Fabricpurchase>? fabricpurchase;

  Data(
      {this.fabricId,
      this.name,
      this.description,
      this.abr,
      this.fabricpurchase});

  Data.fromJson(Map<String, dynamic> json) {
    fabricId = json['fabric_id'];
    name = json['name'];
    description = json['description'];
    abr = json['abr'];
    if (json['fabricpurchase'] != null) {
      fabricpurchase = <Fabricpurchase>[];
      json['fabricpurchase'].forEach((v) {
        fabricpurchase!.add(new Fabricpurchase.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fabric_id'] = this.fabricId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['abr'] = this.abr;
    if (this.fabricpurchase != null) {
      data['fabricpurchase'] =
          this.fabricpurchase!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fabricpurchase {
  int? fabricId;
  String? name;
  String? description;
  String? abr;

  Fabricpurchase({this.fabricId, this.name, this.description, this.abr});

  Fabricpurchase.fromJson(Map<String, dynamic> json) {
    fabricId = json['fabric_id'];
    name = json['name'];
    description = json['description'];
    abr = json['abr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fabric_id'] = this.fabricId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['abr'] = this.abr;
    return data;
  }
}
