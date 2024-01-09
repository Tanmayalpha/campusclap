class GraduationTypeResponse {
  bool? status;
  String? message;
  List<GraduationData>? data;

  GraduationTypeResponse({this.status, this.message, this.data});

  GraduationTypeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GraduationData>[];
      json['data'].forEach((v) {
        data!.add(new GraduationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GraduationData {
  int? id;
  String? name;
  int? type;

  GraduationData({this.id, this.name, this.type});

  GraduationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}
