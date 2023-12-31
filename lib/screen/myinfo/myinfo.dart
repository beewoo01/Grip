import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/common/widget/w_line.dart';
import 'package:grip/main.dart';
import 'package:grip/screen/category/content_detail.dart';
import 'package:grip/screen/community/community_register.dart';
import 'package:grip/screen/myinfo/find_account.dart';
import 'package:grip/screen/myinfo/join.dart';
import 'package:grip/screen/myinfo/my_page.dart';
import 'package:grip/screen/myinfo/widget/editMyInfo/widget/w_edit_myinfo.dart';
import 'package:grip/screen/myinfo/widget/like/w_my_like_content.dart';
import 'package:grip/screen/myinfo/widget/myinfo/w_my_info.dart';
import 'package:grip/screen/myinfo/widget/review/viewModel/vm_review.dart';
import 'package:grip/screen/myinfo/widget/review/widget/w_review_management.dart';
import 'package:grip/screen/myinfo/widget/signout/w_sign_out.dart';
import 'package:grip/util/Singleton.dart';
import 'package:velocity_x/velocity_x.dart';

import 'alarm/fragment/f_alarm.dart';
import 'login.dart';
import 'widget/myinfo/reservation/f_reservation_history.dart';
import 'widget/review/vo/vo_wrote_review.dart';
import 'widget/review/widget/detail/w_review_detail.dart';

class MyInfo extends StatelessWidget {
  const MyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    print("MyInfo build");
    return Theme(
        data: ThemeData(),
        child: Navigator(
          key: myInfoKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;

            switch (settings.name) {
              case '/':
                //Singleton().setAccountIdx(2);
                final accountIdx = Singleton().getAccountIdx();
                if(accountIdx > 0) {
                  builder = (BuildContext _) {
                    return const MyInfoWidget();
                  };
                } else {
                  builder = (BuildContext _) {
                    return const MyInfoSfw();
                  };
                }
                break;


              /*case Login.route:
                builder = (BuildContext _) {

                  return Login(*//*voidCallback: () {
                    print("Login.route Login.route Login.route");
                    myInfoKey.currentState!.pushReplacementNamed("/");

                  },*//*);
                };
                break;*/

              case Join.route:
                builder = (BuildContext _) {
                  return const Join();
                };
                break;

              case FindAccount.route :
                builder = (BuildContext _) {
                  return const FindAccount();
                };
                break;

              case AlarmFragment.route :
                builder = (BuildContext _) => const AlarmFragment();
                break;

              case ReservationHistory.route :
                builder = (BuildContext _) => const ReservationHistory();
                break;

              case EditMyInfo.route:
                builder = (BuildContext _) => const EditMyInfo();
                break;


              case SignOut.route :
                builder = (BuildContext _) => const SignOut();

              case ReviewManagement.route :
                builder = (BuildContext _) => const ReviewManagement();
                break;

              case ReviewDetail.route :
                builder = (BuildContext _) {
                  final vo = (settings.arguments as Map)['vo'];
                  final viewModel = (settings.arguments as Map)['viewModel'];

                  return ReviewDetail(viewModel, vo);
                };
                break;

              case CommunityResister.routeOnMyPage :
                builder = (BuildContext _) => const CommunityResister();
                break;

              case MyLikeContent.route :
                builder = (BuildContext _) => const MyLikeContent();
                break;

              case ContentDetail.route :
                builder = (BuildContext _) {
                  //final path = "마이페이지 > 리뷰관리 >  ";
                  final path = (settings.arguments as Map)['path'];
                  final contentIdx = (settings.arguments as Map)['contentIdx'];
                  return ContentDetail(path: path, contentIdx: int.parse(contentIdx.toString()));
                };

                break;


              default:
                builder = (BuildContext _) => Login(/*voidCallback: (){

                },*/);
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          },
        ));
  }
}

class MyInfoSfw extends StatefulWidget {
  const MyInfoSfw({super.key});

  static const String route = '/';

  @override
  State createState() {
    return MyInfoState();
  }
}

class MyInfoState extends State<MyInfoSfw> with WidgetsBindingObserver {

  @override
  void initState() {
    print("MyInfoState initState");
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    print("MyInfoState dispose");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: buildLoginWidget()
    );
  }


  Widget buildLoginWidget() {
    return Login(/*voidCallback: () {

    },*/);
  }

  TextButton buildTextButton(String text, VoidCallback callback) {
    return TextButton(
        onPressed: callback,
        child: Text(
          text,
          style: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              decoration: TextDecoration.underline),
        ));
  }
}
