import 'package:get/get.dart';
import 'package:sebarin/utils/themes.dart';

class ThemeController extends GetxService {
  final isDarkMode = false.obs;
  void changeTheme(bool val) {
    print("pressed $val");
    print("is dark mode: ${Get.isDarkMode}");
    Get.changeTheme(isDarkMode.value ? lightTheme : darkTheme);
    isDarkMode.toggle();
    print("is dark mode: ${Get.isDarkMode}");
  }
}
