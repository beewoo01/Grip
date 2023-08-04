import 'package:flutter/material.dart';
import 'package:grip/main.dart';
import 'package:grip/myinfo/find_account.dart';
import 'package:grip/myinfo/join.dart';
import 'package:grip/myinfo/login.dart';
import 'package:grip/util/util.dart';
import 'package:grip/util/tap_item.dart';

//final myInfoKey = GlobalKey<NavigatorState>();
class MyInfo extends StatelessWidget {
  const MyInfo({super.key});

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
              case '/':
                builder = (BuildContext _) => const MyInfoSfw();
                break;
              case Login.route:
                builder = (BuildContext _) {
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
  State createState() => MyInfoState();
}

class MyInfoState extends State<MyInfoSfw> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: buildLoginWidget(),
      ),
    );
  }

  Widget buildLoginWidget() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 30,
          child: Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {},
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Divider(
            thickness: 2,
            height: 1,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: HexColor.fromHex('#EBEBEB'),
                border:
                    Border.all(width: 0, color: HexColor.fromHex('#EBEBEB')),
              ),
              child: const Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                child: Text(
                  '마이페이지',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16),
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20, right: 10, left: 10),
          child: Divider(
            thickness: 2,
            height: 1,
            color: Colors.black,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextButton('로그인', () {
              navigate(context, Login.route,
                  isRootNavigator: false, arguments: {});
              //widget.onButtonClick(TabItem.LOGIN);
            }),
            buildTextButton('회원가입', () {
              //widget.onButtonClick(TabItem.LOGIN);
              navigate(context, Join.route,
                  isRootNavigator: false, arguments: {});
            }),
          ],
        )
      ],
    );
  }

  TextButton buildTextButton(String text, VoidCallback callback) {
    return TextButton(
        onPressed: callback,
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              decoration: TextDecoration.underline),
        ));
  }
}
