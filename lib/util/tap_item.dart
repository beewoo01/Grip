import 'package:flutter/material.dart';

enum TabItem {
  CATEGORY('카테고리'),
  PROMOTION('프로모션'),
  HOME('홈'),
  COMMUNITY('커뮤니티'),
  MyINFO('내정보'),
  LOGIN('로그인'),
  JOIN('회원가입');

  const TabItem(this.tap);
  final String tap;
}