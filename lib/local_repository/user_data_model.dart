class UserData {
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
  int? status;
  int? verified;
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
  String? age;
  int? isVerify;
  int? isBlocked;
  String? blockNote;
  String? registerationFee;
  int? isPaid;
  String? documentDetail;
  String? documentFile;
  String? examPercentage;
  String? plan_active;

  UserData(
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

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json['id'] ?? 00,
    plan_active: json['plan_active'] ?? '0',
    fname:  json['fname'] ?? '',
    fullName: json['full_name'] ?? '',
    fathersName: json['fathers_name'] ?? '',
    mothersName: json['mothers_name'] ?? '',
    lname: json['lname'] ?? '',
    dob: json['dob'] ?? '',
    doa: json['doa'] ?? '',
    mobile: json['mobile'] ?? '',
    email: json['email'] ?? '',
    address: json['address'] ?? '',
    marriedStatus: json['married_status'] ?? '',
    cityId: json['city_id'] ?? '',
    stateId: json['state_id'] ?? '',
    countryId: json['country_id'] ?? '',
    gender: json['gender'] ?? '',
    pinCode: json['pin_code'] ?? '',
    status: json['status'] ?? '',
    verified: json['verified'] ??'',
    userImg: json['user_img'] ?? '',
    role: json['role'] ?? '',
    emailVerifiedAt: json['email_verified_at'] ?? '',
    detail: json['detail'] ?? '',
    permanentAddress: json['permanent_address'] ?? '',
    languages: json['languages'] ?? '',
    braintreeId: json['braintree_id'] ?? 0,
    fbUrl: json['fb_url'] ?? '',
    twitterUrl: json['twitter_url'] ?? '',
    youtubeUrl: json['youtube_url'] ?? '',
    linkedinUrl: json['linkedin_url'] ?? '',
    preferPayMethod: json['prefer_pay_method'] ?? '',
    paypalEmail: json['paypal_email'] ?? '',
    paytmMobile: json['paytm_mobile'] ?? '',
    bankAccName: json['bank_acc_name'] ?? '',
    bankAccNo: json['bank_acc_no'] ?? '',
    ifscCode: json['ifsc_code'] ?? '',
    aadharNo: json['aadhar_no'] ?? '',
    bankName: json['bank_name'] ?? '',
    facebookId: json['facebook_id'] ?? '',
    googleId: json['google_id'] ?? '',
    amazonId: json['amazon_id'] ?? '',
    createdAt: json['created_at'] ?? '',
    updatedAt: json['updated_at'] ?? '',
    zoomEmail: json['zoom_email'] ?? '',
    jwtToken: json['jwt_token'] ?? '',
    gitlabId: json['gitlab_id'] ?? '',
    linkedinId: json['linkedin_id'] ?? '',
    twitterId: json['twitter_id'] ?? '',
    code: json['code'] ?? '',
    google2faEnable: json['google2fa_enable'] ?? 0,
    vacationStart: json['vacation_start'] ?? '',
    vacationEnd: json['vacation_end'] ?? '',
    affiliateId: json['affiliate_id'] ?? '',
    referredBy: json['referred_by'] ?? '',
    referralCode: json['referral_code'] ?? '',
    age: json['age'] ?? '',
    isVerify: json['is_verify'] ?? 1,
    isBlocked: json['is_blocked'] ?? '',
    blockNote: json['block_note'] ?? '',
    registerationFee: json['registeration_fee'] ?? '',
    isPaid: json['is_paid'] ?? 0,
    documentDetail: json['document_detail'] ?? '',
    documentFile: json['document_file'] ?? '',
    examPercentage: json['exam_percentage'] ?? '',
  );

  Map<String, dynamic>  toJson() => {
    'id': id,
    'plan_active': plan_active,
    'fname': fname,
    'full_name': fullName,
    'fathers_name': fathersName,
    'mothers_name': mothersName,
    'lname': lname,
    'dob': dob,
    'doa': doa,
    'mobile': mobile,
    'email': email,
    'address': address,
    'married_status': marriedStatus,
    'city_id': cityId,
    'state_id': stateId,
    'country_id': countryId,
    'gender': gender,
    'pin_code': pinCode,
    'status': status,
    'verified': verified,
    'user_img': userImg,
    'role': role,
    'email_verified_at': emailVerifiedAt,
    'detail': detail,
    'permanent_address': permanentAddress,
    'languages': languages,
    'braintree_id': braintreeId,
    'fb_url': fbUrl,
    'twitter_url': twitterUrl,
    'youtube_url': youtubeUrl,
    'linkedin_url': linkedinUrl,
    'prefer_pay_method': preferPayMethod,
    'paypal_email': paypalEmail,
    'paytm_mobile': paytmMobile,
    'bank_acc_name': bankAccName,
    'bank_acc_no': bankAccNo,
    'ifsc_code': ifscCode,
    'aadhar_no': aadharNo,
    'bank_name': bankName,
    'facebook_id': facebookId,
    'google_id': googleId,
    'amazon_id': amazonId,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'zoom_email': zoomEmail,
    'jwt_token': jwtToken,
    'gitlab_id': gitlabId,
    'linkedin_id': linkedinId,
    'twitter_id': twitterId,
    'code': code,
    'google2fa_enable': google2faEnable,
    'vacation_start': vacationStart,
    'vacation_end': vacationEnd,
    'affiliate_id': affiliateId,
    'referred_by': referredBy,
    'referral_code': referralCode,
    'age': age,
    'is_verify': isVerify,
    'is_blocked': isBlocked,
    'block_note': blockNote,
    'registeration_fee': registerationFee,
    'is_paid': isPaid,
    'document_detail': documentDetail,
    'document_file': documentFile,
    'exam_percentage': examPercentage,
  };
}
