import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpbank/providers/language_provider.dart';
import 'package:rpbank/screens/splash_screen.dart';
import 'package:rpbank/utils/tts.dart';

import 'providers/userdata_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LanguageProvider()),
        ChangeNotifierProvider.value(value: UserController()),
      ],
      child: MaterialApp(
        title: 'RP bank',
        home: SplashScreen(),
      ),
    );
  }
}
