import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<String> productName = [
    'Banana',
    'Grapes',
    'Mango',
    'Orange',
    'Pineapple',
    'Pomegranate',
    'Strawberry',
    'Watermelon'
  ];
  List<String> productUnit = [
    'Dozen',
    'KG',
    'KG',
    'Dozen',
    'KG',
    'KG',
    'KG',
    'KG'
  ];
  List<int> productPrice = [10, 13, 21, 15, 19, 27, 18, 23];
  List<String> productImages = [
    'assets/images/banana.png',
    'assets/images/grapes.png',
    'assets/images/mango.png',
    'assets/images/orange.png',
    'assets/images/pineapple.png',
    'assets/images/pomegranate.png',
    'assets/images/strawberry.png',
    'assets/images/watermelon.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        centerTitle: true,
        actions: const [
          badge.Badge(
            badgeContent: Text(
              '1',
              style: TextStyle(color: Colors.white),
            ),
            child: Icon(Icons.shopping_bag_outlined),
          ),
          SizedBox(
            width: 12,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: productName.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset(
                              productImages[index],
                              height: 80,
                              width: 80,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productName[index],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${productUnit[index]} \$${productPrice[index]}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: const Center(
                                          child: Text('Add to Cart')),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
