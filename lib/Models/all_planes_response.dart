class AllPlanesResponse {
  bool? status;
  String? message;
  PlanesData? data;

  AllPlanesResponse({this.status, this.message, this.data});

  AllPlanesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? PlanesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PlanesData {
  List<Plans>? plans;

  PlanesData({this.plans});

  PlanesData.fromJson(Map<String, dynamic> json) {
    if (json['plans'] != null) {
      plans = <Plans>[];
      json['plans'].forEach((v) {
        plans!.add(Plans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (plans != null) {
      data['plans'] = plans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plans {
  int? id;
  String? amount;
  String? title;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? showToUsers;

  Plans(
      {this.id,
        this.amount,
        this.title,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.showToUsers});

  Plans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    showToUsers = json['show_to_users'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['title'] = title;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['show_to_users'] = showToUsers;
    return data;
  }
}
