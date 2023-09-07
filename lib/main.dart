import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grip/home/home.dart';
import 'package:grip/category/category.dart';
import 'package:grip/community/community.dart';
import 'package:grip/myinfo/account_repository.dart';
import 'package:grip/myinfo/myinfo.dart';
import 'package:grip/promotion/promotion.dart';
import 'package:grip/sample.dart';
import 'package:grip/util/bottom_navigation.dart';
import 'package:grip/util/menu_item.dart';
import 'package:grip/util/tap_item.dart';
import 'package:grip/myinfo/login.dart';
import 'package:provider/provider.dart';
import 'category/category_viewmodel.dart';

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

Future<void> navigate(
    BuildContext context, String route, {bool isDialog = false, bool isRootNavigator = true, Map<String, dynamic>? arguments}
    ) => Navigator.of(context, rootNavigator: isRootNavigator).pushNamed(route, arguments: arguments);

final homeKey = GlobalKey<NavigatorState>();
final categoryKey = GlobalKey<NavigatorState>();
final promotionKey = GlobalKey<NavigatorState>();
final communityKey = GlobalKey<NavigatorState>();
final myInfoKey = GlobalKey<NavigatorState>();
final NavbarNotifier _navbarNotifier = NavbarNotifier();

class NavBarHandler extends StatefulWidget {
  const NavBarHandler({Key? key}) : super(key: key);
  static const String route = '/';

  @override
  State<StatefulWidget> createState() => _NavBarHandlerState();
}

class _NavBarHandlerState extends State<NavBarHandler>
    with SingleTickerProviderStateMixin {
  final _buildBody = <Widget>[
    const Category(),
    const Promotion(),
    const Home(),
    const CommunityMenu(),
    const MyInfo(),
  ];

  final menuItemList = <MenuItem>[
    MenuItem(
        SvgPicture.asset('assets/images/category.svg'), TabItem.CATEGORY.tap),
    MenuItem(
        SvgPicture.asset('assets/images/promotion.svg'), TabItem.PROMOTION.tap),
    MenuItem(SvgPicture.asset('assets/images/home.svg'), TabItem.HOME.tap),
    MenuItem(
        SvgPicture.asset('assets/images/community.svg'), TabItem.COMMUNITY.tap),
    MenuItem(SvgPicture.asset('assets/images/myinfo.svg'), TabItem.MyINFO.tap),
  ];

  @override
  void initState() {
    super.initState();
  }

  DateTime oldTime = DateTime.now();
  DateTime newTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    _navbarNotifier.index = 2;
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
                                  backgroundColor: Colors.white,
                                  icon: menuItem.iconData,
                                  //SvgPicture.asset('assets/images/home.svg'),
                                  //Image.asset('assets/images/sample2.png'),//Icon(menuItem.iconData),
                                  label: menuItem.text,
                                ))
                            .toList(),
                        onTap: (index) {
                          if (_navbarNotifier.index == index) {
                            _navbarNotifier.popAllRoutes(index);
                          } else {
                            _navbarNotifier.index = index;
                          }
                        },
                        unselectedItemColor: Colors.black,
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

class NavbarNotifier extends ChangeNotifier {
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
          myInfoKey.currentState!.popUntil((route) => route.isFirst);
        }
        return;
      default:
        break;
    }
  }
}
