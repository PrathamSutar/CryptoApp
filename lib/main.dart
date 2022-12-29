import 'package:crypto_currency_app556/Screens/app_themes/app_themes.dart';
import 'package:crypto_currency_app556/Screens/homescreen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await AppTheme.getThemevalue();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Crypto Currency App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: homescreen(),
    );
  }
}
