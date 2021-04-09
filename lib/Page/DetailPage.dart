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
    return Scaffold(
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
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              height: 260,
              child: PageView.builder(
                  itemBuilder: (context, position) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10,left: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                                color: Colors.red),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(40),
                                  bottomLeft: Radius.circular(40)),
                              child: Image(
                                  image: NetworkImage(slide_img0),
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10,left: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                                color: Colors.red),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(40),
                                  bottomLeft: Radius.circular(40)),
                              child: Image(
                                  image: NetworkImage(slide_img1),
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10,left: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                                color: Colors.red),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(40),
                                  bottomLeft: Radius.circular(40)),
                              child: Image(
                                  image: NetworkImage(slide_img2),
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10,left: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                                color: Colors.red),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(40),
                                  bottomLeft: Radius.circular(40)),
                              child: Image(
                                  image: NetworkImage(slide_img3),
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: 4),
            ),
            // Text(title),
            // Text(description),
          ],
        ),
      ),
    );
  }

/////////////////////////////////////
////////// Widgets //////////////////
/////////////////////////////////////

// Widget SliderImage() {
//   return Column(
//     children: [
//       Image(
//         image: NetworkImage(slide_img0),
//       ),
//       Image(
//         image: NetworkImage(slide_img1),
//       ),
//       Image(
//         image: NetworkImage(slide_img2),
//       ),
//       Image(
//         image: NetworkImage(slide_img3),
//       ),
//     ],
//   );
// }
}
