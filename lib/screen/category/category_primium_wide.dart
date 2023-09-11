import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';


import '../../model/content_model.dart';
import 'category_viewmodel.dart';

class CategoryWideBody extends StatelessWidget {
  final CategoryViewModel viewModel;

  const CategoryWideBody({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: CategoryWideBodySfw(viewModel: viewModel),
    );
  }
}

class CategoryWideBodySfw extends StatefulWidget {
  final CategoryViewModel viewModel;

  const CategoryWideBodySfw({super.key, required this.viewModel});

  @override
  State createState() => _CategoryWideBodySfw(viewModel: viewModel);
}

class _CategoryWideBodySfw extends State<CategoryWideBodySfw> {
  CategoryViewModel viewModel;

  _CategoryWideBodySfw({required this.viewModel});

  int a = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        color: AppColors.black,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'GRIP 프리미엄 pro',
                  style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              width: double.infinity,
              height: 300,
              child: buildList(viewModel.premiumContentList),
            )
          ],
        ),
      ),
    );
  }

  Widget buildList(List<ContentModel>? list) {
    if (list == null || list.isEmpty) {
      return const Center(
        child: Text(
          '조회된 데이터가 없습니다.',
          style: TextStyle(color: AppColors.black),
        ),
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int position) {
          return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 300,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(width: 2.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 3,
                        child: Container(
                          height: double.infinity,
                          color: Colors.grey,
                          child: Image.asset(
                            'assets/images/movie/$position.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          color: AppColors.white,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    list[position].content_title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    list[position].content_description,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
        },
      );
    }
  }
}
