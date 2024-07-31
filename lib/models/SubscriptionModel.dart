import 'dart:convert';

SubscriptionModel subscriptionModelFromJson(String str) =>
    SubscriptionModel.fromJson(json.decode(str));

String subscriptionModelToJson(SubscriptionModel data) =>
    json.encode(data.toJson());

class SubscriptionModel {
  String? message;
  List<SubscriptionDetails>? data;

  SubscriptionModel({
    this.message,
    this.data,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        message: json["message"],
        data: json["data"] != null
            ? List<SubscriptionDetails>.from(
            json["data"].map((x) => SubscriptionDetails.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SubscriptionDetails {
  String? planName;
  String? offerMessage;
  String? planDescription;
  String? amountPerUnit;
  String? billingCycle;
  int? totalCount;
  String? offerId;
  String? status;
  String? createdAt;
  String? modifiedAt;
  String? id;
  String? planId;
  int? v;
  List<Subscription>? subscriptions;
  List<Plan>? plans;

  SubscriptionDetails({
    this.planName,
    this.offerMessage,
    this.planDescription,
    this.amountPerUnit,
    this.billingCycle,
    this.totalCount,
    this.offerId,
    this.status,
    this.createdAt,
    this.modifiedAt,
    this.id,
    this.planId,
    this.v,
    this.subscriptions,
    this.plans,
  });

  factory SubscriptionDetails.fromJson(Map<String, dynamic> json) =>
      SubscriptionDetails(
        planName: json["planName"],
        offerMessage: json["offerMessage"],
        planDescription: json["planDescription"],
        amountPerUnit: json["amountPerUnit"],
        billingCycle: json["billingCycle"],
        totalCount: json["totalCount"],
        offerId: json["offerId"],
        status: json["status"],
        createdAt: json["createdAt"],
        modifiedAt: json["modifiedAt"],
        id: json["_id"],
        planId: json["planId"],
        v: json["__v"],
        subscriptions: json["subscriptions"] != null
            ? List<Subscription>.from(
            json["subscriptions"].map((x) => Subscription.fromJson(x)))
            : [],
        plans: json["plans"] != null
            ? List<Plan>.from(json["plans"].map((x) => Plan.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
    "planName": planName,
    "offerMessage": offerMessage,
    "planDescription": planDescription,
    "amountPerUnit": amountPerUnit,
    "billingCycle": billingCycle,
    "totalCount": totalCount,
    "offerId": offerId,
    "status": status,
    "createdAt": createdAt,
    "modifiedAt": modifiedAt,
    "_id": id,
    "planId": planId,
    "__v": v,
    "subscriptions": List<dynamic>.from(subscriptions!.map((x) => x.toJson())),
    "plans": List<dynamic>.from(plans!.map((x) => x.toJson())),
  };
}

class Plan {
  String? amountPerUnit;
  String? planDescription;
  String? planName;
  String? message;
  String? planId;
  String? id;

  Plan({
    this.amountPerUnit,
    this.planDescription,
    this.planName,
    this.message,
    this.planId,
    this.id,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    amountPerUnit: json["amountPerUnit"],
    planDescription: json["planDescription"],
    planName: json["planName"],
    message: json["message"],
    planId: json["planId"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "amountPerUnit": amountPerUnit,
    "planDescription": planDescription,
    "planName": planName,
    "message": message,
    "planId": planId,
    "_id": id,
  };
}

class Subscription {
  String? planName;
  String? planId;
  String? subscriptionId;
  String? subscriptionLink;
  String? amount;
  String? message;
  String? subscriptionStatus;
  String? messageType;
  String? planDescription;
  String? headerLink;
  List<SubscriptionActionButton>? subscriptionActionButton;

  Subscription({
    this.planName,
    this.planId,
    this.subscriptionId,
    this.subscriptionLink,
    this.amount,
    this.message,
    this.subscriptionStatus,
    this.messageType,
    this.planDescription,
    this.headerLink,
    this.subscriptionActionButton,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
  headerLink: json["headerLink"],
  subscriptionActionButton: json["subscriptionActionButton"] != null
  ? List<SubscriptionActionButton>.from(json["subscriptionActionButton"]
      .map((x) => SubscriptionActionButton.fromJson(x)))
      : [],
  planName: json["planName"],
  messageType: json["messageType"],
  planId: json["planId"],
  subscriptionId: json["subscriptionId"],
  subscriptionLink: json["subscriptionLink"],
  amount: json["amount"],
  message: json["message"],
  subscriptionStatus: json["subscriptionStatus"],
  planDescription: json["        planDescription"],
  );

  Map<String, dynamic> toJson() => {
    "headerLink": headerLink,
    "subscriptionActionButton":
    List<dynamic>.from(subscriptionActionButton!.map((x) => x.toJson())),
    "planName": planName,
    "messageType": messageType,
    "planId": planId,
    "subscriptionId": subscriptionId,
    "subscriptionLink": subscriptionLink,
    "amount": amount,
    "message": message,
    "subscriptionStatus": subscriptionStatus,
    "planDescription": planDescription,
  };
}

class SubscriptionActionButton {
  String? label;
  String? url;
  String? api;

  SubscriptionActionButton({
    this.label,
    this.url,
    this.api,
  });

  factory SubscriptionActionButton.fromJson(Map<String, dynamic> json) =>
      SubscriptionActionButton(
        label: json["label"],
        url: json["url"],
        api: json["api"],
      );

  Map<String, dynamic> toJson() => {
    "label": label,
    "url": url,
    "api": api,
  };
}

