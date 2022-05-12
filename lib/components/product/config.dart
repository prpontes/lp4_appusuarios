import 'package:flutter/cupertino.dart';

class ThemeChanger extends ChangeNotifier {
  bool _darkStatus = false;

  bool get isDark => _darkStatus;

  setDarkStatus(bool status) {
    _darkStatus = status;

    notifyListeners();
  }
}
