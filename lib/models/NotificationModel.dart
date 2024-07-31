// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

NotificationData notificationModelFromJson(String str) =>
    NotificationData.fromJson(json.decode(str));

String loginModelToJson(NotificationData data) => json.encode(data.toJson());

class NotificationData {
  NotificationData({
    this.message,
    this.data,
  });

  String? message;
  Data? data;

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}

class Data {
  Data({

    this.notify
  });

  List<Notifications>? notify;
  factory Data.fromJson(Map<String, dynamic> json) => Data(
      notify:List<Notifications>.from(json["notification"].map((x) =>Notifications.fromJson(x)))
  );
}
class Notifications {
  Notifications({
    this.message,
    this.newdata,
    this.date
  });

  String? message;
  String? date;
  int? newdata;

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
    message: json["message"],
    newdata: json["isNew"],
    date: json['date']

  );

}





  
  

