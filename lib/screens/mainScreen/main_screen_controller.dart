import "package:gapo_rtf/base/controller/base_controller.dart";
import "package:gapo_rtf/base/networking/services/content_api.dart";
import 'package:get/get.dart';

import 'package:markdown/markdown.dart' as md;

class MainScreenController extends BaseController {
  final ContentApi _contentApi = ContentApi();

  RxString contentData = "".obs;
  List<String> contentArr = <String>[].obs;

  void updateContentData(String content) {
    contentData.value = content;
  }

  String replaceText(String text, RegExp regExp,
      String Function(String matchedText) getUpdatedText) {
    String updatedText = "";

    int startIndex = 0;

    while (regExp.hasMatch(text.substring(startIndex))) {
      String customerText = text.substring(startIndex);

      bool isCorrect = false;

      regExp.allMatches(customerText).forEach((RegExpMatch regExpMatch) {
        if (!isCorrect) {
          if (regExpMatch.start == 0) {
            if (regExpMatch.end == customerText.length) {
              isCorrect = true;
            } else {
              if (customerText[regExpMatch.end + 1] == " " ||
                  customerText[regExpMatch.end + 1] == "\n") {
                isCorrect = true;
              }
            }
          } else {
            if (regExpMatch.end == customerText.length) {
              if (customerText[regExpMatch.start - 1] == " " ||
                  customerText[regExpMatch.start - 1] == "\n") {
                isCorrect = true;
              }
            } else {
              if (customerText[regExpMatch.start - 1] == " " ||
                  customerText[regExpMatch.start - 1] == "\n") {
                if (customerText[regExpMatch.end + 1] == " " ||
                    customerText[regExpMatch.end + 1] == "\n") {
                  isCorrect = true;
                }
              }
            }
          }

          if (isCorrect) {
            updatedText = updatedText +
                customerText.substring(0, regExpMatch.start) +
                getUpdatedText(regExpMatch[0]!);

            startIndex = startIndex + regExpMatch.end;
          }
        }
      });

      if (!isCorrect) {
        break;
      }
    }

    updatedText = updatedText + text.substring(startIndex);

    return updatedText;
  }

  String getEmailText(String matchedText) {
    String emailText = "";

    emailText = "<$matchedText>";

    return emailText;
  }

  String getPhoneText(String matchedText) {
    String phoneText = "";
    phoneText =
        "[$matchedText](tel:+${matchedText.replaceAll('.', '').replaceAll(' ', '')})";

    return phoneText;
  }

  Future<void> getContent() async {
    try {
      String content = await _contentApi.getContent();
      content = replaceText(
          content,
          RegExp(r"[a-zA-Z0-9\.\_]+\@[a-zA-Z]+(\.[a-zA-Z]+){1,2}"),
          getEmailText);

      content = replaceText(content,
          RegExp(r"[0-9]((\s{0,1}[0-9]){9}|(\.{0,1}[0-9]){9})"), getPhoneText);

      updateContentData(content);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onReady() async {
    super.onReady();

    await getContent();
  }
}
