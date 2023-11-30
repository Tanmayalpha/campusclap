class VerifyOTPResponse {
  bool? status;
  String? message;
  VerifyOtpData? data;

  VerifyOTPResponse({this.status, this.message, this.data});

  VerifyOTPResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? VerifyOtpData.fromJson(json['data']) : null;
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

class VerifyOtpData {
  bool? registered;
  User? user;
  String? token;

  VerifyOtpData({this.registered, this.user, this.token});

  VerifyOtpData.fromJson(Map<String, dynamic> json) {
    registered = json['registered'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['registered'] = registered;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class User {
  int? id;
  String? fname;
  String? fullName;
  String? fathersName;
  String? mothersName;
  String? lname;
  String? dob;
  String? doa;
  String? mobile;
  String? email;
  String? address;
  String? marriedStatus;
  String? cityId;
  String? stateId;
  String? countryId;
  String? gender;
  String? pinCode;
  String? status;
  String? verified;
  String? userImg;
  String? role;
  String? emailVerifiedAt;
  String? detail;
  String? permanentAddress;
  String? languages;
  int? braintreeId;
  String? fbUrl;
  String? twitterUrl;
  String? youtubeUrl;
  String? linkedinUrl;
  String? preferPayMethod;
  String? paypalEmail;
  String? paytmMobile;
  String? bankAccName;
  String? bankAccNo;
  String? ifscCode;
  String? aadharNo;
  String? bankName;
  String? facebookId;
  String? googleId;
  String? amazonId;
  String? createdAt;
  String? updatedAt;
  String? zoomEmail;
  String? jwtToken;
  String? gitlabId;
  String? linkedinId;
  String? twitterId;
  String? code;
  int? google2faEnable;
  String? vacationStart;
  String? vacationEnd;
  String? affiliateId;
  String? referredBy;
  String? referralCode;
  String? plan_active;
  String? age;
  int? isVerify;
  int? isBlocked;
  String? blockNote;
  String? registerationFee;
  int? isPaid;
  String? documentDetail;
  String? documentFile;
  String? examPercentage;

  User(
      {this.id,
        this.fname,
        this.fullName,
        this.fathersName,
        this.mothersName,
        this.lname,
        this.dob,
        this.doa,
        this.mobile,
        this.email,
        this.address,
        this.marriedStatus,
        this.cityId,
        this.stateId,
        this.countryId,
        this.gender,
        this.pinCode,
        this.status,
        this.verified,
        this.userImg,
        this.role,
        this.emailVerifiedAt,
        this.detail,
        this.permanentAddress,
        this.languages,
        this.braintreeId,
        this.fbUrl,
        this.plan_active,
        this.twitterUrl,
        this.youtubeUrl,
        this.linkedinUrl,
        this.preferPayMethod,
        this.paypalEmail,
        this.paytmMobile,
        this.bankAccName,
        this.bankAccNo,
        this.ifscCode,
        this.aadharNo,
        this.bankName,
        this.facebookId,
        this.googleId,
        this.amazonId,
        this.createdAt,
        this.updatedAt,
        this.zoomEmail,
        this.jwtToken,
        this.gitlabId,
        this.linkedinId,
        this.twitterId,
        this.code,
        this.google2faEnable,
        this.vacationStart,
        this.vacationEnd,
        this.affiliateId,
        this.referredBy,
        this.referralCode,
        this.age,
        this.isVerify,
        this.isBlocked,
        this.blockNote,
        this.registerationFee,
        this.isPaid,
        this.documentDetail,
        this.documentFile,
        this.examPercentage});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 00;
    fname = json['fname'] ?? '';
    fullName = json['full_name'] ?? '';
    fathersName = json['fathers_name'] ?? '';
    mothersName = json['mothers_name'] ?? '';
    lname = json['lname'] ?? '';
    dob = json['dob'] ?? '';
    doa = json['doa'] ?? '';
    mobile = json['mobile'] ?? '';
    email = json['email'] ?? '';
    address = json['address'] ?? '';
    marriedStatus = json['married_status'] ?? '';
    cityId = json['city_id'] ?? '';
    stateId = json['state_id'] ?? '';
    countryId = json['country_id'] ?? '';
    gender = json['gender'] ?? '';
    pinCode = json['pin_code'] ?? '';
    status = json['status'].toString() ?? '';
    verified = json['verified'].toString() ??'';
    userImg = json['user_img'] ?? '';
    role = json['role'] ?? '';
    emailVerifiedAt = json['email_verified_at'] ?? '';
    detail = json['detail'] ?? '';
    permanentAddress = json['permanent_address'] ?? '';
    languages = json['languages'] ?? '';
    braintreeId = json['braintree_id'] ?? 0;
    fbUrl = json['fb_url'] ?? '';
    twitterUrl = json['twitter_url'] ?? '';
    youtubeUrl = json['youtube_url'] ?? '';
    linkedinUrl = json['linkedin_url'] ?? '';
    preferPayMethod = json['prefer_pay_method'] ?? '';
    paypalEmail = json['paypal_email'] ?? '';
    paytmMobile = json['paytm_mobile'] ?? '';
    bankAccName = json['bank_acc_name'] ?? '';
    bankAccNo = json['bank_acc_no'] ?? '';
    ifscCode = json['ifsc_code'] ?? '';
    aadharNo = json['aadhar_no'] ?? '';
    bankName = json['bank_name'] ?? '';
    facebookId = json['facebook_id'] ?? '';
    googleId = json['google_id'] ?? '';
    amazonId = json['amazon_id'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    zoomEmail = json['zoom_email'] ?? '';
    jwtToken = json['jwt_token'] ?? '';
    gitlabId = json['gitlab_id'] ?? '';
    linkedinId = json['linkedin_id'] ?? '';
    twitterId = json['twitter_id'] ?? '';
    code = json['code'] ?? '';
    google2faEnable = json['google2fa_enable'] ?? 0;
    vacationStart = json['vacation_start'] ?? '';
    vacationEnd = json['vacation_end'] ?? '';
    affiliateId = json['affiliate_id'] ?? '';
    referredBy = json['referred_by'] ?? '';
    referralCode = json['referral_code'] ?? '';
    age = json['age'] ?? '';
    isVerify = json['is_verify'] ?? 1;
    isBlocked = json['is_blocked'] ?? 0;
    blockNote = json['block_note'] ?? '';
    registerationFee = json['registeration_fee'] ?? '';
    isPaid = json['is_paid'] ?? 0;
    documentDetail = json['document_detail'] ?? '';
    documentFile = json['document_file'] ?? '';
    examPercentage = json['exam_percentage'] ?? '';
    plan_active = json['plan_active'].toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fname'] = fname;
    data['full_name'] = fullName;
    data['fathers_name'] = fathersName;
    data['mothers_name'] = mothersName;
    data['lname'] = lname;
    data['dob'] = dob;
    data['doa'] = doa;
    data['mobile'] = mobile;
    data['email'] = email;
    data['address'] = address;
    data['married_status'] = marriedStatus;
    data['city_id'] = cityId;
    data['state_id'] = stateId;
    data['country_id'] = countryId;
    data['gender'] = gender;
    data['pin_code'] = pinCode;
    data['status'] = status;
    data['verified'] = verified;
    data['user_img'] = userImg;
    data['role'] = role;
    data['email_verified_at'] = emailVerifiedAt;
    data['detail'] = detail;
    data['permanent_address'] = permanentAddress;
    data['languages'] = languages;
    data['braintree_id'] = braintreeId;
    data['fb_url'] = fbUrl;
    data['twitter_url'] = twitterUrl;
    data['youtube_url'] = youtubeUrl;
    data['linkedin_url'] = linkedinUrl;
    data['prefer_pay_method'] = preferPayMethod;
    data['paypal_email'] = paypalEmail;
    data['paytm_mobile'] = paytmMobile;
    data['bank_acc_name'] = bankAccName;
    data['bank_acc_no'] = bankAccNo;
    data['ifsc_code'] = ifscCode;
    data['aadhar_no'] = aadharNo;
    data['bank_name'] = bankName;
    data['facebook_id'] = facebookId;
    data['google_id'] = googleId;
    data['amazon_id'] = amazonId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['zoom_email'] = zoomEmail;
    data['jwt_token'] = jwtToken;
    data['gitlab_id'] = gitlabId;
    data['linkedin_id'] = linkedinId;
    data['twitter_id'] = twitterId;
    data['code'] = code;
    data['google2fa_enable'] = google2faEnable;
    data['vacation_start'] = vacationStart;
    data['vacation_end'] = vacationEnd;
    data['affiliate_id'] = affiliateId;
    data['referred_by'] = referredBy;
    data['referral_code'] = referralCode;
    data['age'] = age;
    data['is_verify'] = isVerify;
    data['is_blocked'] = isBlocked;
    data['block_note'] = blockNote;
    data['registeration_fee'] = registerationFee;
    data['is_paid'] = isPaid;
    data['document_detail'] = documentDetail;
    data['document_file'] = documentFile;
    data['exam_percentage'] = examPercentage;
    data['plan_active'] = plan_active;
    return data;
  }
}
