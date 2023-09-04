import 'package:flutter/material.dart';

class ReusableRow extends StatelessWidget {
  final String title;
  final String value;
  const ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
          ),
          Text(value)
        ],
      ),
    );
  }
}
