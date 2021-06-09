// To parse this JSON data, do
//
//     final searchResultModel = searchResultModelFromJson(jsonString);

import 'dart:convert';

import 'package:sebarin/shared/models/events.dart';

SearchResultModel searchResultModelFromJson(String str) =>
    SearchResultModel.fromJson(json.decode(str));

String searchResultModelToJson(SearchResultModel data) =>
    json.encode(data.toJson());

class SearchResultModel {
  SearchResultModel({
    required this.status,
    required this.data,
  });

  final String status;
  final List<Event> data;

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        status: json["status"],
        data: List<Event>.from(json["data"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
