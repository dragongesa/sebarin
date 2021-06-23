import 'package:dio/dio.dart' as http;
import 'package:get/get.dart';
import 'package:sebarin/pages/savedpage/entities/repositories/event_repository.dart';
import 'package:sebarin/shared/function/picker_function.dart';
import 'package:sebarin/shared/models/events.dart';

class SavedController extends GetxController {
  RxList saved = <dynamic>[].obs;
  RxList eventsId = [].obs;
  final length = 0.obs;
  @override
  void onInit() {
    getSavedEvent();
    super.onInit();
  }

  deleteSavedEventById(int id) async {
    await Picker.deleteLocalEventById(id);
    getSavedEvent();
  }

  getSavedEvent() async {
    List<Map<String, dynamic>> events = await Picker.getLocalEvent();
    saved.value = List.filled(events.length, null);
    eventsId.value = List.filled(events.length, null);

    print(saved);
    length.value = events.length;
    for (Map<String, dynamic> event in events) {
      http.Response response =
          await EventRequest.getEventById(event['event_id']);
      if (response.data['status'] == 200) {
        Event e = Event.fromJson(response.data['data']);
        saved[events.indexOf(event)] = e;
        eventsId[events.indexOf(event)] = event['key'];
        update(['item']);
      } else {
        saved[events.indexOf(event)] = event['key'];
      }
      print(saved);
    }
  }
}
