import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_small_online_shop/Model/Product.dart';
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
  List<Product> product = [];

  String title = '';
  String img_url = '';
  String description = '';
  String slide_img0 = '';
  String slide_img1 = '';
  String slide_img2 = '';
  String slide_img3 = '';

  int tab_index = 0;

  _DetailPageState(productId) {
    String url = AppData.server_url +
        '?action=getProductData&id=' +
        productId.toString();

    http.get(url).then((resp) {
      if (resp.statusCode == 200) {
        dynamic jsonResp = convert.jsonDecode(resp.body);
        print(resp.body);

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
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fa'), // Farsi
      ],
      home: Scaffold(
        backgroundColor: Colors.indigo[700],
        appBar: AppBar(
          backgroundColor: Colors.indigo[700],
          elevation: 0,
          title: Text(
            title,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'i',
              color: Colors.black,
              fontSize: 14,
              letterSpacing: -2,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ////////////////////////////////
              Container(
                height: 282,
                child: PageView.builder(
                  itemBuilder: (context, position) {
                    return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ListViewView());
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  onPageChanged: (position) {
                    setState(() {
                      tab_index = position;
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 150),
                child: Center(
                  child: footer(),
                ),
              ),
              // Text(title),
              // Text(description),
            ],
          ),
        ),
      ),
    );
  }

/////////////////////////////////////
////////// Widgets //////////////////
/////////////////////////////////////

  Widget ListViewView() {
    return Row(
      children: [
        Container(
          // margin: EdgeInsets.only(right: 10, left: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              color: Colors.red),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            child: Image(image: NetworkImage(slide_img0), fit: BoxFit.fitWidth),
          ),
        ),
        Container(
          // margin: EdgeInsets.only(right: 10, left: 10),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(50),
          //       topLeft: Radius.circular(50),
          //     ),
          //     color: Colors.red),
          child: ClipRRect(
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(50),
            //   topLeft: Radius.circular(50),
            // ),
            child: Image(image: NetworkImage(slide_img1), fit: BoxFit.fitWidth),
          ),
        ),
        Container(
          // margin: EdgeInsets.only(right: 10, left: 10),
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(50),
          //       bottomRight: Radius.circular(50),
          //     ),
          //     color: Colors.red),
          child: ClipRRect(
            // borderRadius: BorderRadius.only(
            //     bottomRight: Radius.circular(40),
            //     bottomLeft: Radius.circular(40)),
            child: Image(image: NetworkImage(slide_img2), fit: BoxFit.fitWidth),
          ),
        ),
        Container(
          // margin: EdgeInsets.only(right: 10, left: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                topLeft: Radius.circular(50),
              ),
              color: Colors.red),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              topLeft: Radius.circular(50),
            ),
            child: Image(image: NetworkImage(slide_img3), fit: BoxFit.fitWidth),
          ),
        ),
      ],
    );
  }

  Widget _Active() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      width: 10,
      height: 10,
    );
  }

  Widget _InActive() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      width: 10,
      height: 10,
    );
  }

  Widget footer() {
    List<Widget> sliderItem = [];

    for (int i = 0; i < product.length; i++) {
      i == tab_index ? sliderItem.add(_Active()) :
      sliderItem.add(_InActive());
    }
    return Row(
      children: sliderItem,
    );
  }
}
