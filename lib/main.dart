
import 'package:ai_math_app/providers/chat_provider.dart';
import 'package:ai_math_app/screens/chat_screen.dart';
import 'package:ai_math_app/screens/home_screen.dart';
import 'package:ai_math_app/screens/scan_screen.dart';
import 'package:ai_math_app/screens/splash_screen.dart';
import 'package:ai_math_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MultiProvider(
       providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        //ChangeNotifierProvider(create: (_) => ScanProvider()),
        // Add other providers here
      ],
       child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Math Solver",
        theme: buildAppTheme(),
        initialRoute: '/', // Set the initial route
        routes: {
          '/': (context) =>
              const SplashScreen(), 
          '/home': (context) =>
              const HomeScreen(),
          '/scan': (context) =>
              const ScanScreen(), 
          '/chat': (context) =>
              const ChatScreen(),
        },
           ),
     ); 
  }
}

