import 'package:flutter/material.dart';
import 'package:jarllan/Services/product.dart';

class Selectedproduct extends StatefulWidget {
  final Product product;
  const Selectedproduct({super.key, required this.product});

  @override
  State<Selectedproduct> createState() => _SelectedproductState(product: product);
}

class _SelectedproductState extends State<Selectedproduct> {
  final Product product;
  late double totalAmount;
  int numberOfOrders = 1;

  _SelectedproductState({required this.product});

  @override
  void initState() {
    super.initState();
    totalAmount = product.price;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.lime,
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.limeAccent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: screenHeight * 0.75, // Set height to 75% of the screen height
                width: double.infinity, // Set width to occupy the full screen width
                color: Colors.white, // Set a background color if you want
                child: Image.asset(
                  widget.product.url,
                  fit: BoxFit.cover, // Scale the image to cover the entire container
                ),
              ),
              SizedBox(height: 16.0), // Add some space between the image and the text
              Text(widget.product.productName),
              Text(widget.product.description),
              SizedBox(height: 16.0), // Add some space before the order controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (numberOfOrders > 1) {
                              numberOfOrders -= 1;
                              totalAmount = product.price * numberOfOrders;
                            }
                          });
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text(
                        numberOfOrders.toString(),
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            numberOfOrders += 1;
                            totalAmount = product.price * numberOfOrders;
                          });
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0), // Add some space at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
