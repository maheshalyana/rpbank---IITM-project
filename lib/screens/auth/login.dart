import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rpbank/providers/userdata_provider.dart';
import 'package:rpbank/screens/auth/create.dart';
import 'package:rpbank/screens/home_screen.dart';
import 'package:rpbank/utils/tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/language_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

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
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Image.asset("assets/images/logo.png"),
                SizedBox(
                  height: height * 0.08,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    languageData.loginWish!,
                    style: TextStyle(
                      fontSize: width * 0.09,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    languageData.loginSetence!,
                    style: TextStyle(
                      fontSize: width * 0.075,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: name,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15),
                          hintText: languageData.nickName,
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
                        height: 15,
                      ),
                      TextFormField(
                        controller: password,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15),
                          hintText: languageData.password,
                          prefix: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: SvgPicture.asset(
                                "assets/images/password.svg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          suffix: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: SvgPicture.asset(
                                "assets/images/visibility_off.svg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/images/mark.svg"),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    languageData.rememberID!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              languageData.forgotPassword!,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Container(
                  width: width * 0.65,
                  height: 59,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3f000000),
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                      BoxShadow(
                        color: Color(0x3f313131),
                        blurRadius: 4,
                        offset: Offset(-2, -2),
                      ),
                    ],
                    color: Colors.black,
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("name", name.text);
                      print(prefs.get('name'));
                      Provider.of<UserController>(context, listen: false)
                          .userdatafetch()
                          .then((value) {
                        Provider.of<UserController>(context, listen: false)
                            .userdatafetch();

                        var userData =
                            Provider.of<UserController>(context, listen: false);
                        print('{' + userData.pinNumber.substring(1) + '}');
                        if (userData.pinNumber.substring(1) == password.text) {
                          prefs.setBool("login", true);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false);
                        } else {
                          const snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Enter correct pin'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          prefs.remove('name');
                        }
                      });
                    },
                    child: Center(
                      child: Text(
                        languageData.login!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          languageData.navigateCreate!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateUser()));
                          },
                          child: Text(
                            languageData.navigateCreateFunc!,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
