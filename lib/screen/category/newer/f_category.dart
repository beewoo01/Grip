import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/screen/category/category_viewmodel.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../main.dart';
import '../category_watch.dart';
import '../content_detail.dart';
import '../reservation.dart';

class NewerCategoryStw extends StatelessWidget {
  const NewerCategoryStw({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(),
        child: Navigator(
          key: categoryKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/':
                builder = (BuildContext _) => const NewerCategory();
                break;

              case CategoryWatch.route:
                builder = (BuildContext _) {
                  final idx = (settings.arguments as Map)['idx'];
                  final subIdx = (settings.arguments as Map)['subIdx'];
                  final title = (settings.arguments as Map)['title'];
                  final list = (settings.arguments as Map)['list'];

                  return CategoryWatch(
                    categoryIdx: idx,
                    subCategoryIdx: subIdx,
                    categoryName: title,
                    categoryList: list,
                  );
                };
                break;

              case ContentDetail.route:
                builder = (BuildContext _) {
                  final root = (settings.arguments as Map)['root'];
                  final idx = (settings.arguments as Map)['content_idx'];
                  print('SpaceRentalDetail.route root $root');
                  return ContentDetail(
                    path: '$root',
                    contentIdx: idx,
                  );
                };
                break;

              case Reservation.route:
                builder = (BuildContext _) {
                  final contentIdx = (settings.arguments as Map)['content_idx'];
                  return Reservation(contentIdx: contentIdx);
                };
                break;

              default:
                builder = (BuildContext _) => const NewerCategory();
            }

            return MaterialPageRoute(builder: builder, settings: settings);
          },
        ));
  }
}

class NewerCategory extends StatefulWidget {
  const NewerCategory({super.key});

  @override
  State<NewerCategory> createState() => _NewerCategoryState();
}

class _NewerCategoryState extends State<NewerCategory> {
  CategoryViewModel viewModel = CategoryViewModel();
  double containerHeight = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [buildCategoryAppbar()],
        ),
      ),
    );
  }

  Widget buildCategoryAppbar() {
    return Column(
      children: [
        height30,
        height30,
        height30,
        Row(
          children: [
            const Flexible(
                child:
                    Image(image: AssetImage("assets/images/sampleBanner.png"))),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.close,
                  color: AppColors.black,
                ))
          ],
        ),
        height30,
        Align(
                alignment: Alignment.centerLeft,
                child: "로그인을 해주세요".text.bold.color(AppColors.black).make())
            .pOnly(left: 20, top: 10),
        const Divider(
          height: 1,
          color: AppColors.black,
        ).pSymmetric(h: 20, v: 10),

        height30,
        buildCategory()
      ],
    );
  }

  Widget buildCategory() {
    return Container(
      width: double.infinity,
      height: containerHeight,
      color: AppColors.black,
      child: Column(
        children: [
          height20,
          Center(child: "카테고리".text.color(AppColors.white).bold.size(20).make()),
          Row(
            children: [
              Expanded(child: "스냅촬영".text.bold.color(AppColors.white).make(), flex: 1,),
              Expanded(child: "영상촬영".text.bold.color(AppColors.white).make(), flex: 1,),
              Expanded(child: "모델".text.bold.color(AppColors.white).make(), flex: 1,),
              Expanded(child: "공간대여".text.bold.color(AppColors.white).make(), flex: 1,)
            ],
          ),
          TextButton(
              onPressed: () {},
              child: "전체보기".text.color(AppColors.white).bold.make())
        ],
      ),
    );
  }
}


class SubCategoryListWidget extends StatelessWidget {
  CategoryViewModel viewModel;
  SubCategoryListWidget(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: viewModel.selectCategory(), builder: (builder, snapShot) {
          return ListView.builder(itemBuilder: (BuildContext context, int position) {
            return Row(
              children: [

              ],
            );
          });
    });
  }
}

