class ViewJobDetailResponse {
  bool? status;
  String? message;
  ViewJobData? data;

  ViewJobDetailResponse({this.status, this.message, this.data});

  ViewJobDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  ViewJobData.fromJson(json['data']) : null;
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

class ViewJobData {
  int? id;
  int? userId;
  int? jobId;
  String? jobStatus;
  String? companyname;
  String? title;
  String? description;
  String? minExperience;
  String? maxExperience;
  String? experience;
  String? years;
  String? jobOfferExpireDate;
  String? location;
  String? requirement;
  String? role;
  String? industryType;
  String? employmentType;
  String? image;
  String? minSalary;
  String? maxSalary;
  String? salary;
  String? skills;
  String? pdf;
  String? message;
  String? varified;
  String? status;
  dynamic approved;
  String? createdAt;
  String? updatedAt;
  String? jobType;
  String? jobDuration;
  int? tenthPercent;
  dynamic markFormat10;
  int? twelthPercent;
  dynamic markFormat12;
  String? ugStatus;
  String? ugAggregate;
  dynamic markFormatUG;
  String? pgStatus;
  String? pgAggregate;
  String? ugYearOfPassing;
  String? pgYearOfPassing;
  dynamic markFormatPG;
  String? lastDate;
  String? ugCourse;
  String? ugSpecialization;
  String? pgCourse;
  String? pgSpecialization;
  String? languageId;
  String? interviewRounds;
  String? gender;
  List<JobRounds>? jobRounds;
  List<JobRoundsStatus>? jobRoundsStatus;

  ViewJobData(
      {this.id,
        this.userId,
        this.companyname,
        this.title,
        this.description,
        this.minExperience,
        this.maxExperience,
        this.experience,
        this.years,
        this.location,
        this.requirement,
        this.role,
        this.industryType,
        this.employmentType,
        this.image,
        this.minSalary,
        this.maxSalary,
        this.salary,
        this.skills,
        this.pdf,
        this.message,
        this.varified,
        this.status,
        this.approved,
        this.createdAt,
        this.updatedAt,
        this.jobType,
        this.jobDuration,
        this.tenthPercent,
        this.markFormat10,
        this.twelthPercent,
        this.markFormat12,
        this.ugStatus,
        this.ugAggregate,
        this.markFormatUG,
        this.pgStatus,
        this.pgAggregate,
        this.ugYearOfPassing,
        this.pgYearOfPassing,
        this.markFormatPG,
        this.lastDate,
        this.ugCourse,
        this.ugSpecialization,
        this.pgCourse,
        this.pgSpecialization,
        this.languageId,
        this.interviewRounds,
        this.jobId,
        this.jobStatus,
        this.jobOfferExpireDate,
        this.gender,this.jobRounds,
        this.jobRoundsStatus});

  ViewJobData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobStatus = json['job_status'].toString();
    jobId = json['job_id'];
    jobOfferExpireDate = json['job_offer_expire_date'];
    userId = json['user_id'];
    companyname = json['companyname'];
    title = json['title'];
    description = json['description'];
    minExperience = json['min_experience'];
    maxExperience = json['max_experience'];
    experience = json['experience'];
    years = json['years'];
    location = json['location'];
    requirement = json['requirement'];
    role = json['role'];
    industryType = json['industry_type'];
    employmentType = json['employment_type'];
    image = json['image'];
    minSalary = json['min_salary'];
    maxSalary = json['max_salary'];
    salary = json['salary'];
    skills = json['skills'];
    pdf = json['pdf'];
    message = json['message'];
    varified = json['varified'];
    status = json['status'];
    approved = json['approved'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    jobType = json['job_type'];
    jobDuration = json['job_duration'];
    tenthPercent = json['tenth_percent'];
    markFormat10 = json['mark_format10'];
    twelthPercent = json['twelth_percent'];
    markFormat12 = json['mark_format12'];
    ugStatus = json['ug_status'];
    ugAggregate = json['ug_aggregate'];
    markFormatUG = json['mark_format_UG'];
    pgStatus = json['pg_status'];
    pgAggregate = json['pg_aggregate'];
    ugYearOfPassing = json['ug_year_of_passing'];
    pgYearOfPassing = json['pg_year_of_passing'];
    markFormatPG = json['mark_format_PG'];
    lastDate = json['last_date'];
    ugCourse = json['ug_course'];
    ugSpecialization = json['ug_specialization'];
    pgCourse = json['pg_course'];
    pgSpecialization = json['pg_specialization'];
    languageId = json['language_id'];
    interviewRounds = json['interview_rounds'];
    gender = json['gender'];
    if (json['job_rounds'] != null) {
      jobRounds = <JobRounds>[];
      json['job_rounds'].forEach((v) {
        jobRounds!.add( JobRounds.fromJson(v));
      });
    }
    if (json['job_rounds_status'] != null) {
      jobRoundsStatus = <JobRoundsStatus>[];
      json['job_rounds_status'].forEach((v) {
        jobRoundsStatus!.add( JobRoundsStatus.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['companyname'] = companyname;
    data['title'] = title;
    data['description'] = description;
    data['min_experience'] = minExperience;
    data['max_experience'] = maxExperience;
    data['experience'] = experience;
    data['years'] = years;
    data['location'] = location;
    data['requirement'] = requirement;
    data['role'] = role;
    data['industry_type'] = industryType;
    data['employment_type'] = employmentType;
    data['image'] = image;
    data['min_salary'] = minSalary;
    data['max_salary'] = maxSalary;
    data['salary'] = salary;
    data['skills'] = skills;
    data['pdf'] = pdf;
    data['message'] = message;
    data['varified'] = varified;
    data['status'] = status;
    data['approved'] = approved;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['job_type'] = jobType;
    data['job_duration'] = jobDuration;
    data['tenth_percent'] = tenthPercent;
    data['mark_format10'] = markFormat10;
    data['twelth_percent'] = twelthPercent;
    data['mark_format12'] = markFormat12;
    data['ug_status'] = ugStatus;
    data['ug_aggregate'] = ugAggregate;
    data['mark_format_UG'] = markFormatUG;
    data['pg_status'] = pgStatus;
    data['pg_aggregate'] = pgAggregate;
    data['ug_year_of_passing'] = ugYearOfPassing;
    data['pg_year_of_passing'] = pgYearOfPassing;
    data['mark_format_PG'] = markFormatPG;
    data['last_date'] = lastDate;
    data['ug_course'] = ugCourse;
    data['ug_specialization'] = ugSpecialization;
    data['pg_course'] = pgCourse;
    data['pg_specialization'] = pgSpecialization;
    data['language_id'] = languageId;
    data['interview_rounds'] = interviewRounds;
    data['gender'] = gender;
    return data;
  }


}
class JobRounds {
  String? roundTitle;
  String? roundDescription;

  JobRounds({this.roundTitle, this.roundDescription});

  JobRounds.fromJson(Map<String, dynamic> json) {
    roundTitle = json['round_title'];
    roundDescription = json['round_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['round_title'] = this.roundTitle;
    data['round_description'] = this.roundDescription;
    return data;
  }
}

class JobRoundsStatus {
  int? id;
  int? status;
  String? roundTitle;
  String? roundDescription;

  JobRoundsStatus(
      {this.id, this.status, this.roundTitle, this.roundDescription});

  JobRoundsStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    roundTitle = json['round_title'];
    roundDescription = json['round_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['round_title'] = this.roundTitle;
    data['round_description'] = this.roundDescription;
    return data;
  }
}