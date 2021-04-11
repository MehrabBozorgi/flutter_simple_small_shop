import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_small_online_shop/Model/Product.dart';
import 'package:flutter_small_online_shop/Widget/AppData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'DetailPage.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<Product> new_product = [];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    getProductFromServer('new_product', new_product);

    return SingleChildScrollView(
      child: Column(
        children: [
          //SearchBar
          Container(
            margin: EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white38,
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
                        fontFamily: 'b',
                        fontSize: 16,
                        letterSpacing: 2,
                        color: Colors.grey[900])),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'فروشگاه',
                  style: TextStyle(
                      fontFamily: 'b', fontSize: 18, color: Colors.amber[200]),
                ),
              ],
            ),
          ),
          Container(
            // margin: EdgeInsets.only(top: 20, bottom: 50, right: 10, left: 10),
            height: h,
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 120),
              itemBuilder: newProductList,
              itemCount: new_product.length,
              scrollDirection: Axis.vertical,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////// Widgets ///////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget getProductFromServer(String action, List<Product> list) {
    if (list.length == 0) {
      var url = AppData.server_url + '?action=' + action;
      http.get(url).then((resp) {
        //
        if (resp.statusCode == 200) {
          List jsonResp = convert.jsonDecode(resp.body);
          //
          for (int i = 0; i < jsonResp.length; i++) {
            setState(() {
              //
              list.add(new Product(
                id: int.parse(jsonResp[i]['id']),
                title: jsonResp[i]['title'],
                price: int.parse(jsonResp[i]['price']),
                img_url: jsonResp[i]['img_url'],
                slide_img: jsonResp[i]['slide_img'],
                description: jsonResp[i]['description'],
              ));
              //
            });
          }
        }
      });
    }
  }

  ///////////////////////////////////////////// View ///////////////////////////////////////////////////
  Widget ProductView(int index, List<Product> list) {
    double w = MediaQuery.of(context).size.width - 50;
    double h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(list[index].id)));
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 20, right: 10, left: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(120),
              bottomRight: Radius.circular(120),
            ),
            color: Colors.white38),
        child: Container(
          width: w,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Card(
                color: Colors.indigo[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80),
                  ),
                ),
                elevation: 10,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80),
                      bottomRight: Radius.circular(80),
                    ),
                    child: Image(
                      image: NetworkImage(list[index].img_url),
                      height: w - 135,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(right: 20, left: 10, bottom: 20),
                //color: Colors.red,
                width: w + 120,
                child: Text(
                  list[index].title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'b',
                    color: Colors.grey[900],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Text(
                  list[index].price.toString() + ' تومان',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'b',
                    color: Colors.white,
                  ),
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
}
