import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rpbank/screens/auth/edit.dart';
import 'package:rpbank/screens/home_screen.dart';
import 'package:rpbank/services/constants.dart';
import 'package:rpbank/widgets/trasaction_tile.dart';

import '../providers/language_provider.dart';
import '../utils/tts.dart';
import 'package:http/http.dart' as http;

class TransactionScreen extends StatefulWidget {
  TransactionScreen({super.key, required this.name});
  String name;

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  TextEditingController amount = TextEditingController();
  TextEditingController name = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amount.text = "₹ 0";
  }

  var _init = true;
  var _isLoading = false;
  var bool = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<LanguageProvider>(context).getProductList().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
  }

  @override
  Widget build(BuildContext context) {
    var languageData = Provider.of<LanguageProvider>(context).lData;

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.align_horizontal_left_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          languageData.transaction!,
          style: TextStyle(
            color: Colors.black,
            fontSize: 29,
            fontFamily: "Sansation",
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/dp.png"),
                ),
                shape: BoxShape.circle,
                color: Colors.red),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: languageData.beneficiaryName,
                  prefix: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: SvgPicture.asset(
                        "assets/images/user.svg",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                width: width * 0.6,
                height: height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff0f1113),
                      blurRadius: 5,
                      offset: Offset(3, 4),
                    ),
                    BoxShadow(
                      color: Color(0x66434d56),
                      blurRadius: 5,
                      offset: Offset(-3, -4),
                    ),
                  ],
                  color: Colors.black,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      languageData.cashtobetransfered!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Sansation",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextFormField(
                      controller: amount,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: "Sansation",
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: InputDecoration(
                        hintText: "0",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: "Sansation",
                          fontWeight: FontWeight.w700,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.07,
              ),
              Container(
                height: height * 0.5,
                width: width * 0.7,
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30,
                  children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 'b', 0, 's']
                      .map((e) => Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3f000000),
                                  blurRadius: 6,
                                  offset: Offset(2, 4),
                                ),
                                BoxShadow(
                                  color: Color(0x3f000000),
                                  blurRadius: 10,
                                  offset: Offset(-2, -3),
                                ),
                              ],
                              color: Colors.black,
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (e.toString() == "s") {
                                  int aamount =
                                      int.parse(amount.text.substring(2));
                                  var data = json.encode({
                                    "action": "transfer",
                                    "amount": aamount,
                                    "from_user": widget.name.substring(1),
                                    "to_user": name.text,
                                  });
                                  print(data);
                                  var response = http
                                      .post(Uri.parse(ApiKey.url),
                                          headers: {
                                            "Content-Type": "application/json"
                                          },
                                          body: data)
                                      .then((value) {
                                    print(value.body);
                                    if (value.statusCode == 200) {
                                      if (value.body.contains(",")) {
                                        const snackBar = SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              'Retry,Please enter proper benificiary name and amount'),
                                        );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        const snackBar = SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text('Transfered'),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()),
                                            (route) => false);
                                      }
                                    }
                                  });
                                } else if (e.toString() == "b") {
                                  setState(() {
                                    if (amount.text == "₹ 0") {
                                    } else {
                                      amount.text = amount.text
                                          .substring(0, amount.text.length - 1);
                                      if (amount.text == "₹ ") {
                                        amount.text = "₹ 0";
                                      }
                                    }
                                  });
                                } else {
                                  setState(() {
                                    if (amount.text == "₹ 0") {
                                      amount.text = "₹ ";
                                    }
                                    amount.text = amount.text + e.toString();
                                  });
                                }
                              },
                              child: Center(
                                child: e.toString() == "s"
                                    ? Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      )
                                    : e.toString() == "b"
                                        ? Icon(
                                            Icons.arrow_back_rounded,
                                            color: Colors.white,
                                          )
                                        : Text(
                                            e.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontFamily: "Sansation",
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
