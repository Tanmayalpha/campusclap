class GetCertificateResponse {
  bool? status;
  String? message;
  List<CertificateData>? data;

  GetCertificateResponse({this.status, this.message, this.data});

  GetCertificateResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CertificateData>[];
      json['data'].forEach((v) {
        data!.add(new CertificateData.fromJson(v));
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

class CertificateData {
  int? id;
  int? userId;
  int? courseId;
  String? certificate;
  String? createdAt;
  dynamic? updatedAt;

  CertificateData(
      {this.id,
        this.userId,
        this.courseId,
        this.certificate,
        this.createdAt,
        this.updatedAt});

  CertificateData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    courseId = json['course_id'];
    certificate = json['certificate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['course_id'] = this.courseId;
    data['certificate'] = this.certificate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
