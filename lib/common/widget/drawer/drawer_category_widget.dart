import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:grip/common/widget/w_loading.dart';
import 'package:grip/model/pair.dart';
import 'package:grip/model/sub_category_model.dart';
import 'package:grip/screen/category/category_viewmodel.dart';
import 'package:velocity_x/velocity_x.dart';

class DrawerCategoryWidget extends StatefulWidget {
  const DrawerCategoryWidget({super.key});

  @override
  State<DrawerCategoryWidget> createState() => _DrawerCategoryWidgetState();
}

class _DrawerCategoryWidgetState extends State<DrawerCategoryWidget> {
  CategoryViewModel categoryViewModel = CategoryViewModel();
  bool isFullOpen = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: categoryViewModel.selectCategory(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }

          if (snapShot.hasData) {
            return SizedBox(
              width: double.infinity,
              child: buildCategoryWidget(),
            ).pOnly(top: 20);
          }

          return Container();
        });
  }

  Widget buildCategoryWidget() {
    return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i in categoryViewModel.categoryMap!.entries)
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          i.value.text
                              .color(Colors.white)
                              .center
                              .size(16)
                              .bold
                              .make()
                              .pOnly(right: 5),
                          for (var j
                              in categoryViewModel.subCategoryMap!.entries)
                            if (i.key == j.key) ...[
                              if (isFullOpen) ...[
                                for (var p in j.value)
                                  Column(
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          child: p.secend
                                              .toString()
                                              .text
                                              .center
                                              .ellipsis
                                              .maxLines(1)
                                              .color(Colors.white)
                                              .bold
                                              .size(5)
                                              .make())
                                    ],
                                  )
                              ] else ...[
                                for (int p = 0;
                                    p < j.value.length && p < 4;
                                    p++)
                                  Column(
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          child: j.value[p].secend
                                              .toString()
                                              .text
                                              .center
                                              .ellipsis
                                              .maxLines(1)
                                              .color(Colors.white)
                                              .bold
                                              .size(5)
                                              .make())
                                    ],
                                  )
                              ]
                            ],
                        ],
                      )),
              ],
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    isFullOpen = !isFullOpen;
                  });
                },
                child: (isFullOpen?
                "접기" : "전체보기")
                    .text
                    .color(Colors.white)
                    .size(12)
                    .bold
                    .make()
                    .pSymmetric(v: 10)
            )
          ],
        ));
  }
}
