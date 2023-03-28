import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  static FlutterTts tts = FlutterTts();
  static int language = 0;

  static initTTS(language) async {
    var languages = await tts.getLanguages;
    print(languages);
    await tts.setLanguage(language);
    await tts.setPitch(1.0);
  }

  static speak(String data) async {
    await tts.awaitSpeakCompletion(true);
    await tts.speak(data);
    await tts.awaitSpeakCompletion(true);
  }
}
