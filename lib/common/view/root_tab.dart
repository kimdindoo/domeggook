import 'package:domeggook/common/const/color.dart';
import 'package:domeggook/common/layout/defalut_layout.dart';
import 'package:domeggook/product/view/category_screen.dart';
import 'package:domeggook/product/view/product_screen.dart';
import 'package:domeggook/product/view/product_search_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  static String get routeName => '/';

  final int initialIndex; // 초기 선택 탭

  const RootTab({super.key, this.initialIndex = 0});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;

  int index = 0;

  @override
  void initState() {
    super.initState();

    index = widget.initialIndex; // 초기 인덱스 설정

    controller = TabController(length: 3, vsync: this, initialIndex: index);

    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    controller.dispose();
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      // title: '도매꾹',
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: '카테고리'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_outline),
          //   label: '프로필',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.access_time),
          //   label: '최근 본 게시물',
          // ),
        ],
      ),
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: [ProductScreen(), CategoryScreen(), ProductSearchScreen()],
      ),
    );
  }
}
