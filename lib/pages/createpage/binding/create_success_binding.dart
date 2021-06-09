import 'package:get/get.dart';

import '../controller/create_success_controller.dart';

class CreateSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateSuccessController());
  }
}
