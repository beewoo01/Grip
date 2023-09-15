import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/url/grip_url.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/common/widget/w_line.dart';
import 'package:grip/main.dart';
import 'package:grip/screen/myinfo/find_account.dart';
import 'package:grip/screen/myinfo/join.dart';
import 'package:grip/screen/myinfo/login.dart';
import 'package:grip/screen/myinfo/widget/myinfo/w_myinfo.dart';
import 'package:grip/util/Singleton.dart';
import 'package:grip/util/util.dart';
import 'package:grip/util/tap_item.dart';
import 'package:velocity_x/velocity_x.dart';

import 'alarm/fragment/f_alarm.dart';
import 'widget/myinfo/reservation/f_reservation_history.dart';

//final myInfoKey = GlobalKey<NavigatorState>();
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
                final accountIdx = Singleton().getAccountIdx() ?? 0;
                if(accountIdx > 0) {
                  builder = (BuildContext _) {
                    return const MyInfoWidget();
                  };
                } else {
                  builder = (BuildContext _) {
                    return const MyInfoSfw();
                  };
                }
                /*builder = (BuildContext _) {
                  print("MyInfo Theme /// ");
                  return const MyInfoSfw();
                };*/
                break;
              case Login.route:
                builder = (BuildContext _) {
                  print("Login.route Login.route Login.route");
                  return const Login();
                };
                break;

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
                builder = (BuildContext _) {
                  print("AlarmFragment.route AlarmFragment.route AlarmFragment.route");
                  return const AlarmFragment();
                };
                break;

              case ReservationHistory.route :
                builder = (BuildContext _) {
                  return const ReservationHistory();
                };
                break;

              default:
                builder = (BuildContext _) => const Login();
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
    print("MyInfoSfw createState");
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
      // 앱이 표시되고 사용자 입력에 응답합니다.
      // 주의! 최초 앱 실행때는 해당 이벤트가 발생하지 않습니다.
        print("didChangeAppLifecycleState resumed");
        break;
      case AppLifecycleState.inactive:
      // 앱이 비활성화 상태이고 사용자의 입력을 받지 않습니다.
      // ios에서는 포 그라운드 비활성 상태에서 실행되는 앱 또는 Flutter 호스트 뷰에 해당합니다.
      // 안드로이드에서는 화면 분할 앱, 전화 통화, PIP 앱, 시스템 대화 상자 또는 다른 창과 같은 다른 활동이 집중되면 앱이이 상태로 전환됩니다.
      // inactive가 발생되고 얼마후 pasued가 발생합니다.
        print("didChangeAppLifecycleState inactive");
        break;
      case AppLifecycleState.paused:
      // 앱이 현재 사용자에게 보이지 않고, 사용자의 입력을 받지 않으며, 백그라운드에서 동작 중입니다.
      // 안드로이드의 onPause()와 동일합니다.
      // 응용 프로그램이 이 상태에 있으면 엔진은 Window.onBeginFrame 및 Window.onDrawFrame 콜백을 호출하지 않습니다.
        print("didChangeAppLifecycleState paused");
        break;
      case AppLifecycleState.detached:
      // 응용 프로그램은 여전히 flutter 엔진에서 호스팅되지만 "호스트 View"에서 분리됩니다.
      // 앱이 이 상태에 있으면 엔진이 "View"없이 실행됩니다.
      // 엔진이 처음 초기화 될 때 "View" 연결 진행 중이거나 네비게이터 팝으로 인해 "View"가 파괴 된 후 일 수 있습니다.
        print("didChangeAppLifecycleState detached");
        break;
      case AppLifecycleState.hidden:
        print("didChangeAppLifecycleState detached");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: buildLoginWidget()
    );
  }


  Widget buildLoginWidget() {
    return Column(
      children: [
        height30,
        height10,
        const Line(height: 2,).pSymmetric(h: 10),
        height20,
        Align(
          child: Container(
              width: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.grey,
                border: Border.all(width: 0, color: AppColors.grey),
              ),
              child: "마이페이지".text
                  .color(AppColors.black)
                  .bold
                  .size(16)
                  .make()
                  .pSymmetric(v: 5, h: 10)
          ),
        ),
        height20,
        const Line(height: 2,).pSymmetric(h: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextButton('로그인', () {
              //navigate(context, Login.route, isRootNavigator: false, arguments: {});
              navigate(context, AlarmFragment.route, isRootNavigator: false, arguments: {});
            }),

            buildTextButton('회원가입', () {
              navigate(context, Join.route,
                  isRootNavigator: false, arguments: {});
            }),
          ],
        ),
      ],
    );
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
