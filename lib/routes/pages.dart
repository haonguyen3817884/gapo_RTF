import 'package:get/get.dart';
import "package:gapo_rtf/routes/router_name.dart";
import "package:gapo_rtf/screens/mainScreen/main_screen.dart";

class Pages {
  static List<GetPage> pages = <GetPage>[
    GetPage(
        name: RouterName.mainScreen,
        page: () => const MainScreen(),
        binding: MainScreenBinding())
  ];
}
