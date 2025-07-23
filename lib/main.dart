import 'package:ai_math_app/providers/chat_provider.dart';
import 'package:ai_math_app/providers/scan_provider.dart';
import 'package:ai_math_app/screens/privacy_policy_screen.dart';
import 'package:ai_math_app/screens/splash_screen.dart';
import 'package:ai_math_app/screens/terms_conditions_screen.dart';
import 'package:ai_math_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/chat_screen.dart';
import 'screens/home_screen.dart';
import 'screens/scan_screen.dart';
import 'services/ad_services.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize AdMob
  await AdService().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => ScanProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Math Solver',
        theme: buildAppTheme(),
        darkTheme: buildDarkAppTheme(),
        themeMode: ThemeMode.system,
        initialRoute: '/', // Set the initial route
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomeScreen(),
          '/scan': (context) => const ScanScreen(),
          '/chat': (context) => const ChatScreen(),
          '/terms': (context) => const TermsConditionsScreen(),
          '/privacy': (context) => const PrivacyPolicyScreen(),
        },
      ),
    );
  }
}