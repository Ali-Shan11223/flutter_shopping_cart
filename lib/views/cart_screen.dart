import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badge;
import 'package:provider_shopping_cart/helper/database_helper.dart';
import 'package:provider_shopping_cart/model/product_model.dart';
import 'package:provider_shopping_cart/widgets/reUsable_row.dart';
import '../provider/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
        actions: [
          badge.Badge(
            badgeContent:
                Consumer<CartProvider>(builder: (context, value, child) {
              return Text(
                value.getCounter().toString(),
                style: const TextStyle(color: Colors.white),
              );
            }),
            child: const Icon(Icons.shopping_bag_outlined),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: cartProvider.getData(),
              builder: (context, AsyncSnapshot<List<CartModel>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                  
                } else {
                  return Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data!;
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Image.asset(
                                      data[index].image.toString(),
                                      height: 80,
                                      width: 80,
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data[index]
                                                    .productName
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  dbHelper!
                                                      .delete(data[index].id!);
                                                  cartProvider.removeCounter();
                                                  cartProvider.removeTotalPrice(
                                                      double.parse(data[index]
                                                          .productPrice
                                                          .toString()));
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            '${data[index].unitTag} \$${data[index].productPrice}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: InkWell(
                                              onTap: () {},
                                              child: Container(
                                                height: 30,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6)),
                                                child: const Center(
                                                    child: Text('Add to Cart',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white))),
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
                          }));
                }
              }),
          Consumer<CartProvider>(builder: (context, value, child) {
            return Visibility(
              visible: value.getTotalPrice().toString() == '0.0' ? false : true,
              child: Column(
                children: [
                  ReusableRow(
                      title: 'SubTotal',
                      value: value.getTotalPrice().toString()),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
