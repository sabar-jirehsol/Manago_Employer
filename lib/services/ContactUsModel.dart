


import 'dart:convert';

ContactUsModel contactUsModelFromJson(String str)=>
    ContactUsModel.fromJson(json.decode(str));


String contactUsModelToJson(ContactUsModel data)=>
    json.encode(data.toJson());



class ContactUsModel {
  ContactUsModel({
    this.message,
    this.data,

  });

  String? message;
  Data? data;


  factory ContactUsModel.fromJson(Map<String, dynamic> json)=>
      ContactUsModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "message": message,
        "data": data,
      };

}
class Data{
  Data({
    this.name,
   this.email,
  this.context,
  });


  String? name;
  String? email;
  String? context;



  factory Data.fromJson(Map<String, dynamic> json)=> Data(
    name:json["name"],
    email:json["email"],
    context:json["context"]
  );

Map<String,dynamic> toJson()=>{

  "name":name,
  "email":email,
  "context":context,

  };


}










