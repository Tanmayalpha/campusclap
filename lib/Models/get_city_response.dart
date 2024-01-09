class GetStatesResponse {
  bool? status;
  List<StateData>? data;

  GetStatesResponse({this.status, this.data});

  GetStatesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <StateData>[];
      json['data'].forEach((v) {
        data!.add(new StateData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StateData {
  int? id;
  int? stateId;
  String? statenName;
  String? cityName;
  int? countryId;

  StateData({this.id, this.stateId, this.statenName, this.countryId, this.cityName});

  StateData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateId = json['state_id'];
    statenName = json['state'];
    cityName = json['district'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_id'] = this.stateId;
    data['name'] = this.statenName;
    data['country_id'] = this.countryId;
    return data;
  }
}
