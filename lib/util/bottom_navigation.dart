import 'package:flutter/material.dart';
import 'package:grip/common/color/AppColors.dart';
import 'package:grip/util/tap_item.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
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
      selectedItemColor: AppColors.black,
      unselectedItemColor: AppColors.black,
    );
  }

  BottomNavigationBarItem buildItem(IconData iconData, TabItem tabItem) {
    return BottomNavigationBarItem(icon: Icon(iconData), label: tabItem.tap);
  }
}
