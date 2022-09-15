import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:gapo_rtf/screens/mainScreen/main_screen_controller.dart";
import 'package:markdown/markdown.dart' as md;
import 'package:markdown_widget/config/widget_config.dart';
import 'package:markdown_widget/markdown_helper.dart';
import 'package:markdown_widget/markdown_widget.dart';
import "package:gapo_rtf/widgets/content_text.dart";

class MainScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainScreenController());
  }
}

class MainScreen extends GetView<MainScreenController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("place")),
        body: Center(child: Container(child: Obx(() {
          return (controller.contentData.value != "")
              ? ContentText(
                  content: controller.contentData.value, lineNumber: 5)
              : CircularProgressIndicator();
        }))));
  }
}
