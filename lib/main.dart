import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Page/FirstPage.dart';

void main() =>
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('fa'), // Farsi
        ],
        home: Main()));

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   backgroundColor: Colors.grey[400],
        //   actions: [
        //     Icon(Icons.search)
        //   ],
        //   title: Text('جستجو در',style: TextStyle(fontFamily: 'iran'),),
        // ),

        body: Container(
          margin: EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.grey[200],
          ),

          width: w,
          height: 50,
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Colors.grey[800],
                size: 30,
              ),
              Text(
                'جستجو در',
                style: TextStyle(
                    fontFamily: 'i', fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'فروشگاه',
                style: TextStyle(
                    fontFamily: 'b', fontSize: 18, color: Colors.red[600]),
              ),
              FirstPage(),
            ],
          ),
        ),
      ),
    );
  }
}
