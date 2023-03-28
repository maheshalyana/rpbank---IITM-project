import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:rpbank/screens/auth/edit.dart';
import 'package:rpbank/screens/language.dart';
import 'package:rpbank/utils/tts.dart';
import 'package:rpbank/widgets/trasaction_tile.dart';

import '../providers/language_provider.dart';
import '../providers/userdata_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      Provider.of<UserController>(context).transactions().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
      Provider.of<UserController>(context).userdatafetch().then((value) {
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
    var transactionData = Provider.of<UserController>(context).history;
    var userData = Provider.of<UserController>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    TextToSpeech.speak(
        "${userData.userName} ${userData.phoneNumber} ${userData.upiId}");
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
          languageData.profile!,
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
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // height: height,
            // width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: height * 0.9,
                  width: width * 0.95,
                  child: ListView.builder(
                      itemCount: transactionData.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              Container(
                                height: height * 0.7,
                                width: width,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      top: height * 0.08,
                                      child: Container(
                                        height: height * 0.6,
                                        width: width * 0.9,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(64),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: height * 0.07,
                                            ),
                                            Text(
                                              userData.fullName,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 34,
                                                fontFamily: "Sansation",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.04,
                                            ),
                                            Container(
                                              width: width * 0.8,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        languageData
                                                            .yourBalance!,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontFamily:
                                                              "Sansation",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.3,
                                                        child: Text(
                                                          ": ₹${userData.currentBalance}",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontFamily:
                                                                "Sansation",
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        languageData
                                                            .mobileNumber!,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontFamily:
                                                              "Sansation",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.3,
                                                        child: Text(
                                                          ": ${userData.phoneNumber}",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontFamily:
                                                                "Sansation",
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "UPI id",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontFamily:
                                                              "Sansation",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.3,
                                                        child: Text(
                                                          ": ${userData.upiId}",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontFamily:
                                                                "Sansation",
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.1,
                                            ),
                                            Container(
                                              width: width * 0.5,
                                              height: 42,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xff0f1113),
                                                    blurRadius: 16,
                                                    offset: Offset(3, 4),
                                                  ),
                                                  BoxShadow(
                                                    color: Color(0x66434d56),
                                                    blurRadius: 16,
                                                    offset: Offset(-3, -4),
                                                  ),
                                                ],
                                                color: Colors.black,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    Navigator.pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EditScreen()),
                                                        (route) => true);
                                                  },
                                                  child: Center(
                                                    child: Text(
                                                      languageData.edit!,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontFamily: "Sansation",
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: width * 0.5,
                                                height: 42,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 1,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0xff0f1113),
                                                      blurRadius: 16,
                                                      offset: Offset(3, 4),
                                                    ),
                                                    BoxShadow(
                                                      color: Color(0x66434d56),
                                                      blurRadius: 16,
                                                      offset: Offset(-3, -4),
                                                    ),
                                                  ],
                                                  color: Colors.black,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    languageData.logout!,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontFamily: "Sansation",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LanguageScreen(),
                                            ),
                                            (route) => true);
                                      },
                                      child: Image.asset(
                                        "assets/images/language.png",
                                      ),
                                    )),
                                    Positioned(
                                      top: 0,
                                      child: Container(
                                        width: height * 0.15,
                                        height: height * 0.15,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/dp.png"),
                                              fit: BoxFit.cover),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x3f000000),
                                              blurRadius: 4,
                                              offset: Offset(-2, -4),
                                            ),
                                            BoxShadow(
                                              color: Color(0x3f000000),
                                              blurRadius: 4,
                                              offset: Offset(2, 4),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  languageData.yourTransactions!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 26,
                                    fontFamily: "Sansation",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return TrasactionTile(
                          amount: transactionData[index - 1]["amount"],
                          balance: transactionData[index - 1]["balance"],
                          date: transactionData[index - 1]["time"],
                          name: transactionData[index - 1]['to-from'],
                          time: transactionData[index - 1]["time"],
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
