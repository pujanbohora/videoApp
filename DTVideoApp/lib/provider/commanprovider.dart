import 'package:flutter/material.dart';

class CommanProvider extends ChangeNotifier {
  int? isBookmark;

  init(int bookmark) {
    isBookmark = bookmark;
  }

  addbookmar(int bookmark) {
    isBookmark = bookmark;
    notifyListeners();
  }
}
