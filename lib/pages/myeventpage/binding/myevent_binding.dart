import 'package:get/get.dart';
import 'package:sebarin/pages/myeventpage/controller/myevent_controller.dart';

class MyEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyEventController());
  }
}
