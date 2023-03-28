import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rpbank/screens/auth/create.dart';
import 'package:rpbank/screens/auth/edit.dart';
import 'package:rpbank/screens/profile.dart';
import 'package:rpbank/screens/transaction.dart';
import 'package:rpbank/utils/tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../screens/auth/login.dart';
import '../services/constants.dart';

class Commands {
  static String balance = 'balance';
  static String sendAmount = 'send';
  static String logOut = 'logout';
  static String edit = 'edit';
  static String registerUser = 'register';
  static String removeUser = 'remove';
  static String lastTransactions = 'transaction';
  static String profile = 'details';

  static Future<String> checkCommand(String text, data, context) async {
    print("checking");
    if (text.contains(balance)) {
      print(balance);
      TextToSpeech.speak(data.currentBalance);
    } else if (text.contains(sendAmount)) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => TransactionScreen(name: data.nickName)),
          (route) => true);
    } else if (text.contains(edit)) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => EditScreen()),
          (route) => true);
    } else if (text.contains(logOut)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("name");
      prefs.remove("login");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    } else if (text.contains(registerUser)) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => CreateUser()),
          (route) => false);
    } else if (text.contains(removeUser)) {
      var jsonData = json.encode(
          {"action": "remove", "nick_name": data.nick_name.substring(1)});
      print(data);
      var response = http
          .post(Uri.parse(ApiKey.url),
              headers: {"Content-Type": "application/json"}, body: jsonData)
          .then((value) async {
        if (value.body.contains(',')) {
          const snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text('ERROR'),
          );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          const snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('removed'),
          );
          SharedPreferences prefs = await SharedPreferences.getInstance();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          prefs.remove("name");
          prefs.remove("login");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
            (route) => false,
          );
        }
      });
    } else if (text.contains(lastTransactions)) {
    } else if (text.contains(profile)) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
          (route) => false);
    }
    return "Tap on mic to speak";
  }
}
