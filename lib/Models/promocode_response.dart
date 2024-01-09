class PromocodeApplyResponse {
  bool? status;
  PromoCodeData? data;
  String? msg;

  PromocodeApplyResponse({this.status, this.data, this.msg});

  PromocodeApplyResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? PromoCodeData.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = msg;
    return data;
  }
}

class PromoCodeData {
  int? id;
  String? code;
  String? distype;
  String? amount;
  String? linkBy;
  Null? courseId;
  Null? categoryId;
  int? maxusage;
  int? minamount;
  String? expirydate;
  String? createdAt;
  String? updatedAt;
  Null? bundleId;
  Null? stripeCouponId;
  int? showToUsers;

  PromoCodeData(
      {this.id,
        this.code,
        this.distype,
        this.amount,
        this.linkBy,
        this.courseId,
        this.categoryId,
        this.maxusage,
        this.minamount,
        this.expirydate,
        this.createdAt,
        this.updatedAt,
        this.bundleId,
        this.stripeCouponId,
        this.showToUsers});

  PromoCodeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    distype = json['distype'];
    amount = json['amount'];
    linkBy = json['link_by'];
    courseId = json['course_id'];
    categoryId = json['category_id'];
    maxusage = json['maxusage'];
    minamount = json['minamount'];
    expirydate = json['expirydate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bundleId = json['bundle_id'];
    stripeCouponId = json['stripe_coupon_id'];
    showToUsers = json['show_to_users'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['distype'] = distype;
    data['amount'] = amount;
    data['link_by'] = linkBy;
    data['course_id'] = courseId;
    data['category_id'] = categoryId;
    data['maxusage'] = maxusage;
    data['minamount'] = minamount;
    data['expirydate'] = expirydate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['bundle_id'] = bundleId;
    data['stripe_coupon_id'] = stripeCouponId;
    data['show_to_users'] = showToUsers;
    return data;
  }
}
