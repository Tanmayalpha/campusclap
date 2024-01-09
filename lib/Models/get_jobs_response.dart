import 'package:campusclap/Models/view_job_response.dart';

class GetJobsResponse {
  bool? status;
  String? message;
  List<ViewJobData>? data;

  GetJobsResponse({this.status, this.message, this.data});

  GetJobsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ViewJobData>[];
      json['data'].forEach((v) {
        data!.add(new ViewJobData.fromJson(v));
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

