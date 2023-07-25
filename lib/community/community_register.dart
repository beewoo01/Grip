import 'package:flutter/material.dart';

class CommunityResister extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: CommunityResisterSfw(),
    )
  }
}

class CommunityResisterSfw extends StatefulWidget {

  @override
  State createState() => CommunityResister()
}

class CommunityResister extends State<CommunityResisterSfw> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(

        ),
      ),
    )
  }
}