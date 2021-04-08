import 'package:flutter/material.dart';
import 'package:flutter_small_online_shop/Widget/Slider1.dart';
import 'package:http/http.dart'as http;
import 'dart:convert'as convert;

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {





  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Slider1(),



        ],
      ),

    );
  }
}

