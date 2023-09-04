import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:provider/provider.dart';
import 'package:provider_shopping_cart/helper/database_helper.dart';
import 'package:provider_shopping_cart/model/product_model.dart';
import 'package:provider_shopping_cart/provider/cart_provider.dart';
import 'package:provider_shopping_cart/views/cart_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  DBHelper? dbHelper = DBHelper();

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
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: Center(
              child: badge.Badge(
                badgeContent:
                    Consumer<CartProvider>(builder: (context, value, child) {
                  return Text(
                    value.getCounter().toString(),
                    style: const TextStyle(color: Colors.white),
                  );
                }),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
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
                                    child: InkWell(
                                      onTap: () {
                                        dbHelper!
                                            .insert(CartModel(
                                                id: index,
                                                productId: index.toString(),
                                                productName: productName[index]
                                                    .toString(),
                                                initialPrice:
                                                    productPrice[index],
                                                productPrice:
                                                    productPrice[index],
                                                quantity: 1,
                                                unitTag: productUnit[index]
                                                    .toString(),
                                                image: productImages[index]
                                                    .toString()))
                                            .then((value) {
                                          if (kDebugMode) {
                                            print('Product added to cart');
                                          }
                                          cartProvider.addTotalPrice(
                                              double.parse(productPrice[index]
                                                  .toString()));
                                          cartProvider.addCounter();
                                        }).onError((error, stackTrace) {
                                          if (kDebugMode) {
                                            print(error.toString());
                                          }
                                        });
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: const Center(
                                            child: Text('Add to Cart',
                                                style: TextStyle(
                                                    color: Colors.white))),
                                      ),
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
