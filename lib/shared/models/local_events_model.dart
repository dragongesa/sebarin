import 'package:hive/hive.dart';

part 'local_events_model.g.dart';

@HiveType(typeId: 0)
class LocalEvent {
  @HiveField(0)
  int? userId;
  @HiveField(1)
  int? eventId;

  LocalEvent([this.userId, this.eventId]);
}
