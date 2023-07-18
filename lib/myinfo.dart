import 'package:flutter/material.dart';

class MyInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyInfoSfw(),
    );
  }
}

class MyInfoSfw extends StatefulWidget {
  const MyInfoSfw({super.key});

  @override
  State createState() => _MyInfoSfw();
}

class _MyInfoSfw extends State<MyInfoSfw> {

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}