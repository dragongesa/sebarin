import 'package:get/get.dart';
import 'package:sebarin/pages/viewcontentpage/controller/viewcontent_controller.dart';

class ViewContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ViewContentController());
  }
}
