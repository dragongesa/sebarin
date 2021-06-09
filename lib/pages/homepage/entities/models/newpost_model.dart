// To parse this JSON data, do
//
//     final newPostModel = newPostModelFromJson(jsonString);

import 'dart:convert';

import 'package:sebarin/shared/models/events.dart';

NewPostModel newPostModelFromJson(String str) =>
    NewPostModel.fromJson(json.decode(str));

String newPostModelToJson(NewPostModel data) => json.encode(data.toJson());

class NewPostModel {
  NewPostModel({
    required this.status,
    required this.currentPage,
    required this.nextPage,
    required this.totalPages,
    required this.data,
  });

  final int status;
  final int currentPage;
  final int nextPage;
  final int totalPages;
  final List<Event> data;

  factory NewPostModel.fromJson(Map<String, dynamic> json) => NewPostModel(
        status: json["status"],
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        totalPages: json["totalPages"],
        data: List<Event>.from(json["data"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "currentPage": currentPage,
        "nextPage": nextPage,
        "totalPages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
