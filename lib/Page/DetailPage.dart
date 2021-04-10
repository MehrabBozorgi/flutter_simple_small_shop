import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_small_online_shop/Model/MySlider.dart';
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
  List<MySlider> slider = [];

  String title = '';
  String img_url = '';
  String description = '';
  String slide_img = '';

  int price = 0;

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
          price = int.parse(jsonResp['price']);
        });
      }
    });
  }

  getSlider() {
    if (slider.length == 0) {
      String url = AppData.server_url +
          '?action=get_sliders2&product_id=' +
          widget.productId.toString();

      http.get(url).then((response) {
        if (response.statusCode == 200) {
          print('کار کرد ...');
          List jsonRespo = convert.jsonDecode(response.body);

          for (int i = 0; i < jsonRespo.length; i++) {
            setState(() {
              slider.add(new MySlider(
                  id: int.parse(jsonRespo[i]['id']),
                  img_slide: jsonRespo[i]['img_slide']));
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    getSlider();
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
              fontFamily: 'b',
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ////////////////////////////////
              Container(
                height: 250,
                child: PageView.builder(
                  itemBuilder: (context, position) {
                    return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ListViewView(position));
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: slider.length,
                  onPageChanged: (position) {
                    setState(() {
                      tab_index = position;
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 20),
                child: Center(
                  child: footer(),
                ),
              ),

              Container(
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.topRight,
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 20, fontFamily: 'b', color: Colors.white),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.only(
                  right: 5,
                  left: 5,
                ),
                padding:
                    EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 20),
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70)),
                ),
                child: Text(
                  description,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'i',
                      color: Colors.black,
                      letterSpacing: 2),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ////////////////////////////////////
              //////////////  Button  ////////////
              ////////////////////////////////////
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      topRight: Radius.circular(50)),
                ),
                width: w - 70,
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        price.toString(),
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'b', fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

/////////////////////////////////////
////////// Widgets //////////////////
/////////////////////////////////////

  Widget ListViewView(int index) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Container(
          width: w,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Image(
              image: NetworkImage(slider[index].img_slide),
              fit: BoxFit.fitWidth,
              // height: 250,
            ),
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
        color: Colors.white38,
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

    for (int i = 0; i < slider.length; i++) {
      i == tab_index ? sliderItem.add(_Active()) : sliderItem.add(_InActive());
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: sliderItem,
    );
  }
}
