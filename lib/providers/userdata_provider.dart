import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/network_services.dart';

class UserController extends ChangeNotifier {
  bool isLoading = false;
  List userdata = [];
  String nickName = '';
  String userName = '';
  String fullName = '';
  String phoneNumber = '';
  String pinNumber = '';
  String upiId = '';
  String currentBalance = '';
  List<Map<String, dynamic>> history = [];

  UserController() {
    // userdatafetch();
    // send(to: '', ammount: 0, from: '');
    // transactions();
  }

  Future<dynamic> transactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('transactions');
    String? name = prefs.getString("name");
    // name = name!.substring(1, name.length - 1);
    print(name);
    isLoading = true;
    notifyListeners();
    final response = await NetworkServices.history(name!);
    isLoading = false;
    notifyListeners();

    response.toString().split('}').map((e) {
      //  print("%%%%%%%%%%%%%%%%%%%%%%%" + e.split(':')[3].replaceAll(RegExp("'"),""));
      history.add({
        "date": e.split(':')[2].split(',')[0].replaceAll(RegExp("'"), ''),
        "time": e.split(':')[3].replaceAll(RegExp("'"), "") +
            ":" +
            e.split(':')[4].replaceAll(RegExp("'"), ""),
        "to-from": e.split(':')[6].split(',')[0].replaceAll(RegExp("'"), ''),
        "amount": e.split(':')[7].split(',')[0].replaceAll(RegExp("'"), ''),
        "balance": e.split(':')[8].split(',')[0].replaceAll(RegExp("'"), '')
      });
    }).toList();

    return response.toString().split(',')[0].split(',');
  }

  Future<String> send(
      {required String to, required int ammount, required String from}) async {
    isLoading = true;
    notifyListeners();
    final response = await NetworkServices.send(to, ammount, from);
    isLoading = false;
    notifyListeners();

    print(response + '###################');
    return response
        .toString()
        .split(':')[1]
        .replaceAll(RegExp("'"), '')
        .substring(
            0,
            response
                    .toString()
                    .split(':')[1]
                    .replaceAll(RegExp("'"), '')
                    .length -
                1);
  }

  Future<void> userdatafetch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("name")!;
    isLoading = true;
    notifyListeners();
    final data = await NetworkServices.userlogin(name);

    isLoading = false;
    notifyListeners();
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@000');
    userdata = data!.split(',');
    print(userdata);

    nickName = userdata[1].toString().split(':')[1].replaceAll(RegExp("'"), '');
    fullName = userdata[2].toString().split(':')[1].replaceAll(RegExp("'"), '');
    userName = userdata[3].toString().split(':')[1].replaceAll(RegExp("'"), '');
    pinNumber =
        userdata[4].toString().split(':')[1].replaceAll(RegExp("'"), '');
    phoneNumber =
        userdata[5].toString().split(':')[1].replaceAll(RegExp("'"), '');
    upiId = userdata[6]
        .toString()
        .split(':')[1]
        .replaceAll(RegExp("'"), '')
        .substring(
            0,
            userdata[6]
                    .toString()
                    .split(':')[1]
                    .replaceAll(RegExp("'"), '')
                    .length -
                1);

    notifyListeners();
    final Balance = await NetworkServices.currentBalance(nickName);
    print(Balance);
    currentBalance = Balance.toString()
        .split(':')[1]
        .substring(0, Balance.toString().split(':')[1].length - 3);
    notifyListeners();
  }
}
