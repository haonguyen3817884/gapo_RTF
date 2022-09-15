import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class DocumentLoader {
  Future<String> loadData(String address) async {
    return await rootBundle.loadString(address);
  }
}
