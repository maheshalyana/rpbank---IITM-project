import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rpbank/screens/auth/login.dart';
import 'package:rpbank/screens/home_screen.dart';
import 'package:rpbank/services/constants.dart';
import 'package:rpbank/utils/tts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/language_provider.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  TextEditingController nickName = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController upiId = TextEditingController();
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
                  height: height * 0.03,
                ),
                Image.asset("assets/images/logo.png"),
                SizedBox(
                  height: height * 0.01,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    languageData.createWish!,
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
                    languageData.createSentence!,
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
                        controller: fullname,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15),
                          hintText: languageData.fullName,
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
                        height: 10,
                      ),
                      TextFormField(
                        controller: username,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15),
                          hintText: languageData.userName,
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
                        height: 10,
                      ),
                      TextFormField(
                        controller: nickName,
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
                        height: 10,
                      ),
                      TextFormField(
                        controller: mobileNumber,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15),
                          hintText: languageData.mobileNumber,
                          prefix: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.call,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
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
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: upiId,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 15),
                          hintText: "UPI id",
                          prefix: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.currency_rupee,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
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
                      var request = http.post(
                        Uri.parse(ApiKey.url),
                        headers: {'Content-Type': 'application/json'},
                        body: {
                          "action": "register",
                          "nick_name": nickName.text,
                          "full_name": fullname.text,
                          "user_name": username.text,
                          "pin_number": password.text,
                          "mob_number": mobileNumber.text,
                          "upi_id": upiId.text,
                        },
                      ).then((value) async {
                        if (value.statusCode == 200) {
                          if (value.body.contains(",")) {
                            const snackBar = SnackBar(
                              content: Text(
                                  'user name or nick name are already taken'),
                            );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('name', nickName.text);
                            prefs.setBool('login', true);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (route) => false);
                          }
                        }
                      });
                    },
                    child: Center(
                      child: Text(
                        languageData.create!,
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
                          languageData.navigateLogin!,
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
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            languageData.navigateLoginFunc!,
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
