import 'package:get/get.dart';

class BaseController extends GetxController {
  void goToPage(String pageName) {
    Get.offNamed(pageName);
  }
}
