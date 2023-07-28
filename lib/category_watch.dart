import 'package:flutter/material.dart';
import 'package:grip/category/category_primium_list.dart';
import 'package:grip/category/category_primium_wide.dart';
import 'package:grip/category/category_list.dart';

class CategoryWatch extends StatefulWidget {
  final String title;
  final List<String> categoryList;

  const CategoryWatch(this.title, this.categoryList);

  @override
  State createState() => CategoryWatchState();
}

class CategoryWatchState extends State<CategoryWatch> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: createToolbar('${widget.title}'),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: buildHorizontalCategory(widget.categoryList),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: 370,
              child: CategoryWideBody(),
            ),
          ),
          buildCategoryGrid()
          //buildCategoryList(),
        ],
      ),
    );
  }

  SliverList buildCategoryList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Container(
              width: 300,
              height: 10,
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.grey,
                          ),
                          Center(
                            child: Text('000 영상'),
                          )
                        ],
                      )),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.settings)),
                  )
                ],
              ),
            ),
          );
        },
        childCount: 10, // 실제 리스트 아이템의 개수로 바꿔주세요
      ),
    );
  }

  SliverGrid buildCategoryGrid() {
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(1, 1),
                              blurRadius: 0.1,
                              spreadRadius: 0.0)
                        ]),
                        child: Column(
                          children: [
                            Expanded(
                                flex: 8,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 5),
                                  child: Container(
                                    color: Colors.grey,
                                  ),
                                )),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Center(
                                    child: Text('000 모델'),
                                  ),
                                ))
                          ],
                        ),
                      )),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.settings),
                      ))
                ],
              ),
            ),
          );
        }, childCount: 10),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2));
  }

  AppBar createToolbar(String title) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(onPressed: () {
        Navigator.pop(context);
      }, icon: Icon(Icons.chevron_left)),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
      ],
      bottom: PreferredSize(
        child: Container(
          color: Colors.black,
          height: 1.0,
        ),
        preferredSize: Size.fromHeight(4.0),
      ),
    );
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
