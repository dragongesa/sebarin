import 'package:get/get.dart';
import 'package:sebarin/pages/attendpage/controller/present_list_controller.dart';

class PresentListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PresentListController());
  }
}
