class Event {
  Event({
    required this.id,
    required this.title,
    required this.shortDesc,
    required this.description,
    required this.thumbnail,
    required this.moderator,
    required this.narasumber,
    required this.uploadedBy,
    required this.category,
    required this.jadwal,
    required this.createdAt,
  });

  final int id;
  final String title;
  final String shortDesc;
  final String description;
  final String thumbnail;
  final String moderator;
  final String narasumber;
  final UploadedBy uploadedBy;
  final Category category;
  final Jadwal jadwal;
  final int createdAt;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        title: json["title"],
        shortDesc: json["short_desc"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        moderator: json["moderator"].toString(),
        narasumber: json["narasumber"],
        uploadedBy: UploadedBy.fromJson(json["uploadedBy"]),
        category: Category.fromJson(json["category"]),
        jadwal: Jadwal.fromJson(json["jadwal"]),
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "short_desc": shortDesc,
        "description": description,
        "thumbnail": thumbnail,
        "moderator": moderator,
        "narasumber": narasumber,
        "uploadedBy": uploadedBy.toJson(),
        "category": category.toJson(),
        "jadwal": jadwal.toJson(),
        "created_at": createdAt,
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Jadwal {
  Jadwal({
    required this.parsed,
    required this.timestamp,
  });

  final String parsed;
  final int timestamp;

  factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        parsed: json["parsed"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "parsed": parsed,
        "timestamp": timestamp,
      };
}

class UploadedBy {
  UploadedBy({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory UploadedBy.fromJson(Map<String, dynamic> json) => UploadedBy(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
