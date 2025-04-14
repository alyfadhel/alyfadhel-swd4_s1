import 'package:flutter/material.dart';

class ShopHomeScreen extends StatelessWidget {
  const ShopHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'ShopHome Screen',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
