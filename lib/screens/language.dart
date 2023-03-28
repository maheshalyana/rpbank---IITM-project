import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rpbank/screens/auth/login.dart';
import 'package:rpbank/screens/splash_screen.dart';
import 'package:rpbank/utils/tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  void initState() {
    TextToSpeech.initTTS('en-IN');
    TextToSpeech.speak("Select the language");
    TextToSpeech.initTTS('te-IN');
    TextToSpeech.speak("భాషను ఎంచుకోండి");
    TextToSpeech.initTTS('hi-IN');
    TextToSpeech.speak("भाषा का चयन करें");
    TextToSpeech.initTTS('ta-IN');

    TextToSpeech.speak("மொழியைத் தேர்ந்தெடுக்கவும்");
    super.initState();
  }

  void setLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("language", language);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select your language",
              style: TextStyle(
                color: Colors.black,
                fontSize: 34,
                fontFamily: "Sansation",
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: height * 0.5,
              width: width * 0.9,
              child: GridView.count(
                childAspectRatio: 1,
                mainAxisSpacing: 30,
                crossAxisSpacing: 30,
                crossAxisCount: 2,
                children: ['English', 'తెలుగు', 'हिंदी', 'தமிழ்']
                    .map(
                      (e) => Container(
                        width: width * 0.35,
                        height: width * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
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
                          borderRadius: BorderRadius.circular(8),
                          child: MaterialButton(
                            onPressed: () {
                              String language = 'english';
                              if (e == "తెలుగు") {
                                language = 'te-IN';
                              } else if (e == 'हिंदी') {
                                language = 'hi-IN';
                              } else if (e == 'தமிழ்') {
                                language = 'ta-IN';
                              } else {
                                language = 'en-IN';
                              }
                              setLanguage(language);
                            },
                            child: Center(
                              child: Text(
                                e,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontFamily: "Sansation",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.black,
        backgroundColor: Colors.black,
        onPressed: () {},
        child: Icon(
          Icons.mic,
          color: Colors.white,
        ),
      ),
    );
  }
}
