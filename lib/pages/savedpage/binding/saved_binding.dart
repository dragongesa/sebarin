import 'package:get/get.dart';
import 'package:sebarin/pages/savedpage/controller/saved_controller.dart';

class SavedBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SavedController());
  }

}