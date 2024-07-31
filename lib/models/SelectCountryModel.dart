import 'dart:convert';

  StateCountryModel stateCountryModelFromJson(String str) =>
    StateCountryModel.fromJson(json.decode(str));

String stateCountryModelToJson(StateCountryModel data) => json.encode(data.toJson());

class StateCountryModel {
  String message;
  List<String> data;

  StateCountryModel({
    required this.message,
    required this.data,
  });

  factory StateCountryModel.fromJson(Map<String, dynamic> json) {
    return StateCountryModel(
      message: json['message'],
      data: List<String>.from(json['data'].map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': List<dynamic>.from(data.map((x) => x)),
    };
  }
}
