import 'package:flutter/material.dart';
import 'package:grip/home.dart';
import 'package:grip/category.dart';
import 'package:grip/community/community.dart';
import 'package:grip/myinfo/myinfo.dart';
import 'package:grip/promotion/promotion.dart';
import 'package:grip/sample.dart';
import 'package:grip/util/bottom_navigation.dart';
import 'package:grip/util/tap_item.dart';
import 'package:grip/myinfo/login.dart';

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currentTab = TabItem.HOME;

  void _selectTab(TabItem tabItem) {
    setState(() {
      _currentTab = tabItem;
    });
  }

  void moveAnotherView(TabItem tabItem) {
    print('moveAnotherView');
    print('moveAnotherView ${tabItem.name}');
    setState(() {
      _currentTab = tabItem;
    });
  }

  Widget buildBody() {
    switch (_currentTab) {
      case TabItem.CATEGORY:
        return Category();
      case TabItem.PROMOTION:
        return Promotion();
      case TabItem.HOME:
        return Home();
      case TabItem.COMMUNITY:
        return Community();
      case TabItem.MyINFO:
        return MyInfo(moveAnotherView);
      default:
        print('hello~');
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = <Widget>[
      Category(),
      Promotion(),
      Home(),
      Community(),
      MyInfo(moveAnotherView),
      Login(),
      //Login(),
    ];

    return Scaffold(
        appBar: buildAppBar(),
        //body: widgets[_currentTab.index],
        body: buildBody(),
        bottomNavigationBar: BottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          child: Divider(
            thickness: 1,
            height: 1,
            color: Colors.black,
          ),
          preferredSize: Size.fromHeight(4.0),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 7,
                child: Text(
                  getAppBarTitle(_currentTab.tap),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                )),
            Expanded(
                flex: 3,
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '000님',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () {
                            //Navigator.pop(context);
                            //Community Write에서 pop을 시키니 여기에서 pop한거와 동일하게 작동함
                          },
                        ),
                        flex: 1,
                      )
                    ],
                  ),
                ))
          ],
        ));
  }

  String getAppBarTitle(String tap) {
    if (_currentTab.tap == '홈') {
      return 'GRIP';
    } else if (_currentTab.tap == '카테고리') {
      return '모든 카테고리';
    }
    return tap;
  }
}
