import 'course.dart';

class CoursesModel {
  CoursesModel({
    this.course,
  });

  List<CourseData>? course;

  factory CoursesModel.fromJson(Map<String, dynamic> json) => CoursesModel(
        course: json["course"] == null
            ? null
            : List<CourseData>.from(json["course"].map((x) => CourseData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "course": List<dynamic>.from(course!.map((x) => x.toJson())),
      };
}
