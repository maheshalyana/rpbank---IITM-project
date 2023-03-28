import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/language_model.dart';

class LanguageProvider extends ChangeNotifier {
  // ignore: deprecated_member_use
  late LanguageEntity languageData = LanguageEntity();

  LanguageEntity get lData {
    return languageData;
  }

  Future<void> getProductList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String language = prefs.getString("language")!;
    print(language);
    LanguageEntity? repo;

    String setWish() {
      return 'Good Morning';
    }

    if (language == 'en-IN') {
      repo = LanguageEntity(
        profile: 'PROFILE',
        loginWish: 'Welcome back',
        loginSetence: 'Login to your account',
        nickName: 'nick name',
        password: 'password',
        rememberID: 'Remember me',
        forgotPassword: 'forgot password',
        login: 'LOGIN',
        navigateCreate: "Didn't have an account",
        navigateCreateFunc: "CREATE",
        createWish: "Welcome",
        createSentence: "Create your account",
        fullName: "full name",
        userName: "user name",
        mobileNumber: "mobile number",
        upiID: "UPI id",
        create: "CREATE",
        navigateLogin: "Already have an account?",
        navigateLoginFunc: "CREATE",
        wish: setWish(),
        yourBalance: 'Your balance',
        send: 'SEND',
        edit: 'EDIT',
        logout: 'LOGOUT',
        yourTransactions: 'Your Transactions',
        newBalance: "New Balance",
        transaction: "TRANSACTION",
        beneficiaryName: "beneficiary name",
        cashtobetransfered: "Cash to be transfered",
      );
    } else if (language == 'te-IN') {
      repo = LanguageEntity(
        profile: "ప్రొఫైల్",
        loginWish: 'పునఃస్వాగతం',
        loginSetence: 'మీ ఖాతాకు లాగిన్ చేయండి',
        nickName: 'మారుపేరు',
        password: 'పాస్వర్డ్',
        rememberID: 'నన్ను గుర్తు పెట్టుకో',
        forgotPassword: 'పాస్వర్డ్ మర్చిపోయాను',
        login: 'ప్రవేశించండి',
        navigateCreate: "ఖాతా లేదా?",
        navigateCreateFunc: "సృష్టించు",
        createWish: "స్వాగతం",
        createSentence: "మీ ఖాతాను సృష్టించండి",
        fullName: "పూర్తి పేరు",
        userName: "వినియోగదారు పేరు",
        mobileNumber: "మొబైల్ నంబర్",
        upiID: "UPI id",
        create: "సృష్టించు",
        navigateLogin: "ఖాతా కలిగి ఉన్నారా?",
        navigateLoginFunc: "ప్రవేశించండి",
        wish: setWish(),
        yourBalance: 'మీ బ్యాలెన్స్',
        send: 'పంపండి',
        edit: 'సవరించు',
        logout: 'లాగ్ అవుట్',
        yourTransactions: 'మీ లావాదేవీలు',
        newBalance: "కొత్త బ్యాలెన్స్",
        beneficiaryName: "లబ్దిదారుని పేరు",
        transaction: "లావాదేవీ",
        cashtobetransfered: "బదిలీ చేయవలసిన మొత్తం",
      );
    } else if (language == 'hi-IN') {
      repo = LanguageEntity(
        profile: "प्रोफ़ाइल",
        loginWish: 'वापसी पर स्वागत है',
        loginSetence: 'अपने अकाउंट में लॉग इन करें',
        nickName: 'उपनाम',
        password: 'पासवर्ड',
        rememberID: 'मुझे याद रखिए',
        forgotPassword: 'पासवर्ड भूल गए?',
        login: 'लॉग इन',
        navigateCreate: "खाता नहीं था?",
        navigateCreateFunc: "बनाएं",
        createWish: "स्वागत",
        createSentence: "अपना खाता बनाएं",
        fullName: "पूरा नाम",
        userName: "उपयोगकर्ता नाम",
        mobileNumber: "मोबाइल नंबर",
        upiID: "UPI id",
        create: "बनाएं",
        navigateLogin: "क्या आपके पास खाता मौजूद है?",
        navigateLoginFunc: "लॉग इन",
        wish: setWish(),
        yourBalance: 'Your balance',
        send: 'SEND',
        edit: 'EDIT',
        logout: 'LOGOUT',
        yourTransactions: 'Your Transactions',
        newBalance: "New Balance",
        beneficiaryName: "लाभार्थी का नाम",
        transaction: "लेन-देन",
        cashtobetransfered: "हस्तांतरित की जाने वाली राशि",
      );
    } else if (language == 'ta-IN') {
      repo = LanguageEntity(
        profile: 'சுயவிவரம்',
        loginWish: 'மீண்டும் வருக',
        loginSetence: 'உங்கள் கணக்கில் உள்நுழைக',
        nickName: 'புனைப்பெயர்',
        password: 'கடவுச்சொல்',
        rememberID: 'என்னை நினைவில் வையுங்கள்',
        forgotPassword: 'கடவுச்சொல்லை மறந்துவிட்டீர்களா?',
        login: 'உள்நுழைய',
        navigateCreate: "கணக்கு இல்லையா?",
        navigateCreateFunc: "உருவாக்கு",
        createWish: "வரவேற்பு",
        createSentence: "உங்கள் கணக்கை உருவாக்கவும்",
        fullName: "முழு பெயர்",
        userName: "பயனர் பெயர்",
        mobileNumber: "கைபேசி எண்",
        upiID: "UPI id",
        navigateLogin: "ஏற்கனவே ஒரு கணக்கு உள்ளதா?",
        navigateLoginFunc: "உள்நுழைய",
        yourBalance: 'உங்கள் இருப்பு',
        send: 'அனுப்பு',
        wish: setWish(),
        edit: 'தொகு',
        logout: 'வெளியேறு',
        yourTransactions: 'உங்கள் பரிவர்த்தனைகள்',
        newBalance: "புதிய சமநிலையை",
        beneficiaryName: "புதிய சமநிலையை",
        transaction: "பரிவர்த்தனை",
        cashtobetransfered: "மாற்ற வேண்டிய தொகை",
      );
    }

    languageData = repo!;
    notifyListeners();
  }
}
