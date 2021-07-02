import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Page/FirstPage.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('fa'), // Farsi
        ],
        home: Main(),
      ),
    );

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: FirstPage(),
      ),
    );
  }
}
