import 'package:get/get.dart';
import 'package:sebarin/pages/settingpage/controller/setting_controller.dart';

class SettingBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SettingController());
  }


}