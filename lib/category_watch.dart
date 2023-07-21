import 'package:flutter/material.dart';
import 'package:grip/category/category_primium_list.dart';

class CategoryWatch extends StatelessWidget {
  final String title;
  final List<String> categoryList;

  const CategoryWatch(this.title, this.categoryList);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: CategoryWatchSfw(title, categoryList),
    );
  }
}

class CategoryWatchSfw extends StatefulWidget {
  final String title;
  final List<String> categoryList;

  const CategoryWatchSfw(this.title, this.categoryList);

  @override
  State createState() => _CategoryWatchSfw();
}

class _CategoryWatchSfw extends State<CategoryWatchSfw> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: createToolbar('${widget.title}'),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: buildHorizontalCategory(widget.categoryList),
              ),

              Container(
                width: double.infinity,
                height: 500,
                child: CategoryListBody(),
              )

            ],
          ),
        ),
      ),
    );
  }

  AppBar createToolbar(String title) {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.chevron_left)),
            Text(
              title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          ],
        ));
  }

  Widget buildHorizontalCategory(List<String> list) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              alignment: Alignment.center,
              child: Text('${list[index]}'),
            ),
          );
        });
  }
}
