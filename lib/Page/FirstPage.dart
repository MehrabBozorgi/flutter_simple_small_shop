import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_small_online_shop/Model/Product.dart';
import 'package:flutter_small_online_shop/Widget/AppData.dart';
import 'package:flutter_small_online_shop/Widget/Slider1.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<Product> new_product = [];
  List<Product> order_product = [];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    getProductFromServer('new_product', new_product);
    getProductFromServer('order_product', order_product);
    return SingleChildScrollView(
      child: Column(
        children: [
          //SearchBar
          Container(
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
                Text('جستجو در',
                    style: TextStyle(
                        fontFamily: 'i',
                        fontSize: 16,
                        color: Colors.grey[700])),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'فروشگاه',
                  style: TextStyle(
                      fontFamily: 'b', fontSize: 18, color: Colors.red[600]),
                ),
              ],
            ),
          ),
          Slider1(),
          Container(
            height: h,
            child: ListView.builder(
              itemBuilder: newProductList,
              itemCount: new_product.length,
              scrollDirection: Axis.vertical,
            ),
          ),
        ],
      ),
    );
  }

  /////////////////////////////////////
  ////////// Widgets //////////////////
  /////////////////////////////////////

  Widget getProductFromServer(String action, List<Product> list) {
    if (list.length == 0) {
      var url = AppData.server_url + '?action=' + action;
      http.get(url).then((resp) {
        if (resp.statusCode == 200) {
          print(resp.statusCode);
          List jsonResp = convert.jsonDecode(resp.body);
          for (int i = 0; i < jsonResp.length; i++) {
            setState(() {
              list.add(new Product(
                id: int.parse(jsonResp[i]['id']),
                title: jsonResp[i]['title'],
                price: int.parse(jsonResp[i]['price']),
                img_url: jsonResp[i]['img_url'],
                description: jsonResp[i]['description'],
              ));
            });
          }
        }
      });
    }
  }

  Widget ProductView(int index, List<Product> list) {
    double w = MediaQuery.of(context).size.width - 50;
    double h = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(border:Border.all(color: Colors.white24,width: 2) ),
      margin: EdgeInsets.only(top: 20, bottom: 20, right: 10, left: 10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          
        ),
        child: Container(
         // margin: EdgeInsets.only(bottom: 20,),
          width: w,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Card(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 10,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    child: Image(
                      image: NetworkImage(list[index].img_url),
                      height: w - 135,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(right: 10,left: 10,bottom: 20),
                //color: Colors.red,
                width: w+120,
                child: Text(
                  list[index].title,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 16,fontFamily: 'b',color: Colors.black,),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),

                child: Text(
                  list[index].price.toString() + ' تومان',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 16,fontFamily: 'b',color: Colors.black,),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget newProductList(BuildContext context, int index) {
    return ProductView(index, new_product);
  }

  Widget orderProductList(BuildContext context, int index) {
    return ProductView(index, order_product);
  }
}