import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/screen/category/category.dart';
import 'package:grip/screen/category/newer/f_category.dart';
import 'package:grip/screen/community/community.dart';
import 'package:grip/screen/home/home.dart';
import 'package:grip/screen/myinfo/account_repository.dart';
import 'package:grip/screen/myinfo/join.dart';
import 'package:grip/screen/myinfo/my_page.dart';
import 'package:grip/screen/myinfo/myinfo.dart';
import 'package:grip/screen/myinfo/widget/editMyInfo/widget/w_edit_myinfo.dart';
import 'package:grip/screen/myinfo/widget/like/w_my_like_content.dart';
import 'package:grip/screen/myinfo/widget/myinfo/reservation/f_reservation_history.dart';
import 'package:grip/screen/myinfo/widget/review/widget/detail/w_review_detail.dart';

//import 'package:grip/screen/myinfo/widget/review/w_review_management.dart';
import 'package:grip/screen/myinfo/widget/review/widget/w_review_management.dart';
import 'package:grip/screen/myinfo/widget/signout/w_sign_out.dart';
import 'package:grip/screen/promotion/promotion.dart';
import 'package:grip/util/menu_item.dart';
import 'package:grip/util/tap_item.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AccountRepository()),
      //ChangeNotifierProvider(create: (_) => CategoryViewModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //static int _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    print('build');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NavBarHandler()
        //const MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
}

Future<void> navigate(BuildContext context, String route,
        {bool isDialog = false,
        bool isRootNavigator = true,
        Map<String, dynamic>? arguments}) =>
    Navigator.of(context, rootNavigator: isRootNavigator)
        .pushNamed(route, arguments: arguments);

final homeKey = GlobalKey<NavigatorState>();
final categoryKey = GlobalKey<NavigatorState>();
final promotionKey = GlobalKey<NavigatorState>();
final communityKey = GlobalKey<NavigatorState>();
final myInfoKey = GlobalKey<NavigatorState>();
NavbarNotifier _navbarNotifier = NavbarNotifier();

void setNotify(int index) {
  //_navbarNotifier.index = index;
  valueChanged!(index);
}

ValueChanged<int>? valueChanged = (value) => {
      if (_navbarNotifier.index == value)
        {_navbarNotifier.popAllRoutes(value)}
      else
        {_navbarNotifier.index = value}
    };

class NavBarHandler extends StatefulWidget {
  const NavBarHandler({Key? key}) : super(key: key);
  static const String route = '/';
  static const int CATEGORY = 0;
  static const int PROMOTION = 1;
  static const int HOME = 2;
  static const int COMMUNITY = 3;
  static const int MY_PAGE = 4;

  @override
  State<StatefulWidget> createState() => _NavBarHandlerState();
}

class _NavBarHandlerState extends State<NavBarHandler>
    with SingleTickerProviderStateMixin {
  final _buildBody = <Widget>[
    const Category(),
    //const NewerCategoryStw(),
    const Promotion(),
    const Home(),
    const CommunityMenu(),
    const MyPage()
  ];

  final menuItemList = <MenuItem>[
    MenuItem(
        Image.asset("assets/images/category_ic.png"), TabItem.CATEGORY.tap),
    MenuItem(
        Image.asset("assets/images/promotion_ic.png"), TabItem.PROMOTION.tap),
    MenuItem(Image.asset("assets/images/home_ic.png"), TabItem.HOME.tap),
    MenuItem(
        Image.asset("assets/images/community_ic.png"), TabItem.COMMUNITY.tap),
    MenuItem(Image.asset("assets/images/myinfo_ic.png"), TabItem.MyINFO.tap),
  ];

  @override
  void initState() {
    super.initState();
  }

  DateTime oldTime = DateTime.now();
  DateTime newTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    _navbarNotifier.index = NavBarHandler.HOME;
    return WillPopScope(
        onWillPop: () async {
          final bool isExitingApp = await _navbarNotifier.onBackButtonPressed();
          if (isExitingApp) {
            newTime = DateTime.now();
            int difference = newTime.difference(oldTime).inMilliseconds;
            oldTime = newTime;
            if (difference < 1000) {
              return isExitingApp;
            } else {
              return false;
            }
          } else {
            return isExitingApp;
          }
        },
        child: Material(
          child: AnimatedBuilder(
            animation: _navbarNotifier,
            builder: (context, snapshot) {
              return Stack(
                children: [
                  IndexedStack(
                    index: _navbarNotifier.index,
                    children: [
                      for (int i = 0; i < _buildBody.length; i++) _buildBody[i]
                    ],
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        items: menuItemList
                            .map((MenuItem menuItem) => BottomNavigationBarItem(
                                  backgroundColor: AppColors.black,
                                  icon: menuItem.iconData,
                                  label: menuItem.text,
                                ))
                            .toList(),
                        onTap: valueChanged,
                        unselectedItemColor: AppColors.black,
                        selectedItemColor: Colors.blue,
                        currentIndex: _navbarNotifier.index,
                        unselectedFontSize: 8,
                        selectedFontSize: 8,
                      )),
                ],
              );
            },
          ),
        ));
  }
}

final class NavbarNotifier extends ChangeNotifier {
  int _index = 0;

  int get index => _index;
  bool _hideBottomNavBar = false;

  set index(int x) {
    _index = x;
    notifyListeners();
  }

  bool get hideBottomNavBar => _hideBottomNavBar;

  set hideBottomNavBar(bool x) {
    _hideBottomNavBar = x;
    notifyListeners();
  }

  FutureOr<bool> onBackButtonPressed() async {
    print('onBackButtonPressed');
    bool exitingApp = true;
    switch (_navbarNotifier.index) {
      case 0:
        if (categoryKey.currentState != null &&
            categoryKey.currentState!.canPop()) {
          categoryKey.currentState!.pop();
          exitingApp = false;
        }
        break;
      case 1:
        if (promotionKey.currentState != null &&
            promotionKey.currentState!.canPop()) {
          promotionKey.currentState!.pop();
          exitingApp = false;
        }
        break;
      case 2:
        if (homeKey.currentState != null && homeKey.currentState!.canPop()) {
          homeKey.currentState!.pop();
          exitingApp = false;
        }
        break;

      case 3:
        if (communityKey.currentState != null &&
            communityKey.currentState!.canPop()) {
          communityKey.currentState!.pop();
          exitingApp = false;
        }
        break;

      case 4:
        if (myInfoKey.currentState != null &&
            myInfoKey.currentState!.canPop()) {
          myInfoKey.currentState!.pop();
          exitingApp = false;
        }
        break;
      default:
        return false;
    }
    if (exitingApp) {
      return true;
    } else {
      return false;
    }
  }

  void popAllRoutes(int index) {
    switch (index) {
      case 0:
        if (categoryKey.currentState!.canPop()) {
          categoryKey.currentState!.popUntil((route) => route.isFirst);
        }
        return;
      case 1:
        if (promotionKey.currentState!.canPop()) {
          promotionKey.currentState!.popUntil((route) => route.isFirst);
        }
        return;
      case 2:
        if (homeKey.currentState!.canPop()) {
          homeKey.currentState!.popUntil((route) => route.isFirst);
        }
        return;
      case 3:
        if (communityKey.currentState!.canPop()) {
          communityKey.currentState!.popUntil((route) => route.isFirst);
        }
        return;
      case 4:
        if (myInfoKey.currentState!.canPop()) {
          myInfoKey.currentState!.popUntil((route) {
            print("myInfoKey.currentWidget?.key.toString()");
            return route.isFirst;
          });
        }
        return;
      default:
        break;
    }
  }
}
