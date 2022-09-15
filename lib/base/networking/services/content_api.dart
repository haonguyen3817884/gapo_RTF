import "package:gapo_rtf/base/networking/base/document_loader.dart";

import "package:gapo_rtf/config/constants.dart";

class ContentApi {
  final DocumentLoader _documentLoader = DocumentLoader();

  Future<String> getContent() async {
    try {
      return await _documentLoader.loadData(Constants.contentAddress);
    } catch (e) {
      rethrow;
    }
  }
}
