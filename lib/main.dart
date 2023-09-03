import 'package:flutter/material.dart';
import 'package:provider_shopping_cart/views/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green,
            titleTextStyle: TextStyle(fontSize: 22, fontFamily: 'Lato'),
            actionsIconTheme: IconThemeData(color: Colors.white)),
        useMaterial3: true,
      ),
      home: const ProductListScreen(),
    );
  }
}
