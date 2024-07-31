class CommonLocationModel {
  List<LocationData>? value;

  CommonLocationModel({this.value});

  CommonLocationModel.fromJson(Map<String, dynamic> json) {
    if (json['values'] != null) {
      value = <LocationData>[];
      json['values'].forEach((v) {
        value!.add(LocationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (value != null) {
      data['values'] = value!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocationData {
  String? sId;
  String? country;
  List<States>? states;
  String? phoneCode;

  LocationData({this.sId, this.country, this.states});

  LocationData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    country = json['country'];
    phoneCode = json['phoneCode'];
    if (json['states'] != null) {
      states = <States>[];
      json['states'].forEach((v) {
        states!.add(States.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['country'] = country;
    data['phoneCode'] = phoneCode;
    if (states != null) {
      data['states'] = states!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class States {
  List<String>? cities;
  String? state;

  States({this.cities, this.state});

  States.fromJson(Map<String, dynamic> json) {
    cities = json['cities'].cast<String>();
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cities'] = cities;
    data['state'] = state;
    return data;
  }
}
