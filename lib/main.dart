import 'package:chatgbt_app/constants/colors.dart';
import 'package:chatgbt_app/provider/models_provider.dart';
import 'package:chatgbt_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ModelsProvider>(
      create: (context) => ModelsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatGBT app',
      theme: ThemeData(
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        appBarTheme: AppBarTheme(color: cardColor),
        useMaterial3: true,
      ),
      home: const ChatScreen(),
    );
  }
}
