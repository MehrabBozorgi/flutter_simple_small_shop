import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_small_online_shop/Model/MySlider.dart';
import 'package:flutter_small_online_shop/Model/Product.dart';
import 'package:flutter_small_online_shop/Page/AddComment.dart';
import 'package:flutter_small_online_shop/Widget/AppData.dart';
import 'package:flutter_small_online_shop/Widget/Cart.dart';
import 'package:flutter_small_online_shop/Widget/loadCircle.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'CartPage.dart';
import 'ShowComment.dart';

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
  String slide_img = '';
  int tab_index = 0;

  String price;

  String productPrice;

  List<MySlider> slider = [];

  //
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
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

  //
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
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
          productPrice = jsonResp['price'];

          var format = new NumberFormat('###,###');
          price = format.format(int.parse(jsonResp['price'])).toString();
        });
      }
    });
  }

  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    getSlider();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          elevation: 0,
          actions: [
            //
            /////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////  AddComment ///////////////////////////////////////////////////////
            IconButton(
              mouseCursor: MouseCursor.defer,
              tooltip: 'ثبت دیدگاه',
              icon: Icon(
                Icons.add_comment_rounded,
                color: Colors.white,
              ),
              /////////////////////////////////////////////////////////////////////////////////////////////////
              /////////////////////////////////////////////////////////////////////////////////////////////////
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddComment(widget.productId)));
              },
            ),
            //
            /////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////  ShowComment //////////////////////////////////////////////////////
            IconButton(
                mouseCursor: MouseCursor.defer,
                tooltip: 'مشاهده نظرات',
                icon: Icon(
                  Icons.comment,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowComment(widget.productId),
                      ));
                }),
            //
            /////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////  AddCart //////////////////////////////////////////////////////////
            IconButton(
                mouseCursor: MouseCursor.defer,
                tooltip: 'سبد خرید',
                icon: Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                }),
          ],
        ),
        ///////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////
        body: (title.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    ///////////////////////////////////////////////////////////////////////////////////////
                    ///////////////////// Slider //////////////////////////////////////////////////////////
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
                    //
                    //////////////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////// Price ///////////////////////////////////////////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 60,
                          width: 90,
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              color: Colors.amber[200],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20))),
                          child: Center(
                              child: Text(
                            price.toString() + ' تومان',
                            style: TextStyle(
                                fontFamily: 'b', color: Colors.grey[800]),
                          )),
                        ),
                      ],
                    ),
                    //
                    //////////////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////// Detail ///////////////////////////////////////////////////
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
                      padding: EdgeInsets.only(
                          right: 25, left: 20, top: 15, bottom: 20),
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(70),
                            bottomRight: Radius.circular(70)),
                        border:
                            Border.all(width: 0.5, color: Colors.amber[200]),
                      ),
                      child: Text(
                        description,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'i',
                            color: Colors.white,
                            letterSpacing: 2),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    /////////////////////////////////////////////  Button  /////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    GestureDetector(
                      onTap: () {
                        Cart.add_product_cart(widget.productId.toString(),
                                title, int.parse(productPrice), img_url)
                            .then((response) {
                          if (response) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartPage()),
                            );
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber[200],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50)),
                        ),
                        width: w,
                        height: 75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_basket,
                              color: Colors.grey[800],
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text(
                                'اضافه کردن به سبد خرید',
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontFamily: 'b',
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : loadCircle()),
      ),
    );
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////// Widgets ///////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _Active() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber[300],
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      width: 10,
      height: 10,
    );
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
