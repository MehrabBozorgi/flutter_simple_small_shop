import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_small_online_shop/Widget/Cart.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //
  //

  int cartPrice = 0;
  Map<int, String> cartProductId = Map();
  List<Map<String, dynamic>> product_listData = [];

  _CartPageState() {
    Cart.get_cart_product().then((response) {
      List<String> products_id = response.split("_");

      for (int i = 0; i < (products_id.length - 1); i++) {
        String id = products_id[i];
        cartProductId[i] = id;
        Cart.get_product_data(id).then((response) {
          setState(() {
            cartPrice += (response['price'] * response['number']);
            product_listData.add(response);
          });
        });
      }
    });
  }

  //
  //
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
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          elevation: 0,
          title: Text(
            'سبد خرید',
            style: TextStyle(fontFamily: 'b'),
          ),
          actions: [
            ////////////////////////////////////////////////////////////////////////////////////////////////
            ////////////////  DELETE_ICON   ////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////////////////
            product_listData.length > 0
                ? IconButton(
                    icon: Icon(
                      Icons.delete,
                    ),
                    onPressed: () {
                      //

                      AlertDialog dialog = AlertDialog(
                        backgroundColor: Colors.grey[900],
                        content: Text(
                          'خالی کردن سبد خرید؟',
                          textAlign: TextAlign.right,
                          style:
                              TextStyle(color: Colors.white, fontFamily: 'i'),
                        ),
                        elevation: 15,
                        actions: [
                          ////////////////////////////////////////////////
                          ///////////////////////// NO ///////////////////
                          ////////////////////////////////////////////////
                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'خیر',
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'i'),
                            ),
                          ),
                          ////////////////////////////////////////////////
                          ///////////////////////// YES //////////////////
                          ////////////////////////////////////////////////
                          RaisedButton(
                            onPressed: () {
                              Cart.empty_cart().then((response) {
                                Navigator.pop(context);

                                if (response) {
                                  setState(() {
                                    product_listData = [];
                                  });
                                }
                              });
                            },
                            child: Text(
                              'بله',
                              style:
                                  TextStyle(color: Colors.red, fontFamily: 'i'),
                            ),
                          )
                        ],
                      );
                      //
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => dialog);
                    },
                  )
                //
                //
                //
                : Text(''),
          ],
        ),
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////// Body /////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        body: Container(
          color: Colors.grey[900],
          child: product_listData.length > 0
              ? ListView.builder(
                  itemBuilder: (context, index) => _cartRow(index),
                  itemCount: product_listData.length,
                )
              : Container(
                  child: Center(
                    child: Text(
                      'سبد خرید خالی می باشد',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'b',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////// _CartRow /////////////////////////////////////////////////////////////////////////

  Widget _cartRow(int index) {
    String price = product_listData[index]['price'].toString();

    int total_price =
        product_listData[index]['price'] * product_listData[index]['number'];

    String price2 = total_price.toString();

    return SingleChildScrollView(
      child: Column(
        children: [
          ////////////////////////////////////////////////////////////////////////////////////////////////
          /////////  (جمع کل) CartPrice  ////////////////

          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(width: 1, color: Colors.grey[400]),
                color: Colors.white38),
            margin: EdgeInsets.only(right: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    'جمع کل',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'b',
                        fontSize: 16,
                        color: Colors.yellow[600]),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      cartPrice.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: 'b', fontSize: 16),
                    )),
              ],
            ),
          ),
          //
          ////////////////////////////////////////////////
          ///////////////////  بخش اصلی  ////////////////
          ////////////////////////////////////////////////
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(width: 1, color: Colors.white38),
            ),
            margin: EdgeInsets.only(right: 5, left: 5, top: 20, bottom: 20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 1, color: Colors.white38),
                  ),
                  child: Row(
                    children: [
                      Image(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(product_listData[index]['img_url']),
                        height: 140,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          right: 10,
                          left: 10,
                        ),
                        width: 180,
                        child: Text(
                          product_listData[index]['title'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'b'),
                        ),
                      ),
                    ],
                  ),
                ),
                //
                ////////////////////////////////////////////////
                //////////////////  قیمت دوره  ////////////////
                ////////////////////////////////////////////////

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white38,
                  ),
                  margin: EdgeInsets.only(right: 10, left: 10, top: 5),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'قیمت دوره',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.yellow[600], fontFamily: 'b'),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        price + ' تومان',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontFamily: 'b'),
                      )),
                    ],
                  ),
                ),

                //
                ////////////////////////////////////////////////
                //////////////// جمع دوره ها   ////////////////
                ////////////////////////////////////////////////

                Container(
                  margin:
                      EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white38,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'جمع دوره ها',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.yellow[600], fontFamily: 'b'),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        price2 + ' تومان',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.green, fontFamily: 'b'),
                      )),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Row(
                        children: [
                          IconButton(
                              autofocus: true,
                              ////////////////////////////////////////////////
                              /////////  Add  ////////////////////////////////
                              ////////////////////////////////////////////////
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Cart.change_number_product(cartProductId[index])
                                    .then((response) {
                                  if (response) {
                                    setState(() {
                                      int n = product_listData[index]['number'];
                                      n = n + 1;
                                      product_listData[index]['number'] = n;
                                      cartPrice +=
                                          product_listData[index]['price'];
                                    });
                                  }
                                });
                              }),
                          Text(
                            product_listData[index]['number'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                              ////////////////////////////////////////////////
                              /////////  Remove  /////////////////////////////
                              ////////////////////////////////////////////////
                              icon: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Cart.reduce_product_count(cartProductId[index])
                                    .then((response) {
                                  if (response) {
                                    setState(() {
                                      int n = product_listData[index]['number'];

                                      if (n > 1) {
                                        n = n - 1;
                                        product_listData[index]['number'] = n;
                                        //
                                        cartPrice -=
                                            product_listData[index]['price'];
                                        //
                                      } else {
                                        cartPrice -=
                                            product_listData[index]['price'];
                                        //
                                        product_listData.removeAt(index);
                                        cartProductId.remove(index);
                                        _updateCartProductId();
                                      }
                                    });
                                  }
                                });
                              }),
                        ],
                      ),
                    )),
                    ////////////////////////////////////////////////
                    /////////  DeleteAll  //////////////////////////
                    ////////////////////////////////////////////////
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Cart.remove_cart_product(cartProductId[index])
                              .then((response) {
                            if (response) {
                              setState(() {
                                cartPrice -= (product_listData[index]['price'] *
                                    product_listData[index]['number']);
                                //
                                product_listData.removeAt(index);
                                cartProductId.remove(index);
                                _updateCartProductId();
                              });
                            }
                          });
                        },
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 10, right: 50, bottom: 10),
                          padding: EdgeInsets.all(5),
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            children: [
                              Center(
                                child: Text(
                                  ' حذف محصول',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'b',
                                      fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Center(
                                  child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _updateCartProductId() {
    Map<int, String> newCartData = Map();
    int i = 0;
    cartProductId.forEach((key, value) {
      newCartData[i] = value;
      i++;
    });
    cartProductId = newCartData;
  }
}
