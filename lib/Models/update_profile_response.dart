class UpdateProfileResponse {
  bool? status;
  String? message;
  Data? data;

  UpdateProfileResponse({this.status, this.message, this.data});

  UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? fullName;
  String? mobile;
  String? email;
  String? referralCode;
  dynamic referredBy;
  dynamic fathersName;
  dynamic mothersName;
  dynamic dob;
  dynamic gender;
  dynamic aadharNo;
  String? languages;
  dynamic address;
  dynamic pinCode;
  dynamic alternateMobile;

  Data(
      {this.id,
        this.fullName,
        this.mobile,
        this.email,
        this.referralCode,
        this.referredBy,
        this.fathersName,
        this.mothersName,
        this.dob,
        this.gender,
        this.aadharNo,
        this.languages,
        this.address,
        this.pinCode,
        this.alternateMobile});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    mobile = json['mobile'];
    email = json['email'];
    referralCode = json['referral_code'];
    referredBy = json['referred_by'];
    fathersName = json['fathers_name'];
    mothersName = json['mothers_name'];
    dob = json['dob'];
    gender = json['gender'];
    aadharNo = json['aadhar_no'];
    languages = json['languages'];
    address = json['address'];
    pinCode = json['pin_code'];
    alternateMobile = json['alternate_mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['full_name'] = fullName;
    data['mobile'] = mobile;
    data['email'] = email;
    data['referral_code'] = referralCode;
    data['referred_by'] = referredBy;
    data['fathers_name'] = fathersName;
    data['mothers_name'] = mothersName;
    data['dob'] = dob;
    data['gender'] = gender;
    data['aadhar_no'] = aadharNo;
    data['languages'] = languages;
    data['address'] = address;
    data['pin_code'] = pinCode;
    data['alternate_mobile'] = alternateMobile;
    return data;
  }
}
