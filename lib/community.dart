import 'package:flutter/material.dart';

class Community extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CommunitySfw(),
    );
  }
}


class CommunitySfw extends StatefulWidget {
  const CommunitySfw({super.key});

  @override
  State createState() => _CommunitySfw();
}

class _CommunitySfw extends State<CommunitySfw> {

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}