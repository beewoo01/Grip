import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grip/category/category_primium_list.dart';
import 'package:grip/category/category_primium_wide.dart';
import 'package:grip/category/category_list.dart';
import 'package:grip/category/space_rental_detail.dart';
import 'package:grip/main.dart';

class CategoryWatch extends StatefulWidget {
  final String title;
  final List<String> categoryList;

  const CategoryWatch(
      {Key? key, required this.title, required this.categoryList})
      : super(key: key);

  static const String route = '/category/watch/detail';

  @override
  State createState() => CategoryWatchState();
}

class CategoryWatchState extends State<CategoryWatch> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    print('this is CategoryWatchState');
    print(widget.title);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: createToolbar('${widget.title}'),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
                child: buildHorizontalCategory(widget.categoryList),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                width: double.infinity,
                height: 370,
                child: CategoryWideBody(),
              ),
            ),
            //buildCategoryGrid(),
            buildCategoryList(),
            //buildSampleCategoryList()
          ],
        ),
      ),
    );
  }

  SliverList buildSampleCategoryList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
      return SizedBox(
        width: 300,
        height: 200,
        child: Stack(
          children: [
            Positioned(
                child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey,
                )
              ],
            ))
          ],
        ),
      );
    }));
  }

  SliverList buildCategoryList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: GestureDetector(
              onTap: () {
                navigate(context, SpaceRentalDetail.route, isRootNavigator: false, arguments: {});
              },
              child: Container(
                width: 300,
                height: 250,
                decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(1, 1),
                      blurRadius: 0.1,
                      spreadRadius: 0.0)
                ]),
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: Container(
                                width: double.infinity,
                                height: 200,
                                color: Colors.grey,
                                child: Image.asset('assets/images/movie/$index.jpg', fit: BoxFit.fill,),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Center(
                                child: Text('000 영상'),
                              ),
                            )
                          ],
                        )),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                          onPressed: () {}, icon: SvgPicture.asset('assets/images/heart.svg')),
                    )
                  ],
                ),
              ),
            )
            ,
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
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
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
                                  padding: const EdgeInsets.only(
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
                                  child: const Center(
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
                        icon: SvgPicture.asset('assets/images/category.svg'),
                      ))
                ],
              ),
            ),
          );
        }, childCount: 10),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2));
  }

  AppBar createToolbar(String title) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.black,
          )),
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/images/category.svg')),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          color: Colors.black,
          height: 1.0,
        ),
      ),
    );
  }

  Widget buildHorizontalCategory(List<String> list) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              alignment: Alignment.center,
              child: Text(list[index]),
            ),
          );
        });
  }
}
