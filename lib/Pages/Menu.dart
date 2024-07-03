import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jarllan/Services/MenuCard.dart';
import 'package:jarllan/Services/product.dart';
import 'package:http/http.dart' as http;



class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late Future<List<dynamic>> products;
  Future<List<dynamic>>fetchData() async{
    final response = await http.get(Uri.parse('http://192.168.193.23:8080/products')
    );
      final data = jsonDecode(response.body);
      List products = <Product>[];
      for(var product in data){
        products.add(Product.fromJson(product));
      }
      return products;
      for(var product in products){
        print(product.productName);
      }
      print(response.body);
  }
  @override
  //initState
  void initState() {
    // TODO: implement initState
    super.initState();
     products = fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: Text(
          'Menu',
          style: TextStyle(
            letterSpacing: 3.0,
          ),
        ),
        centerTitle: true,
      ),

    );
  }
}
