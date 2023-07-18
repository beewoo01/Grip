import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CategorySfw(),
    );
  }
}

class CategorySfw extends StatefulWidget {
  const CategorySfw({super.key});

  @override
  State createState() => _CategorySfw();
}

class _CategorySfw extends State<CategorySfw> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Category'),
    );
  }
}