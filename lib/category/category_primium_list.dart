import 'package:flutter/material.dart';

class CategoryListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: CategoryListBodySfw(),
    );
  }
}

class CategoryListBodySfw extends StatefulWidget {
  @override
  State createState() => _CategoryListBodySfw();
}

class _CategoryListBodySfw extends State<CategoryListBodySfw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        color: Colors.black,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Text(
                'GRIP 프리미엄 pro',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildList() {

  }
}
