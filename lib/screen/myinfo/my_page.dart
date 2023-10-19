import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grip/api/ApiService.dart';
import 'package:grip/common/widget/drawer/drawer.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/common/widget/w_line.dart';
import 'package:grip/main.dart';
import 'package:grip/screen/myinfo/alarm/fragment/f_alarm.dart';
import 'package:grip/screen/myinfo/login.dart';
import 'package:grip/screen/myinfo/vo/vo_account.dart';
import 'package:grip/screen/myinfo/widget/like/w_my_like_content.dart';
import 'package:grip/screen/myinfo/widget/myinfo/w_my_info.dart';
import 'package:grip/screen/myinfo/widget/review/widget/detail/w_review_detail.dart';
import 'package:grip/screen/myinfo/widget/review/widget/w_review_management.dart';
import 'package:grip/screen/myinfo/widget/signout/w_sign_out.dart';
import 'package:grip/util/Singleton.dart';
import 'package:grip/util/util.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/color/AppColors.dart';
import '../category/content_detail.dart';
import '../community/community_register.dart';
import 'account_repository.dart';
import 'find_account.dart';
import 'join.dart';
import 'myinfo.dart';
import 'widget/editMyInfo/widget/w_edit_myinfo.dart';
import 'widget/myinfo/reservation/f_reservation_history.dart';

/*class Login extends StatefulWidget {
  Login({required this.voidCallback, Key? key}) : super(key: key);
  VoidCallback voidCallback;

  @override
  State createState() {
    return LoginStateLess();
  }

  static const String route = '/myinfo/login';
}*/

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(),
        child: Navigator(
          key: myInfoKey,
          initialRoute: '/',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;

            switch (settings.name) {
              case route :
              case Login.route :
                print("MyPage route");

                final accountIdx = Singleton().getAccountIdx();
                if (accountIdx > 0) {
                  builder = (BuildContext _) {
                    return const MyInfoWidget();
                  };
                } else {
                  builder = (BuildContext _) {
                    return Login();
                  };
                }
                break;

              /*case Login.route:
                builder = (BuildContext _) {

                  return Login(voidCallback: () {
                    print("Login.route Login.route Login.route");
                    myInfoKey.currentState!.pushReplacementNamed("/");

                  },);
                };
                break;*/

              case Join.route:
                builder = (BuildContext _) {
                  return const Join();
                };
                break;

              case FindAccount.route:
                builder = (BuildContext _) {
                  return const FindAccount();
                };
                break;

              case AlarmFragment.route:
                builder = (BuildContext _) => const AlarmFragment();
                break;

              case ReservationHistory.route:
                builder = (BuildContext _) => const ReservationHistory();
                break;

              case EditMyInfo.route:
                builder = (BuildContext _) => const EditMyInfo();
                break;

              case SignOut.route:
                builder = (BuildContext _) => const SignOut();

              case ReviewManagement.route:
                builder = (BuildContext _) => const ReviewManagement();
                break;

              case ReviewDetail.route:
                builder = (BuildContext _) {
                  final vo = (settings.arguments as Map)['vo'];
                  final viewModel = (settings.arguments as Map)['viewModel'];

                  return ReviewDetail(viewModel, vo);
                };
                break;

              case CommunityResister.routeOnMyPage:
                builder = (BuildContext _) => const CommunityResister();
                break;

              case MyLikeContent.route:
                builder = (BuildContext _) => const MyLikeContent();
                break;

              case ContentDetail.route:
                builder = (BuildContext _) {
                  //final path = "마이페이지 > 리뷰관리 >  ";
                  final path = (settings.arguments as Map)['path'];
                  final contentIdx = (settings.arguments as Map)['contentIdx'];
                  return ContentDetail(
                      path: path, contentIdx: int.parse(contentIdx.toString()));
                };

              case DrawerWidget.route:
                builder = (BuildContext _) => const DrawerWidget();

                break;

              default:
                builder = (BuildContext _) => const MyPage();
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          },
        ));
  }
}


