import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class NetworkServices {
  static userlogin<UserData>(String nickName) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {"action": "details", "nick_name": nickName},
        ),
      );

      if (response.statusCode == 200) {
        print('00000');
        // print(response.body);
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  static currentBalance<UserData>(String nickName) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {"action": "balance", "nick_name": "sandeep"},
        ),
      );

      if (response.statusCode == 200) {
        // print(response.body);
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  static send<UserData>(String to, int ammount, String from) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            "action": "transfer",
            "amount": ammount,
            "from_user": from,
            "to_user": to
          },
        ),
      );

      if (response.statusCode == 200) {
        // print(response.body);
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }

  static history<UserData>(String nickName) async {
    try {
      final response = await http.post(
        Uri.parse(ApiKey.url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {"action": "history", "nick_name": nickName},
        ),
      );

      if (response.statusCode == 200) {
        // print(response.body);
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }
}
