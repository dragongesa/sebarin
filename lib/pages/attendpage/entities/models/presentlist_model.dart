// To parse this JSON data, do
//
//     final attendeList = attendeListFromJson(jsonString);

import 'dart:convert';

AttendeList attendeListFromJson(String str) =>
    AttendeList.fromJson(json.decode(str));

String attendeListToJson(AttendeList data) => json.encode(data.toJson());

class AttendeList {
  AttendeList({
    required this.status,
    required this.event,
    required this.attendees,
  });

  final int status;
  final Event event;
  final List<Attendee> attendees;

  factory AttendeList.fromJson(Map<String, dynamic> json) => AttendeList(
        status: json["status"],
        event: Event.fromJson(json["event"]),
        attendees: List<Attendee>.from(
            json["attendees"].map((x) => Attendee.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event.toJson(),
        "attendees": List<dynamic>.from(attendees.map((x) => x.toJson())),
      };
}

class Attendee {
  Attendee({
    required this.id,
    required this.name,
    this.photo,
  });

  final int id;
  final String name;
  final String? photo;

  factory Attendee.fromJson(Map<String, dynamic> json) => Attendee(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
      };
}

class Event {
  Event({
    required this.eventId,
    required this.title,
    required this.thumbnail,
  });

  final int eventId;
  final String title;
  final String thumbnail;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        eventId: json["event_id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "title": title,
        "thumbnail": thumbnail,
      };
}
