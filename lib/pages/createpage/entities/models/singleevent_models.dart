// To parse this JSON data, do
//
//     final singleEventModel = singleEventModelFromJson(jsonString);

import 'dart:convert';

import 'package:sebarin/shared/models/events.dart';

SingleEventModel singleEventModelFromJson(String str) =>
    SingleEventModel.fromJson(json.decode(str));

String singleEventModelToJson(SingleEventModel data) =>
    json.encode(data.toJson());

class SingleEventModel {
  SingleEventModel({
    required this.status,
    required this.data,
  });

  final String status;
  final Event data;

  factory SingleEventModel.fromJson(Map<String, dynamic> json) =>
      SingleEventModel(
        status: json["status"],
        data: Event.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}
