import 'package:flutter/material.dart';
import 'package:grip/util/tap_item.dart';

class BottomNavigation2 extends StatelessWidget {
  const BottomNavigation2(
      {super.key, required this.currentTab, required this.onSelectTab});

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        buildItem(Icons.abc, TabItem.CATEGORY),
        buildItem(Icons.abc, TabItem.PROMOTION),
        buildItem(Icons.abc, TabItem.HOME),
        buildItem(Icons.abc, TabItem.COMMUNITY),
        buildItem(Icons.abc, TabItem.MyINFO)
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
      currentIndex: currentTab.index,
      unselectedFontSize: 8,
      selectedFontSize: 8,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
    );
  }

  BottomNavigationBarItem buildItem(IconData iconData, TabItem tabItem) {
    return BottomNavigationBarItem(icon: Icon(iconData), label: tabItem.tap);
  }
}
