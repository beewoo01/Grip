import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/common/widget/w_height_and_width.dart';
import 'package:grip/common/widget/w_line.dart';
import 'package:grip/main.dart';
import 'package:grip/screen/myinfo/find_account.dart';
import 'package:grip/screen/myinfo/join.dart';
import 'package:grip/screen/myinfo/login.dart';
import 'package:grip/screen/myinfo/widget/myinfo/w_myinfo.dart';
import 'package:grip/util/Singleton.dart';
import 'package:velocity_x/velocity_x.dart';

import 'alarm/fragment/f_alarm.dart';
import 'widget/myinfo/reservation/f_reservation_history.dart';

class MyInfo extends StatelessWidget {
  MyInfo({super.key});

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


              case Login.route:
                builder = (BuildContext _) {

                  return Login(voidCallback: () {
                    print("Login.route Login.route Login.route");
                    myInfoKey.currentState!.pushReplacementNamed("/");

                  },);
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
                  return ReservationHistory();
                };
                break;

              default:
                builder = (BuildContext _) => Login(voidCallback: (){

                },);
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
              navigate(context, Login.route, isRootNavigator: false, arguments: {});
              //navigate(context, AlarmFragment.route, isRootNavigator: false, arguments: {});
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
