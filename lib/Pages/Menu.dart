import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jarllan/Pages/SelectedProduct.dart';
import 'package:jarllan/Services/product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late Future<List<dynamic>> products;

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.194.25:8080/api/v1/product/all'));
    final data = jsonDecode(response.body);
    List products = <Product>[];
    for (var product in data) {
      products.add(Product.fromJson(product));
    }
    return products;
  }

  @override
  void initState() {
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard');  // Navigate to the dashboard
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
        child: FutureBuilder(
          future: products,
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitWaveSpinner(
                  color: Colors.blueAccent,
                  size: 90.0,
                ),
              );
            }
            if (snapshots.hasData) {
              List products = snapshots.data!;
              return Padding(
                padding: EdgeInsets.all(3.0),
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.lime,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[index].productName,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 25.0,
                              ),
                            ),
                            Text(
                              products[index].price.toString(),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15.0,
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Selectedproduct(product: products[index]),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            }

            return Center(
              child: Text('Unable to load data'),
            );
          },
        ),
      ),
    );
  }
}
