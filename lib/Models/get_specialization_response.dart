class GetSpecializationRsponse {
  bool? status;
  List<SpecializationData>? data;

  GetSpecializationRsponse({this.status, this.data});

  GetSpecializationRsponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <SpecializationData>[];
      json['data'].forEach((v) {
        data!.add(new SpecializationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SpecializationData {
  int? id;
  String? name;
  int? type;
  int? status;
  String? createdAt;
  String? updatedAt;

  SpecializationData(
      {this.id,
        this.name,
        this.type,
        this.status,
        this.createdAt,
        this.updatedAt});

  SpecializationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
