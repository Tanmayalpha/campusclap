class   GetAssessmentResponse {
  bool? status;
  String? message;
  AssessmentData? data;

  GetAssessmentResponse({this.status, this.message, this.data});

  GetAssessmentResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new AssessmentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AssessmentData {
  DetailsData? details;
  Bookedslotes? bookedslotes;

  AssessmentData({this.details, this.bookedslotes});

  AssessmentData.fromJson(Map<String, dynamic> json) {
    details =
    json['details'] != null ? new DetailsData.fromJson(json['details']) : null;
    bookedslotes = json['bookedslotes'] != null
        ? new Bookedslotes.fromJson(json['bookedslotes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    if (this.bookedslotes != null) {
      data['bookedslotes'] = this.bookedslotes!.toJson();
    }
    return data;
  }
}

class DetailsData {
  int? id;
  int? courseId;
  String? title;
  String? description;
  dynamic perQMark;
  int? marks;
  int? passingMarks;
  dynamic timer;
  int? status;
  int? showAns;
  int? quizAgain;
  dynamic dueDays;
  String? createdAt;
  String? updatedAt;
  dynamic type;
  dynamic position;
  String? coursename;

  DetailsData(
      {this.id,
        this.courseId,
        this.title,
        this.description,
        this.perQMark,
        this.marks,
        this.passingMarks,
        this.timer,
        this.status,
        this.showAns,
        this.quizAgain,
        this.dueDays,
        this.createdAt,
        this.updatedAt,
        this.type,
        this.position,
        this.coursename});

  DetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    title = json['title'];
    description = json['description'];
    perQMark = json['per_q_mark'];
    marks = json['marks'];
    passingMarks = json['passing_marks'];
    timer = json['timer'];
    status = json['status'];
    showAns = json['show_ans'];
    quizAgain = json['quiz_again'];
    dueDays = json['due_days'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    position = json['position'];
    coursename = json['coursename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_id'] = this.courseId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['per_q_mark'] = this.perQMark;
    data['marks'] = this.marks;
    data['passing_marks'] = this.passingMarks;
    data['timer'] = this.timer;
    data['status'] = this.status;
    data['show_ans'] = this.showAns;
    data['quiz_again'] = this.quizAgain;
    data['due_days'] = this.dueDays;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    data['position'] = this.position;
    data['coursename'] = this.coursename;
    return data;
  }
}

class Bookedslotes {
  int? id;
  int? slotId;
  int? courseId;
  int? userId;
  String? createdAt;
  String? date;
  String? fromTime;
  String? toTime;
  dynamic updatedAt;
  String? url;

  Bookedslotes(
      {this.id,
        this.slotId,
        this.courseId,
        this.userId,
        this.createdAt,
        this.updatedAt,this.date,this.fromTime,this.toTime,
        this.url});

  Bookedslotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slotId = json['slot_id'];
    courseId = json['course_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    date = json['date'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slot_id'] = this.slotId;
    data['course_id'] = this.courseId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['url'] = this.url;
    return data;
  }
}
