import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<String> imgList = [
    'assets/dahon ng saging.jpg',
    'assets/dahonngbayabas.webp',
    'assets/Lagundi.jpg',
    'assets/malunggay.webp',
    'assets/oregano.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: Text(
          'ℒℯ𝒶𝒻 ℰ𝓈𝓈ℯ𝓃𝒸ℯ',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.limeAccent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),  // Back button icon
          onPressed: () {
            Navigator.pushNamed(context, '/login');  // Navigate to Login screen
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to the Dashboard!',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.5,  // Carousel takes half of the screen height
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),  // Interval for auto sliding
                  autoPlayAnimationDuration: Duration(milliseconds: 800),  // Duration of the slide transition
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,  // Fraction of the viewport to show for the images
                ),
                items: imgList.map((item) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),  // Margin between images
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),  // Border radius for the images
                    child: Image.asset(item, fit: BoxFit.cover),
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.limeAccent,  // Set the background color of the BottomAppBar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.black87),  // Set the color of the Menu icon
              onPressed: () {
                Navigator.pushNamed(context, '/menu');
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.black87),  // Set the color of the Profile icon
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
      ),
    );
  }
}
