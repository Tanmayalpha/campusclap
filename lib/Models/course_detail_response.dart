class CourseDetailResponse {
  Course? course;
  List<Review>? review;
  int? learn;
  int? price;
  int? value;
  int? totalRatingPercent;
  int? totalRating;
  int? studentEnrolled;
  String? assessmentBookingSlotId;

  CourseDetailResponse(
      {this.course,
        this.review,
        this.learn,
        this.price,
        this.value,
        this.totalRatingPercent,
        this.totalRating,this.assessmentBookingSlotId,
        this.studentEnrolled});

  CourseDetailResponse.fromJson(Map<String, dynamic> json) {
    course =
    json['course'] != null ? new Course.fromJson(json['course']) : null;
    review = json["review"] == null
        ? null
        : List<Review>.from(json["review"].map((x) => Review.fromJson(x)));
    learn = json['learn'];
    price = json['price'];
    value = json['value'];
    totalRatingPercent = json['total_rating_percent'];
    totalRating = json['total_rating'];
    studentEnrolled = json['student_enrolled'];
    assessmentBookingSlotId = json['assessment_booking_slot_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.course != null) {
      data['course'] = this.course!.toJson();
    }
    data['review'] = this.review;
    data['learn'] = this.learn;
    data['price'] = this.price;
    data['value'] = this.value;
    data['total_rating_percent'] = this.totalRatingPercent;
    data['total_rating'] = this.totalRating;
    data['student_enrolled'] = this.studentEnrolled;
    return data;
  }
}

class Review {
  Review({
    this.id,
    this.userId,
    this.fname,
    this.lname,
    this.userimage,
    this.imagepath,
    this.learn,
    this.price,
    this.value,
    this.reviews,
    this.createdBy,
    this.updatedBy,
    this.totalRating,
    this.likeCount,
    this.dislikeCount,
  });

  int? id;
  dynamic userId;
  String? fname;
  String? lname;
  dynamic userimage;
  String? imagepath;
  dynamic learn;
  dynamic price;
  dynamic value;
  String? reviews;
  DateTime? createdBy;
  DateTime? updatedBy;
  double? totalRating;
  int? likeCount;
  int? dislikeCount;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    userId: json["user_id"],
    fname: json["fname"],
    lname: json["lname"],
    userimage: json["userimage"],
    imagepath: json["imagepath"],
    learn: json["learn"].toString(),
    price: json["price"].toString(),
    value: json["value"].toString(),
    reviews: json["reviews"],
    createdBy: json["created_by"] == null
        ? null
        : DateTime.parse(json["created_by"]),
    updatedBy: json["updated_by"] == null
        ? null
        : DateTime.parse(json["updated_by"]),
    totalRating: json['total_rating']== null ? null : double.parse(json['total_rating'].toString()),
    likeCount: json['like_count'],
    dislikeCount: json['dislike_count'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "fname": fname,
    "lname": lname,
    "userimage": userimage,
    "imagepath": imagepath,
    "learn": learn,
    "price": price,
    "value": value,
    "reviews": reviews,
    "created_by": createdBy!.toIso8601String(),
    "updated_by": updatedBy!.toIso8601String(),
    'total_rating': totalRating,
    'like_count': likeCount,
    'dislike_count': dislikeCount,
  };
}

class Reviews {
  int? id;
  String? userId;
  String? fname;
  String? lname;
  String? userimage;
  String? imagepath;
  String? learn;
  String? price;
  String? value;
  String? reviews;
  String? createdBy;
  String? updatedBy;
  double? totalRating;
  int? likeCount;
  int? dislikeCount;

  Reviews(
      {this.id,
        this.userId,
        this.fname,
        this.lname,
        this.userimage,
        this.imagepath,
        this.learn,
        this.price,
        this.value,
        this.reviews,
        this.createdBy,
        this.updatedBy,
        this.totalRating,
        this.likeCount,
        this.dislikeCount});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json['user_id'];
    fname = json['fname'];
    lname = json['lname'];
    userimage = json['userimage'];
    imagepath = json['imagepath'];
    learn = json['learn'];
    price = json['price'];
    value = json['value'];
    reviews = json['reviews'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    totalRating = json['total_rating'];
    likeCount = json['like_count'];
    dislikeCount = json['dislike_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['userimage'] = this.userimage;
    data['imagepath'] = this.imagepath;
    data['learn'] = this.learn;
    data['price'] = this.price;
    data['value'] = this.value;
    data['reviews'] = this.reviews;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['total_rating'] = this.totalRating;
    data['like_count'] = this.likeCount;
    data['dislike_count'] = this.dislikeCount;
    return data;
  }
}


class Course {
  int? id;
  String? userId;
  String? categoryId;
  String? subcategoryId;
  String? childcategoryId;
  String? languageId;
  String? title;
  String? shortDetail;
  String? detail;
  String? requirement;
  String? price;
  String? discountPrice;
  dynamic day;
  dynamic video;
  String? url;
  String? featured;
  String? slug;
  String? status;
  String? previewImage;
  dynamic videoUrl;
  String? previewType;
  String? type;
  dynamic duration;
  String? createdAt;
  String? updatedAt;
  String? durationType;
  dynamic instructorRevenue;
  int? involvementRequest;
  dynamic refundPolicyId;
  dynamic levelTags;
  int? assignmentEnable;
  int? appointmentEnable;
  int? certificateEnable;
  dynamic courseTags;
  dynamic rejectTxt;
  int? dripEnable;
  String? institudeId;
  dynamic country;
  int? otherCats;
  Category? category;
  List<Include>? include;
  List<Whatlearns>? whatlearns;
  List<Null>? related;
  Language? language;
  User? user;
  List<Order>? order;
  List<Chapter>? chapter;
  List<Courseclass>? courseclass;
  Policy? policy;

  Course(
      {this.id,
        this.userId,
        this.categoryId,
        this.subcategoryId,
        this.childcategoryId,
        this.languageId,
        this.title,
        this.shortDetail,
        this.detail,
        this.requirement,
        this.price,
        this.discountPrice,
        this.day,
        this.video,
        this.url,
        this.featured,
        this.slug,
        this.status,
        this.previewImage,
        this.videoUrl,
        this.previewType,
        this.type,
        this.duration,
        this.createdAt,
        this.updatedAt,
        this.durationType,
        this.instructorRevenue,
        this.involvementRequest,
        this.refundPolicyId,
        this.levelTags,
        this.assignmentEnable,
        this.appointmentEnable,
        this.certificateEnable,
        this.courseTags,
        this.rejectTxt,
        this.dripEnable,
        this.institudeId,
        this.country,
        this.otherCats,
        this.category,
        this.include,
        this.whatlearns,
        this.related,
        this.language,
        this.user,
        this.order,
        this.chapter,
        this.courseclass,
        this.policy});

  Course.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null ;
    createdAt = json['created_at'];
    if (json['courseclass'] != null) {
      courseclass = <Courseclass>[];
      json['courseclass'].forEach((v) {
        courseclass!.add( Courseclass.fromJson(v));
      });
    }
    id = json['id'];
    if (json['whatlearns'] != null) {
      whatlearns = <Whatlearns>[];
      json['whatlearns'].forEach((v) {
        whatlearns!.add(new Whatlearns.fromJson(v));
      });
    }
    if (json['chapter'] != null) {
      chapter = <Chapter>[];
      json['chapter'].forEach((v) {
        chapter!.add(new Chapter.fromJson(v));
      });
    }
    requirement = json['requirement'];
     userId = json['user_id'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    childcategoryId = json['childcategory_id'];
    languageId = json['language_id'];
    title = json['title'];
    shortDetail = json['short_detail'];
    detail = json['detail'];
    requirement = json['requirement'];
    price = json['price'];
    discountPrice = json['discount_price'];
    day = json['day'];
    video = json['video'] ?? '';
    url = json['url'];
    featured = json['featured'];
    slug = json['slug'];
    status = json['status'];
    previewImage = json['preview_image'];
    videoUrl = json['video_url'] ?? '';
    previewType = json['preview_type'] ?? '';
    type = json['type'];
    duration = json['duration'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    durationType = json['duration_type'];
    instructorRevenue = json['instructor_revenue'];
    involvementRequest = json['involvement_request'];
    refundPolicyId = json['refund_policy_id'] ?? '';
    levelTags = json['level_tags'] ?? '';
    assignmentEnable = json['assignment_enable'];
    appointmentEnable = json['appointment_enable'];
    certificateEnable = json['certificate_enable'];
    courseTags = json['course_tags'] ?? '';
    rejectTxt = json['reject_txt'] ?? '';
    dripEnable = json['drip_enable'];
    institudeId = json['institude_id'];
    country = json['country'] ?? '';
    otherCats = json['other_cats'];
    category = json['category'] != null
        ?  Category.fromJson(json['category'])
        : null;
    if (json['include'] != null) {
      include = <Include>[];
      json['include'].forEach((v) {
        include!.add(new Include.fromJson(v));
      });
    }
    if (json['whatlearns'] != null) {
      whatlearns = <Whatlearns>[];
      json['whatlearns'].forEach((v) {
        whatlearns!.add(new Whatlearns.fromJson(v));
      });
    }
    if (json['related'] != null) {
      related = <Null>[];
      json['related'].forEach((v) {
        related!.add( v.fromJson(v));
      });
    }
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['order'] != null) {
      order = json["order"] == null ||
          json["order"] == [] ||
          json["order"] == "[]"
          ? []
          : List<Order>.from(json["order"].map((x) => Order.fromJson(x)));
    }
    if (json['chapter'] != null) {
      chapter = <Chapter>[];
      json['chapter'].forEach((v) {
        chapter!.add(new Chapter.fromJson(v));
      });
    }
    if (json['courseclass'] != null) {
      courseclass = <Courseclass>[];
      json['courseclass'].forEach((v) {
        courseclass!.add(new Courseclass.fromJson(v));
      });
    }
    policy =
    json['policy'] != null ? new Policy.fromJson(json['policy']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['childcategory_id'] = this.childcategoryId;
    data['language_id'] = this.languageId;
    data['title'] = this.title;
    data['short_detail'] = this.shortDetail;
    data['detail'] = this.detail;
    data['requirement'] = this.requirement;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['day'] = this.day;
    data['video'] = this.video;
    data['url'] = this.url;
    data['featured'] = this.featured;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['preview_image'] = this.previewImage;
    data['video_url'] = this.videoUrl;
    data['preview_type'] = this.previewType;
    data['type'] = this.type;
    data['duration'] = this.duration;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['duration_type'] = this.durationType;
    data['instructor_revenue'] = this.instructorRevenue;
    data['involvement_request'] = this.involvementRequest;
    data['refund_policy_id'] = this.refundPolicyId;
    data['level_tags'] = this.levelTags;
    data['assignment_enable'] = this.assignmentEnable;
    data['appointment_enable'] = this.appointmentEnable;
    data['certificate_enable'] = this.certificateEnable;
    data['course_tags'] = this.courseTags;
    data['reject_txt'] = this.rejectTxt;
    data['drip_enable'] = this.dripEnable;
    data['institude_id'] = this.institudeId;
    data['country'] = this.country;
    data['other_cats'] = this.otherCats;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.include != null) {
      data['include'] = this.include!.map((v) => v.toJson()).toList();
    }
    if (this.whatlearns != null) {
      data['whatlearns'] = this.whatlearns!.map((v) => v.toJson()).toList();
    }
    /*if (this.related != null) {
      data['related'] = this.related!.map((v) => v.toJson()).toList();
    }*/
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
   /* if (this.order != null) {
      data['order'] = this.order!.map((v) => v.toJson()).toList();
    }*/
    if (this.chapter != null) {
      data['chapter'] = this.chapter!.map((v) => v.toJson()).toList();
    }
    if (this.courseclass != null) {
      data['courseclass'] = this.courseclass!.map((v) => v.toJson()).toList();
    }
    if (this.policy != null) {
      data['policy'] = this.policy!.toJson();
    }
    return data;
  }
}

class Order {
  Order({
    this.id,
    this.courseId,
    this.userId,
    this.instructorId,
    this.orderId,
    this.transactionId,
    this.paymentMethod,
    this.totalAmount,
    this.couponDiscount,
    this.currency,
    this.currencyIcon,
    this.status,
    this.duration,
    this.durationType,
    this.enrollStart,
    this.enrollExpire,
    this.instructorRevenue,
    this.bundleId,
    this.bundleCourseId,
    this.proof,
    this.createdAt,
    this.updatedAt,
    this.saleId,
  });

  int? id;
  dynamic courseId;
  dynamic userId;
  dynamic instructorId;
  String? orderId;
  String? transactionId;
  String? paymentMethod;
  String? totalAmount;
  dynamic couponDiscount;
  String? currency;
  String? currencyIcon;
  dynamic status;
  dynamic duration;
  String? durationType;
  DateTime? enrollStart;
  DateTime? enrollExpire;
  dynamic instructorRevenue;
  dynamic bundleId;
  dynamic bundleCourseId;
  String? proof;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic saleId;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    courseId: json["course_id"],
    userId: json["user_id"],
    instructorId: json["instructor_id"],
    orderId: json["order_id"],
    transactionId: json["transaction_id"],
    paymentMethod: json["payment_method"],
    totalAmount: json["total_amount"],
    couponDiscount: json["coupon_discount"],
    currency: json["currency"],
    currencyIcon: json["currency_icon"],
    status: json["status"],
    duration: json["duration"],
    durationType:
    json["duration_type"] == null ? null : json["duration_type"],
    enrollStart: json["enroll_start"] == null
        ? null
        : DateTime.parse(json["enroll_start"]),
    enrollExpire: json["enroll_expire"] == null
        ? null
        : DateTime.parse(json["enroll_expire"]),
    instructorRevenue: json["instructor_revenue"],
    bundleId: json["bundle_id"],
    bundleCourseId: json["bundle_course_id"],
    proof: json["proof"] == null ? null : json["proof"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    saleId: json["sale_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "course_id": courseId,
    "user_id": userId,
    "instructor_id": instructorId,
    "order_id": orderId,
    "transaction_id": transactionId,
    "payment_method": paymentMethod,
    "total_amount": totalAmount,
    "coupon_discount": couponDiscount,
    "currency": currency,
    "currency_icon": currencyIcon,
    "status": status,
    "duration": duration,
    "duration_type": durationType == null ? null : durationType,
    "enroll_start": enrollStart == null
        ? null
        : "${enrollStart!.year.toString().padLeft(4, '0')}-${enrollStart!.month.toString().padLeft(2, '0')}-${enrollStart!.day.toString().padLeft(2, '0')}",
    "enroll_expire": enrollExpire == null
        ? null
        : "${enrollExpire!.year.toString().padLeft(4, '0')}-${enrollExpire!.month.toString().padLeft(2, '0')}-${enrollExpire!.day.toString().padLeft(2, '0')}",
    "instructor_revenue": instructorRevenue,
    "bundle_id": bundleId,
    "bundle_course_id": bundleCourseId,
    "proof": proof == null ? null : proof,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "sale_id": saleId,
  };
}

class Category {
  int? id;
  String? title;
  String? icon;
  String? slug;
  String? featured;
  String? status;
  int? position;
  String? createdAt;
  String? updatedAt;
  dynamic? catImage;

  Category(
      {this.id,
        this.title,
        this.icon,
        this.slug,
        this.featured,
        this.status,
        this.position,
        this.createdAt,
        this.updatedAt,
        this.catImage});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    icon = json['icon'];
    slug = json['slug'];
    featured = json['featured'];
    status = json['status'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    catImage = json['cat_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['slug'] = this.slug;
    data['featured'] = this.featured;
    data['status'] = this.status;
    data['position'] = this.position;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['cat_image'] = this.catImage;
    return data;
  }
}

class Include {
  int? id;
  String? courseId;
  dynamic item;
  String? icon;
  String? detail;
  String? status;
  String? createdAt;
  String? updatedAt;

  Include(
      {this.id,
        this.courseId,
        this.item,
        this.icon,
        this.detail,
        this.status,
        this.createdAt,
        this.updatedAt});

  Include.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    item = json['item'];
    icon = json['icon'];
    detail = json['detail'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['item'] = this.item;
    data['icon'] = this.icon;
    data['detail'] = this.detail;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Whatlearns {
  int? id;
  String? courseId;
  String? detail;
  String? status;
  String? createdAt;
  String? updatedAt;

  Whatlearns(
      {this.id,
        this.courseId,
        this.detail,
        this.status,
        this.createdAt,
        this.updatedAt});

  Whatlearns.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    detail = json['detail'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['detail'] = this.detail;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Language {
  int? id;
  String? name;
  String? status;
  String? createdAt;
  String? updatedAt;

  Language({this.id, this.name, this.status, this.createdAt, this.updatedAt});

  Language.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
  int? id;
  String? fname;
  String? lname;
  dynamic dob;
  dynamic doa;
  dynamic mobile;
  String? email;
  dynamic address;
  dynamic marriedStatus;
  dynamic cityId;
  dynamic stateId;
  dynamic countryId;
  dynamic gender;
  dynamic pinCode;
  dynamic status;
  dynamic verified;
  String? userImg;
  String? role;
  DateTime? emailVerifiedAt;
  String? detail;
  dynamic braintreeId;
  dynamic fbUrl;
  dynamic twitterUrl;
  String? youtubeUrl;
  String? linkedinUrl;
  dynamic preferPayMethod;
  dynamic paypalEmail;
  dynamic paytmMobile;
  dynamic bankAccName;
  dynamic bankAccNo;
  dynamic ifscCode;
  dynamic bankName;
  dynamic facebookId;
  dynamic googleId;
  dynamic amazonId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? zoomEmail;
  String? jwtToken;
  dynamic gitlabId;
  dynamic linkedinId;
  dynamic twitterId;
  dynamic code;

  User(
      {this.id,
        this.fname,
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
        this.braintreeId,
        this.fbUrl,
        this.twitterUrl,
        this.youtubeUrl,
        this.linkedinUrl,
        this.preferPayMethod,
        this.paypalEmail,
        this.paytmMobile,
        this.bankAccName,
        this.bankAccNo,
        this.ifscCode,
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
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['fname']== null ? null : json["fname"];
    lname = json['lname']== null ? null : json["lname"];
    dob = json['dob']== null ? null : json["dob"];
    doa = json['doa']== null ? null : json["doa"];
    mobile = json["mobile"] == null ? null : json["mobile"];
    email = json['email'] == null ? null : json["email"];
    address = json['address'] == null ? null : json["address"];
    marriedStatus = json['married_status'] == null ? null : json["married_status"];
    cityId = json['city_id'] == null ? null : json["city_id"];
    stateId = json['state_id'] == null ? null : json["state_id"];
    countryId = json['country_id'] == null ? null : json["country_id"];
    gender = json['gender'] == null ? null : json["gender"];
    pinCode = json['pin_code'] == null ? null : json["pin_code"];
    status = json['status'] == null ? null : json["status"];
    verified = json['verified'] == null ? null : json["verified"];
    userImg = json['user_img'] == null ? null : json["user_img"];
    role = json['role'];
    emailVerifiedAt = json["email_verified_at"] == null
        ? null
        : DateTime.parse(json["email_verified_at"]);
    detail = json['detail']== null ? null : json["detail"];
    braintreeId = json['braintree_id'] == null ? null : json["braintree_id"];
    fbUrl = json['fb_url'] == null ? null : json["fb_url"];
    twitterUrl = json['twitter_url']== null ? null : json["twitter_url"];
    youtubeUrl = json['youtube_url']== null ? null : json["youtube_url"];
    linkedinUrl = json['linkedin_url'] == null ? null : json["linkedin_url"];
    preferPayMethod = json['prefer_pay_method']  == null ? null : json["prefer_pay_method"];
    paypalEmail = json['paypal_email'];
    paytmMobile = json['paytm_mobile'];
    bankAccName = json['bank_acc_name'];
    bankAccNo = json['bank_acc_no'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    facebookId = json['facebook_id'];
    googleId = json['google_id'];
    amazonId = json['amazon_id'];
    createdAt = json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"])  ;
    updatedAt = json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]);
    zoomEmail = json['zoom_email']== null ? '' : json["zoom_email"];
    jwtToken = json['jwt_token']== null ? '' : json["jwt_token"];
    gitlabId = json['gitlab_id'];
    linkedinId = json['linkedin_id'];
    twitterId = json['twitter_id'];
    code = json['code'];
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
    data['braintree_id'] = this.braintreeId;
    data['fb_url'] = this.fbUrl;
    data['twitter_url'] = this.twitterUrl;
    data['youtube_url'] = this.youtubeUrl;
    data['linkedin_url'] = this.linkedinUrl;
    data['prefer_pay_method'] = this.preferPayMethod;
    data['paypal_email'] = this.paypalEmail;
    data['paytm_mobile'] = this.paytmMobile;
    data['bank_acc_name'] = this.bankAccName;
    data['bank_acc_no'] = this.bankAccNo;
    data['ifsc_code'] = this.ifscCode;
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

    return data;
  }
}

class Chapter {
  int? id;
  String? courseId;
  String? chapterName;
  dynamic shortNumber;
  String? status;
  dynamic file;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic userId;
  dynamic position;
  String? dripType;
  String? dripDate;
  String? dripDays;

  Chapter(
      {this.id,
        this.courseId,
        this.chapterName,
        this.shortNumber,
        this.status,
        this.file,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.position,
        this.dripType,
        this.dripDate,
        this.dripDays,
      });

  Chapter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    chapterName = json['chapter_name'];
    shortNumber = json['short_number'];
    status = json['status'];
    file = json['file'];
    createdAt = json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]);
    updatedAt = json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]);
    userId = json['user_id'];
    position = json['position'];
    dripType = json['drip_type'] ?? '';
    dripDate = json['drip_date'] ?? '';
    dripDays = json['drip_days'] ?? '';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['chapter_name'] = this.chapterName;
    data['short_number'] = this.shortNumber;
    data['status'] = this.status;
    data['file'] = this.file;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['position'] = this.position;
    data['drip_type'] = this.dripType;
    data['drip_date'] = this.dripDate;
    data['drip_days'] = this.dripDays;
   // data['goal_date'] = this.goalDate;
    /*if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class Courseclass {
  int? id;
  String? courseId;
  String? coursechapterId;
  String? title;
  String? image;
  dynamic zip;
  String? pdf;
  dynamic audio;
  String? size;
  String? url;
  dynamic iframeUrl;
  String? video;
  String? duration;
  String? status;
  String? featured;
  String? type;
  dynamic previewVideo;
  String? previewUrl;
  PreviewType? previewType;
  DateTime? dateTime;
  String? detail;
  dynamic position;
  String? awsUpload;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic userId;
  dynamic file;
  String? user;
  String? dripType;
  String? dripDate;
  String? dripDays;

  Courseclass(
      {this.id,
        this.courseId,
        this.coursechapterId,
        this.title,
        this.image,
        this.zip,
        this.pdf,
        this.audio,
        this.size,
        this.url,
        this.iframeUrl,
        this.video,
        this.duration,
        this.status,
        this.featured,
        this.type,
        this.previewVideo,
        this.previewUrl,
        this.previewType,
        this.dateTime,
        this.detail,
        this.position,
        this.awsUpload,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.file,
        this.dripType,
        this.dripDate,
        this.dripDays,
        this.user});

  Courseclass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    coursechapterId = json['coursechapter_id'];
      title = json['title'];
    image = json['image']  ?? '';
    zip = json['zip'];
    pdf = json['pdf'] ?? '';
    audio = json['audio'];
    size = json['size'] ?? '';
    url = json['url'] ?? '';
    iframeUrl = json['iframe_url'];
    video = json['video'] ?? '';
    duration = json['duration'] ?? '';
    status = json['status'] ?? '';
    featured = json['featured'] ?? '';
    type = json['type'] ?? '';
     previewVideo = json['preview_video'];
    previewUrl = json['preview_url'] ?? '';
    previewType = json['preview_type'].runtimeType == String ? null: json['preview_type'] ;
     dateTime = json['date_time'] == null ? null : json['date_time'].runtimeType == DateTime  ? json['date_time'] : DateTime.parse(json['date_time']) ;
     detail = json['detail'] ?? '';
     position = json['position'];
      awsUpload = json['aws_upload'] ?? '';
     createdAt = json['created_at']== null ? null :json['created_at'].runtimeType == DateTime  ? json['created_at'] : DateTime.parse(json['created_at']) ;
     updatedAt = json['updated_at']== null ? null :json['updated_at'].runtimeType == DateTime  ? json['updated_at'] : DateTime.parse(json['updated_at']) ;
    userId = json['user_id'];
    file = json['file'];
    dripType = json['drip_type'] == '' ? null : json['drip_type'];
    dripDate = json['drip_date']== '' ? null : json['drip_date'];
    dripDays = json['drip_days']== '' ? null : json['drip_days'];
    user ='Instructor';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['coursechapter_id'] = this.coursechapterId;
    data['title'] = this.title;
    data['image'] = this.image;
    data['zip'] = this.zip;
    data['pdf'] = this.pdf;
    data['audio'] = this.audio;
    data['size'] = this.size;
    data['url'] = this.url;
    data['iframe_url'] = this.iframeUrl;
    data['video'] = this.video;
    data['duration'] = this.duration;
    data['status'] = this.status;
    data['featured'] = this.featured;
    data['type'] = this.type;
    data['preview_video'] = this.previewVideo;
    data['preview_url'] = this.previewUrl;
    data['preview_type'] = this.previewType;
    data['date_time'] = this.dateTime;
    data['detail'] = this.detail;
    data['position'] = this.position;
    data['aws_upload'] = this.awsUpload;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['file'] = this.file;
    data['drip_type'] = this.dripType;
    data['drip_date'] = this.dripDate;
    data['drip_days'] = this.dripDays;
    /*if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}


enum PreviewType { URL }

class Policy {
  int? id;
  String? name;
  dynamic amount;
  String? days;
  String? detail;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Policy({this.id,
    this.name,
    this.amount,
    this.days,
    this.detail,
    this.status,
    this.createdAt,
    this.updatedAt,});

  Policy.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    detail = json['detail'];
    id = json["id"];
    amount = json["amount"];
    days = json["days"];
    status = json["status"];
    createdAt = json["created_at"] == null ? null :  DateTime.parse(json["created_at"]);
    updatedAt = json["updated_at"] == null ? null :  DateTime.parse(json["updated_at"]);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['detail'] = this.detail;
    return data;
  }
}
