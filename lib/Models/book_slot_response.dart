class BookSlotResponse {
  bool? status;
  String? message;
  List<SlotData>? data;

  BookSlotResponse({this.status, this.message, this.data});

  BookSlotResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SlotData>[];
      json['data'].forEach((v) {
        data!.add(new SlotData.fromJson(v));
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

class SlotData {
  String? fromTime;
  String? toTime;
  String? id;
  bool? isSelected;

  SlotData({this.fromTime, this.toTime, this.isSelected});

  SlotData.fromJson(Map<String, dynamic> json) {
    fromTime = json['from_time'];
    toTime = json['to_time'];
    id = json['id'].toString();
    isSelected = false ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    return data;
  }
}
