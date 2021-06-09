import 'package:get/get.dart';
import 'package:sebarin/pages/homepage/controller/home_controller.dart';
import 'package:sebarin/shared/controller/theme_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(ThemeController());
  }
}
