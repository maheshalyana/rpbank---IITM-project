import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/commands_model.dart';
import '../models/language_model.dart';

class CommandsProvider extends ChangeNotifier {
  // ignore: deprecated_member_use
  late CommandsModel languageData = CommandsModel();

  CommandsModel get lData {
    return languageData;
  }

  Future<void> getProductList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String language = prefs.getString("language")!;
    print(language);
    CommandsModel? repo;

    String setWish() {
      return 'Good Morning';
    }

    languageData = repo!;
    notifyListeners();
  }
}
