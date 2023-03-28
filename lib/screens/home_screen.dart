import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:provider/provider.dart';
import 'package:rpbank/providers/userdata_provider.dart';
import 'package:rpbank/screens/auth/login.dart';
import 'package:rpbank/screens/profile.dart';
import 'package:rpbank/utils/commands.dart';
import 'package:rpbank/utils/tts.dart';
import 'package:rpbank/widgets/trasaction_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';
import '../providers/language_provider.dart';
import 'auth/edit.dart';
import 'transaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    TextToSpeech.speak("");

    super.initState();
  }

  var _init = true;
  var _isLoading = false;

  SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  String _convertedText = 'Press the button and start speaking';
  double _confidence = 1.0;

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

  var userdata;

  @override
  Widget build(BuildContext context) {
    var languageData = Provider.of<LanguageProvider>(context).lData;
    var transactionData = Provider.of<UserController>(context).history;
    var userData = Provider.of<UserController>(context);
    userdata = userData;
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
          "${userData.nickName}",
          style: TextStyle(
            color: Colors.black,
            fontSize: 29,
            fontFamily: "Sansation",
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
                (route) => true,
              );
            },
            child: Container(
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
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
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
                                height: height * 0.4,
                                width: height * 0.54,
                                child: Stack(
                                  children: [
                                    // SizedBox(
                                    //   height: height * 0.4,
                                    //   width: width*0.98,
                                    //   child:
                                    Image.asset(
                                      "assets/images/card.png",
                                      fit: BoxFit.contain,
                                    ),
                                    // ),
                                    Positioned(
                                      top: 35,
                                      right: 30,
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        shadows: [
                                          BoxShadow(
                                            blurStyle: BlurStyle.inner,
                                            offset: Offset(0, 2),
                                            color: Colors.black26,
                                          )
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: height * 0.22,
                                      left: 30,
                                      child: Text(
                                        "${languageData.wish},\n${userData.fullName}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width < height
                                              ? width * 0.06
                                              : width * 0.03,
                                          fontFamily: "Sansation",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: height * 0.2,
                                        right: 30,
                                        child: Column(
                                          children: [
                                            Text(
                                              languageData.yourBalance!,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width < height
                                                    ? width * 0.04
                                                    : width * 0.02,
                                                fontFamily: "Sansation",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              "₹${userData.currentBalance}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width < height
                                                    ? width * 0.045
                                                    : width * 0.025,
                                                fontFamily: "Sansation",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width * 0.85,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: width * 0.22,
                                      height: width * 0.22,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
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
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: MaterialButton(
                                          onPressed: () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TransactionScreen(
                                                          name:
                                                              userData.nickName,
                                                        )),
                                                (route) => true);
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.send,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                languageData.send!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 0.03,
                                                  fontFamily: "Sansation",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.22,
                                      height: width * 0.22,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
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
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: MaterialButton(
                                          onPressed: () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditScreen()),
                                                (route) => true);
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                languageData.edit!,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 0.03,
                                                  fontFamily: "Sansation",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width * 0.22,
                                      height: width * 0.22,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
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
                                      child: MaterialButton(
                                        onPressed: () async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.remove("name");
                                          prefs.remove("login");
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginScreen()),
                                              (route) => false);
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Icon(
                                                Icons.logout,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              languageData.logout!,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: width * 0.03,
                                                fontFamily: "Sansation",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Align(
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
                              ),
                            ],
                          );
                        } else {
                          // print(transactionData);
                          return TrasactionTile(
                            amount: transactionData[index - 1]["amount"],
                            balance: transactionData[index - 1]["balance"],
                            date: transactionData[index - 1]["time"],
                            name: transactionData[index - 1]['to-from'],
                            time: transactionData[index - 1]["time"],
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AvatarGlow(
            animate: _speech.isListening,
            glowColor: Colors.black,
            endRadius: 50.0,
            duration: const Duration(milliseconds: 2000),
            child: MaterialButton(
              shape: CircleBorder(),
              minWidth: 80,
              height: 80,
              color: Colors.black,
              onPressed: () async {
                await _listen().then((value) async {
                  print('ok');
                  if (_text.contains(Commands.balance)) {
                    await TextToSpeech.speak(
                        "Your balance is ${userData.currentBalance}");
                  }
                });
              },
              child: Icon(
                _speech.isListening ? Icons.mic : Icons.mic_none,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            width: width,
            height: height * 0.1,
            color: Colors.white,
            child: Center(
              child: Text(
                _convertedText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: width * 0.04,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        await _speech.listen(
          onResult: (val) => setState(() async {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
            print(_text);
            var translator = GoogleTranslator(client: ClientType.extensionGT);
            _text = await Commands.checkCommand(_text, userdata, context);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? language = prefs.getString("language");
            translator
                .translate(_text, to: language!.substring(1), from: 'en')
                .then((value) {
              setState(() {
                _convertedText = value.text;
              });
              print(value.text);
            });
          }),
        );
        _speech.statusListener;
      }
      // _listen();
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
