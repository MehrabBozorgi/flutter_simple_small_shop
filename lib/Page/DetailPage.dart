import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_small_online_shop/Widget/AppData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DetailPage extends StatefulWidget {
  int productId;

  DetailPage(int id) {
    productId = id;
  }

  @override
  _DetailPageState createState() => _DetailPageState(productId);
}

class _DetailPageState extends State<DetailPage> {
  String title = '';
  String img_url = '';
  String description = '';
  String slide_img0 = '';
  String slide_img1 = '';
  String slide_img2 = '';
  String slide_img3 = '';

  _DetailPageState(productId) {
    String url = AppData.server_url +
        '?action=getProductData&id=' +
        productId.toString();

    http.get(url).then((resp) {
      if (resp.statusCode == 200) {
        dynamic jsonResp = convert.jsonDecode(resp.body);

        setState(() {
          title = jsonResp['title'];
          img_url = jsonResp['img_url'];
          description = jsonResp['description'];
          slide_img0 = jsonResp['slide_img0'];
          slide_img1 = jsonResp['slide_img1'];
          slide_img2 = jsonResp['slide_img2'];
          slide_img3 = jsonResp['slide_img3'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fa'), // Farsi
      ],
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          elevation: 0,
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'i',
              color: Colors.black,
              fontSize: 14,
              letterSpacing: -2,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(),
        ),
      ),
    );
  }
/////////////////////////////////////
////////// Widgets //////////////////
/////////////////////////////////////

}
