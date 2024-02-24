class DokanPatiModel {
  List<Data>? data;

  DokanPatiModel({this.data});

  DokanPatiModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? indate;
  int? totalbundle;
  int? totalpati;
  int? fabricId;
  String? saraiId;
  int? outpati;
  int? inpati;

  Data(
      {this.name,
      this.indate,
      this.totalbundle,
      this.totalpati,
      this.fabricId,
      this.saraiId,
      this.outpati,
      this.inpati});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    indate = json['indate'];
    totalbundle = json['totalbundle'];
    totalpati = json['totalpati'];
    fabricId = json['fabric_id'];
    saraiId = json['sarai_id'];
    outpati = json['outpati'];
    inpati = json['inpati'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['indate'] = this.indate;
    data['totalbundle'] = this.totalbundle;
    data['totalpati'] = this.totalpati;
    data['fabric_id'] = this.fabricId;
    data['sarai_id'] = this.saraiId;
    data['outpati'] = this.outpati;
    data['inpati'] = this.inpati;
    return data;
  }
}
