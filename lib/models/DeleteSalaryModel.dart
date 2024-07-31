// // To parse this JSON data, do
// //
// //     final updateSalaryModel = updateSalaryModelFromJson(jsonString);
//
// import 'dart:convert';
//
//
//
// DeleteSalaryModel deleteSalaryModelFromJson(String str)=>
//     DeleteSalaryModel.fromJson(json.decode(str));
//
//
// String  deleteSalaryModelToJson(DeleteSalaryModel data)=>
//     json.encode(data.toJson());
//
//
// class DeleteSalaryModel {
//   DeleteSalaryModel({
//     this.message,
//     this.data,
//   });
//
//   String? message;
//   Data? data;
//
//   factory DeleteSalaryModel.fromJson(Map<String, dynamic> json)=>
//       DeleteSalaryModel(
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() =>
//       {
//         "message": message,
//         "data": data,
//       };
//
// }
//  class Data{
//     Data({
//   this.ok,
//   this.nModified,
//   this.n,
//   });
//   }
//   int? ok;
//   int? nModified;
//   int? n;
//
//   factory Data.fromJson(Map<String, dynamic> json)=>Data(
//   ok:json["ok"],
//   nModified:json["nModified"],
//   n:json["n"],
//   );
//
//   Map<String,dynamic> toJson()=>{
//     "ok":ok,
//   "nModified":nModified,
//   "n":n,
//   };
//
// }