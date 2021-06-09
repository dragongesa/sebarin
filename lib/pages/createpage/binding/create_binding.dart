import 'package:get/get.dart';
import 'package:sebarin/pages/createpage/controller/create_controller.dart';

class CreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateController());
  }
}
