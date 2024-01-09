class GetProfileResponse {
  bool? status;
  String? message;
  ProfileData? data;

  GetProfileResponse({this.status, this.message, this.data});

  GetProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileData {
  int? id;
  String? fname;
  String? lname;
  dynamic dob;
  dynamic doa;
  String? mobile;
  String? email;
  String? password;
  dynamic address;
  dynamic marriedStatus;
  dynamic cityId;
  dynamic stateId;
  dynamic countryId;
  dynamic gender;
  dynamic pinCode;
  int? status;
  int? verified;
  dynamic userImg;
  String? role;
  dynamic emailVerifiedAt;
  dynamic detail;
  dynamic permanentAddress;
  dynamic languages;
  int? braintreeId;
  dynamic fbUrl;
  dynamic twitterUrl;
  dynamic youtubeUrl;
  dynamic linkedinUrl;
  dynamic rememberToken;
  dynamic preferPayMethod;
  dynamic paypalEmail;
  dynamic paytmMobile;
  dynamic bankAccName;
  dynamic bankAccNo;
  dynamic ifscCode;
  dynamic aadharNo;
  dynamic bankName;
  dynamic facebookId;
  dynamic googleId;
  dynamic amazonId;
  String? createdAt;
  String? updatedAt;
  dynamic zoomEmail;
  dynamic jwtToken;
  dynamic gitlabId;
  dynamic linkedinId;
  dynamic twitterId;
  dynamic code;
  dynamic google2faSecret;
  int? google2faEnable;
  dynamic vacationStart;
  dynamic vacationEnd;
  dynamic affiliateId;
  dynamic referredBy;
  String? referralCode;
  String? referralCodeStatus;
  String? age;
  int? isVerify;
  int? isBlocked;
  int? profileCompletionStatus;
  dynamic blockNote;
  dynamic registerationFee;
  int? isPaid;
  dynamic documentDetail;
  dynamic documentFile;
  dynamic examPercentage;
  String? planActive;
  int? userId;
  dynamic fatherName;
  dynamic motherName;
  String? alternateMobile;
  dynamic aadhaarNumber;
  String? collegeName;
  String? collegeState;
  String? collegeDictrict;
  String? collegePlace;
  String? tenthPercent;
  String? markFormat10;
  String? twelthPercent;
  String? markFormat12;
  String? ugStatus;
  String? ugCourse;
  String? ugSpecialisations;
  String? ugYearOfPassing;
  String? pgYearOfPassing;
  String? ugAggregate;
  String? markFormatUG;
  String? pgStatus;
  String? pgCourse;
  String? pgSpecialisations;
  String? pgAggregate;
  String? markFormatPG;
  String? aadharImage;
  String? selfieImage;
  String? resume;
  String? languageId;

  ProfileData(
      {this.id,
        this.fname,
        this.lname,
        this.dob,
        this.doa,
        this.mobile,
        this.email,
        this.password,
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
        this.twitterUrl,
        this.youtubeUrl,
        this.linkedinUrl,
        this.rememberToken,
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
        this.google2faSecret,
        this.google2faEnable,
        this.vacationStart,
        this.vacationEnd,
        this.affiliateId,
        this.referredBy,
        this.referralCode,
        this.age,
        this.isVerify,
        this.isBlocked,
        this.profileCompletionStatus,
        this.blockNote,
        this.registerationFee,
        this.isPaid,
        this.documentDetail,
        this.documentFile,
        this.examPercentage,
        this.planActive,
        this.userId,
        this.fatherName,
        this.motherName,
        this.alternateMobile,
        this.aadhaarNumber,
        this.collegeName,
        this.collegeState,
        this.collegeDictrict,
        this.collegePlace,
        this.tenthPercent,
        this.markFormat10,
        this.twelthPercent,
        this.markFormat12,
        this.ugStatus,
        this.ugCourse,
        this.ugSpecialisations,
        this.ugYearOfPassing,
        this.pgYearOfPassing,
        this.ugAggregate,
        this.markFormatUG,
        this.pgStatus,
        this.pgCourse,
        this.pgSpecialisations,
        this.pgAggregate,
        this.markFormatPG,
        this.aadharImage,
        this.selfieImage,
        this.resume,
        this.referralCodeStatus,
        this.languageId});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['fname'];
    lname = json['lname'];
    dob = json['dob'];
    doa = json['doa'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    address = json['address'];
    marriedStatus = json['married_status'];
    cityId = json['city_id'];
    stateId = json['state_id'];
    countryId = json['country_id'];
    gender = json['gender'];
    pinCode = json['pin_code'];
    status = json['status'];
    verified = json['verified'];
    userImg = json['user_img'];
    role = json['role'];
    emailVerifiedAt = json['email_verified_at'];
    detail = json['detail'];
    permanentAddress = json['permanent_address'];
    languages = json['languages'];
    braintreeId = json['braintree_id'];
    fbUrl = json['fb_url'];
    twitterUrl = json['twitter_url'];
    youtubeUrl = json['youtube_url'];
    linkedinUrl = json['linkedin_url'];
    rememberToken = json['remember_token'];
    preferPayMethod = json['prefer_pay_method'];
    paypalEmail = json['paypal_email'];
    paytmMobile = json['paytm_mobile'];
    bankAccName = json['bank_acc_name'];
    bankAccNo = json['bank_acc_no'];
    ifscCode = json['ifsc_code'];
    aadharNo = json['aadhar_no'];
    bankName = json['bank_name'];
    facebookId = json['facebook_id'];
    googleId = json['google_id'];
    amazonId = json['amazon_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    zoomEmail = json['zoom_email'];
    jwtToken = json['jwt_token'];
    gitlabId = json['gitlab_id'];
    linkedinId = json['linkedin_id'];
    twitterId = json['twitter_id'];
    code = json['code'];
    google2faSecret = json['google2fa_secret'];
    google2faEnable = json['google2fa_enable'];
    vacationStart = json['vacation_start'];
    vacationEnd = json['vacation_end'];
    affiliateId = json['affiliate_id'];
    referredBy = json['referred_by'];
    referralCode = json['referral_code'];
    referralCodeStatus = json['referral_code_status'].toString();
    age = json['age'];
    isVerify = json['is_verify'];
    isBlocked = json['is_blocked'];
    profileCompletionStatus = json['profile_completion_status'];
    blockNote = json['block_note'];
    registerationFee = json['registeration_fee'];
    isPaid = json['is_paid'];
    documentDetail = json['document_detail'];
    documentFile = json['document_file'];
    examPercentage = json['exam_percentage'];
    planActive = json['plan_active'];
    userId = json['user_id'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    alternateMobile = json['alternate_mobile'];
    aadhaarNumber = json['aadhaar_number'];
    collegeName = json['college_name'];
    collegeState = json['college_state'];
    collegeDictrict = json['college_dictrict'];
    collegePlace = json['college_place'];
    tenthPercent = json['tenth_percent'];
    markFormat10 = json['mark_format10'];
    twelthPercent = json['twelth_percent'];
    markFormat12 = json['mark_format12'];
    ugStatus = json['ug_status'];
    ugCourse = json['ug_course'];
    ugSpecialisations = json['ug_specialisations'];
    ugYearOfPassing = json['ug_year_of_passing'];
    pgYearOfPassing = json['pg_year_of_passing'];
    ugAggregate = json['ug_aggregate'];
    markFormatUG = json['mark_format_UG'];
    pgStatus = json['pg_status'];
    pgCourse = json['pg_course'];
    pgSpecialisations = json['pg_specialisations'];
    pgAggregate = json['pg_aggregate'];
    markFormatPG = json['mark_format_PG'];
    aadharImage = json['aadhar_image'];
    selfieImage = json['selfie_image'];
    resume = json['resume'];
    languageId = json['language_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['dob'] = this.dob;
    data['doa'] = this.doa;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['password'] = this.password;
    data['address'] = this.address;
    data['married_status'] = this.marriedStatus;
    data['city_id'] = this.cityId;
    data['state_id'] = this.stateId;
    data['country_id'] = this.countryId;
    data['gender'] = this.gender;
    data['pin_code'] = this.pinCode;
    data['status'] = this.status;
    data['verified'] = this.verified;
    data['user_img'] = this.userImg;
    data['role'] = this.role;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['detail'] = this.detail;
    data['permanent_address'] = this.permanentAddress;
    data['languages'] = this.languages;
    data['braintree_id'] = this.braintreeId;
    data['fb_url'] = this.fbUrl;
    data['twitter_url'] = this.twitterUrl;
    data['youtube_url'] = this.youtubeUrl;
    data['linkedin_url'] = this.linkedinUrl;
    data['remember_token'] = this.rememberToken;
    data['prefer_pay_method'] = this.preferPayMethod;
    data['paypal_email'] = this.paypalEmail;
    data['paytm_mobile'] = this.paytmMobile;
    data['bank_acc_name'] = this.bankAccName;
    data['bank_acc_no'] = this.bankAccNo;
    data['ifsc_code'] = this.ifscCode;
    data['aadhar_no'] = this.aadharNo;
    data['bank_name'] = this.bankName;
    data['facebook_id'] = this.facebookId;
    data['google_id'] = this.googleId;
    data['amazon_id'] = this.amazonId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['zoom_email'] = this.zoomEmail;
    data['jwt_token'] = this.jwtToken;
    data['gitlab_id'] = this.gitlabId;
    data['linkedin_id'] = this.linkedinId;
    data['twitter_id'] = this.twitterId;
    data['code'] = this.code;
    data['google2fa_secret'] = this.google2faSecret;
    data['google2fa_enable'] = this.google2faEnable;
    data['vacation_start'] = this.vacationStart;
    data['vacation_end'] = this.vacationEnd;
    data['affiliate_id'] = this.affiliateId;
    data['referred_by'] = this.referredBy;
    data['referral_code'] = this.referralCode;
    data['age'] = this.age;
    data['is_verify'] = this.isVerify;
    data['is_blocked'] = this.isBlocked;
    data['profile_completion_status'] = this.profileCompletionStatus;
    data['block_note'] = this.blockNote;
    data['registeration_fee'] = this.registerationFee;
    data['is_paid'] = this.isPaid;
    data['document_detail'] = this.documentDetail;
    data['document_file'] = this.documentFile;
    data['exam_percentage'] = this.examPercentage;
    data['plan_active'] = this.planActive;
    data['user_id'] = this.userId;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['alternate_mobile'] = this.alternateMobile;
    data['aadhaar_number'] = this.aadhaarNumber;
    data['college_name'] = this.collegeName;
    data['college_state'] = this.collegeState;
    data['college_dictrict'] = this.collegeDictrict;
    data['college_place'] = this.collegePlace;
    data['tenth_percent'] = this.tenthPercent;
    data['mark_format10'] = this.markFormat10;
    data['twelth_percent'] = this.twelthPercent;
    data['mark_format12'] = this.markFormat12;
    data['ug_status'] = this.ugStatus;
    data['ug_course'] = this.ugCourse;
    data['ug_specialisations'] = this.ugSpecialisations;
    data['ug_year_of_passing'] = this.ugYearOfPassing;
    data['pg_year_of_passing'] = this.pgYearOfPassing;
    data['ug_aggregate'] = this.ugAggregate;
    data['mark_format_UG'] = this.markFormatUG;
    data['pg_status'] = this.pgStatus;
    data['pg_course'] = this.pgCourse;
    data['pg_specialisations'] = this.pgSpecialisations;
    data['pg_aggregate'] = this.pgAggregate;
    data['mark_format_PG'] = this.markFormatPG;
    data['aadhar_image'] = this.aadharImage;
    data['selfie_image'] = this.selfieImage;
    data['resume'] = this.resume;
    data['language_id'] = this.languageId;
    return data;
  }
}
