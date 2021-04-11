import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_small_online_shop/Widget/AppData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AddComment extends StatefulWidget {
  int productId;

  AddComment(this.productId);

  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _comment = '';

  int send = 0;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

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
      home:
        Scaffold(
          backgroundColor: Colors.grey[900],
          body: Center(
            //
            //
            child: Container(
              width: w - 10,
              height: h - 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.all(width: 2, color: Colors.amber[200]),
              ),
              //
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  //
                  child: Container(
                    margin: EdgeInsets.only(right: 20, left: 20, top: 20),
                    child: Column(
                      children: [
                        ///////////////////////////////////////////////////////////////////////////
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          onSaved: (String value) {
                            _name = value;
                            print(value);
                          },
                          validator: (String value) {
                            if (value.trim().isEmpty) {
                              return 'فیلد مورد نظر را پر کنید';
                            }
                          },

                          textDirection: TextDirection.rtl,
                          //
                          decoration: InputDecoration(
                            counterStyle: TextStyle(
                                color: Colors.amber[200],
                                fontSize: 14,
                                fontFamily: 'i'),
                            //
                            labelStyle: TextStyle(
                                color: Colors.amber[200],
                                fontSize: 16,
                                fontFamily: 'b'),
                            labelText: 'نام کاربری',
                            fillColor: Colors.amber[200],
                            //
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.amber[200], width: 3),
                              //
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              ),
                            ),
                            //

                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white38, width: 1),
                              //
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                          ),
                          maxLength: 30,

                          keyboardType: TextInputType.name,
                        ),
                        ///////////////////////////////////////////////////////////////////////////
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          onSaved: (String value) {
                            _email = value;
                            print(value);
                          },
                          validator: (String value) {
                            if (value.trim().isEmpty) {
                              return 'فیلد مورد نظر را پر کنید';
                            }
                          },

                          textDirection: TextDirection.rtl,
                          //
                          decoration: InputDecoration(
                            counterStyle: TextStyle(
                                color: Colors.amber[200],
                                fontSize: 14,
                                fontFamily: 'i'),
                            //
                            labelStyle: TextStyle(
                                color: Colors.amber[200],
                                fontSize: 16,
                                fontFamily: 'b'),
                            labelText: 'ایمیل',
                            fillColor: Colors.amber[200],
                            //
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.amber[200], width: 3),
                              //
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              ),
                            ),
                            //

                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white38, width: 1),
                              //
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                          ),

                          keyboardType: TextInputType.emailAddress,
                        ),
                        ///////////////////////////////////////////////////////////////////////////
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white),

                          onSaved: (String value) {
                            _comment = value;
                            print(value);
                          },
                          validator: (String value) {
                            if (value.trim().isEmpty) {
                              return 'فیلد مورد نظر را پر کنید';
                            }
                          },

                          textDirection: TextDirection.rtl,
                          //
                          decoration: InputDecoration(
                            counterStyle: TextStyle(
                                color: Colors.amber[200],
                                fontSize: 14,
                                fontFamily: 'i'),
                            //
                            labelStyle: TextStyle(
                                color: Colors.amber[200],
                                fontSize: 16,
                                fontFamily: 'b'),
                            labelText: 'دیدگاه شما ...',
                            fillColor: Colors.amber[200],
                            //
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.amber[200], width: 3),
                              //
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                              ),
                            ),
                            //

                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white38, width: 1),
                              //
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                            ),
                          ),
                          maxLength: 500,
                          minLines: 4,
                          maxLines: 8,
                          keyboardType: TextInputType.name,
                        ),
                        ///////////////////////////////////////////////////////////////////////////

                        RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();

                                setState(() {
                                  send = 1;
                                });

                                sendInfo();
                              }
                            },
                            child: Text('ثبت نظر'))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

      ),
    );

  }

  sendInfo() {
    String url = AppData.server_url +
        '?action=add_comment&product_id=' +
        widget.productId.toString();
    http.post(url, body: {
      'name': _name,
      'email': _email,
      'comment': _comment,
    }).then((resp) {
      setState(() {
        print(resp.body);
        send = 0;


        _formKey.currentState.reset();
      });
    });
  }
}
