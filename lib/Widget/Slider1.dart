// import 'package:flutter/material.dart';
// import 'package:flutter_small_online_shop/Model/Product.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;
// import 'AppData.dart';
//
// class Slider1 extends StatefulWidget {
//   int productId;
//
//   Slider1(int productId) {
//     productId = productId;
//   }
//
//   @override
//   _Slider1State createState() => _Slider1State(productId);
// }
//
// class _Slider1State extends State<Slider1> {
//   String slide_img0 = '';
//   String slide_img1 = '';
//   String slide_img2 = '';
//   String slide_img3 = '';
//
//   List<Product>product=[];
//
//   _Slider1State(productId) {
//     String url = AppData.server_url +
//         '?action=getProductData&id=' +
//         productId.toString();
//
//     http.get(url).then((resp) {
//       if (resp.statusCode == 200) {
//         dynamic jsonResp = convert.jsonDecode(resp.body);
//
//         setState(() {
//           slide_img0 = jsonResp[product]['slide_img0'];
//           slide_img1 = jsonResp[product]['slide_img1'];
//           slide_img2 = jsonResp[product]['slide_img2'];
//           slide_img3 = jsonResp[product]['slide_img3'];
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 282,
//       child: PageView.builder(
//           itemBuilder: (context, position) {
//             return SingleChildScrollView(
//                 scrollDirection: Axis.horizontal, child: ListViewView(position));
//           },
//           scrollDirection: Axis.horizontal,
//           itemCount: product.length),
//     );
//   }
//
//   /////////////////////////////////////
//   ////////// Widgets //////////////////
//   /////////////////////////////////////
//
//   Widget ListViewView(int index) {
//     return Row(
//       children: [
//         Container(
//           // margin: EdgeInsets.only(right: 10, left: 10),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(50),
//                 bottomRight: Radius.circular(50),
//               ),
//               color: Colors.red),
//           child: ClipRRect(
//             borderRadius: BorderRadius.only(
//               topRight: Radius.circular(50),
//               bottomRight: Radius.circular(50),
//             ),
//             child: Image(
//               image: NetworkImage(slide_img0),
//               fit: BoxFit.fitWidth,
//             ),
//           ),
//         ),
//         Container(
//           child: Image(
//             image: NetworkImage(product[index].slide_img1),
//             fit: BoxFit.fitWidth,
//           ),
//         ),
//         Container(
//           child: Image(
//             image: NetworkImage(slide_img2),
//             fit: BoxFit.fitWidth,
//           ),
//         ),
//         Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(50),
//                 topLeft: Radius.circular(50),
//               ),
//               color: Colors.red),
//           child: ClipRRect(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(50),
//               topLeft: Radius.circular(50),
//             ),
//             child: Image(image: NetworkImage(slide_img3), fit: BoxFit.fitWidth),
//           ),
//         ),
//       ],
//     );
//   }
// }
