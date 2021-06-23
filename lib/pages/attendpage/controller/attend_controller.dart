import 'package:add_2_calendar/add_2_calendar.dart' as calendar;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sebarin/shared/models/events.dart';

class AttendController extends GetxController {
  Event event = Get.arguments['event'];
  @override
  void onInit() {
    print(event.title);
    print("Attended");
    super.onInit();
  }

  addToCalendar() async {
    calendar.Event item = calendar.Event(
      title: "Menghadiri ${event.title} di SEBARIN",
      startDate: DateTime.fromMillisecondsSinceEpoch(event.jadwal.timestamp)
          .subtract(15.minutes),
      endDate: DateTime.fromMillisecondsSinceEpoch(event.jadwal.timestamp)
          .add(1.hours),
      description:
          "Ngingetin waktunya ikut event ${event.title} yang ada di SEBARIN",
    );
    bool isSuccess = await calendar.Add2Calendar.addEvent2Cal(item);
    if (isSuccess) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
          msg: "Klik Aplikasi Kalendar dan Simpan di Jadwalmu");
    } else {
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: "Gagal nambahin pengingat, coba lagi.");
    }
  }
}
