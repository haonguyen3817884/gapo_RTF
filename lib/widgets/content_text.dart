import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class ContentText extends StatefulWidget {
  const ContentText({Key? key, required this.content, required this.lineNumber})
      : super(key: key);

  final String content;
  final int lineNumber;

  @override
  State<ContentText> createState() => _ContentTextState();
}

class _ContentTextState extends State<ContentText> {
  int _lineNumber = 0;

  @override
  void initState() {
    super.initState();
    _lineNumber = widget.lineNumber;
  }

  bool isLineNumberValid() {
    int count = 0;
    count = widget.content.split("\n").length;

    return count > widget.lineNumber;
  }

  String getTextByLineNumber(int num) {
    String updatedText = "";
    List<String> contentArr = <String>[];

    contentArr = widget.content.split("\n");

    for (int i = 0; i < contentArr.length; ++i) {
      if (i < num) {
        updatedText = "$updatedText${contentArr[i]}\n";
      }
    }

    if (num == contentArr.length) {
      updatedText = "$updatedText\n\n\n[hide](button:hide)";
    } else {
      updatedText = "$updatedText\n\n\n[full](button:full)";
    }

    return updatedText;
  }

  void onButtonClicked(url) {
    RegExp regExp = RegExp(r"^button:[a-zA-Z]+$");

    if (regExp.firstMatch(url!)![0]!.replaceAll("button:", "") == "full") {
      setState(() {
        _lineNumber = widget.content.split("\n").length;
      });
    } else if (regExp.firstMatch(url)![0]!.replaceAll("button:", "") ==
        "hide") {
      setState(() {
        _lineNumber = widget.lineNumber;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: MarkdownWidget(
            data: (isLineNumberValid())
                ? getTextByLineNumber(_lineNumber)
                : widget.content,
            styleConfig:
                StyleConfig(pConfig: PConfig(onLinkTap: onButtonClicked))));
  }
}
