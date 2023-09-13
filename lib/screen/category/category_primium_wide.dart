import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/screen/category/vo/vo_category_content.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../model/content_model.dart';
import 'category_viewmodel.dart';

class CategoryWideBody extends StatelessWidget {
  final CategoryViewModel viewModel;

  const CategoryWideBody({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }

  Widget buildList(List<CategoryContentVO>? list) {
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
          return Container(
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
                          SizedBox(
                            width: double.infinity,
                            child:
                                list[position].content_title.text.bold.make(),
                          ).pOnly(left: 10),
                          SizedBox(
                            width: double.infinity,
                            child: list[position]
                                .content_description
                                .text
                                .bold
                                .make(),
                          ).pOnly(left: 10)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ).pSymmetric(h: 10, v: 10);
        },
      );
    }
  }
}
