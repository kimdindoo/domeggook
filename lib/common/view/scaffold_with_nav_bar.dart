import 'package:domeggook/common/const/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: '카테고리'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
        ],
        currentIndex: navigationShell.currentIndex,

        onTap: (int index) => navigationShell.goBranch(
          index,
          initialLocation: true,
        ), // initialLocation: false - 현재 위치 유지, true - 처음 위치로 이동
      ),
    );
  }
}
