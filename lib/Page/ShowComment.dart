import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddComment(widget.productId)));
                  }),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 5, left: 5, top: 5),
                  padding: EdgeInsets.only(right: 10, left: 10, top: 5),
                  decoration: BoxDecoration(
                    //
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    border: Border.all(width: 2, color: Colors.amber[200]),
                  ),
                  height: 550,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, index) {
                      return commentView(index);
                    },
                    itemCount: showComment.length,
                    scrollDirection: Axis.vertical,
                  ),
                ),

                ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////  Button  /////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddComment(widget.productId)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 2,
                    ),
                    height: 90,
                    width: w - 10,
                    decoration: BoxDecoration(
                      color: Colors.amber[200],
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50)),
                    ),
                    child: Center(
                      child: Text(
                        'ثبت نظر',
                        style: TextStyle(
                          fontFamily: 'b',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////// Widgets ///////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Widget commentView(int index) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.all(
          Radius.circular(40),
          // topLeft: Radius.circular(40),
          // bottomRight: Radius.circular(20),
          // bottomLeft: Radius.circular(20),
        ),
      ),
      width: w,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              right: 10,
              top: 15,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10, bottom: 5),
            child: Row(
              children: [
                Text(
                  'ارسال شده از : ',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 14, color: Colors.yellow[600], fontFamily: 'b'),
                ),
                SizedBox(
                  width: 5,
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
            margin: EdgeInsets.only(right: 10, top: 15),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(bottom: 30, left: 5, right: 5),
            child: Text(
              showComment[index]['content'],
              textAlign: TextAlign.right,
              style:
                  TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'i'),
            ),
          ),
        ],
      ),
    );
  }
}
