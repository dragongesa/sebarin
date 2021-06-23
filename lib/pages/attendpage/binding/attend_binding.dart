import 'package:get/get.dart';
import 'package:sebarin/pages/attendpage/controller/attend_controller.dart';

class AttendBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AttendController());
  }

}