import 'package:flutter/material.dart';
import 'package:flutter_small_online_shop/Widget/AppData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'AddComment.dart';

class ShowComment extends StatefulWidget {
  int productId;

  ShowComment(this.productId);

  @override
  _ShowCommentState createState() => _ShowCommentState(productId);
}

class _ShowCommentState extends State<ShowComment> {
  List<dynamic> showComment = [];

  //
  _ShowCommentState(productId) {
    if (showComment.length == 0) {
      String url = AppData.server_url +
          '?action=get_comment&product_id=' +
          productId.toString();

      http.get(url).then((resp) {
        if (resp.statusCode == 200) {
          print('کامنتها کار کرد');
          setState(() {
            showComment = convert.jsonDecode(resp.body);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[700],
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add_comment,
                  color: Colors.white,
                  size: 25,
                ),
                tooltip: 'اضافه کردن نظر',
                onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddComment()));

                }),
          ],
        ),
        backgroundColor: Colors.indigo[700],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10, left: 10),
                padding: EdgeInsets.only(bottom: 120),
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  border: Border.all(width: 2, color: Colors.white),
                ),
                height: h,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, index) {
                    return commentView(index);
                  },
                  itemCount: showComment.length,
                  scrollDirection: Axis.vertical,
                ),
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

  Widget commentView(int index) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.indigo[700],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      // width: w,
      // height: 350,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              right: 10,
              top: 5,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10, bottom: 5),
            child: Row(
              children: [
                Text(
                  'ارسال شده از : ',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey, fontFamily: 'b'),
                ),
                Text(
                  showComment[index]['name'],
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 16, color: Colors.white, fontFamily: 'b'),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10, top: 5),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(bottom: 30, left: 5, right: 5),
            child: Text(
              showComment[index]['content'],
              textAlign: TextAlign.right,
              style:
                  TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'b'),
            ),
          ),
        ],
      ),
    );
  }
}
