import 'package:domeggook/common/layout/defalut_layout.dart';
import 'package:domeggook/config/router/route_names.dart';
import 'package:domeggook/home/view/home_event_screen.dart';
import 'package:domeggook/home/view/home_main_screen.dart';
import 'package:domeggook/webview/product_1688_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultLayout(
        child: DefaultTabController(
          length: 3,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                snap: false,
                pinned: false,
                floating: false,
                toolbarHeight: 60,
                leading: IconButton(
                  icon: Image.asset(
                    'asset/img/logo/logo.png',
                    width: 32,
                    height: 32,
                  ),
                  onPressed: () {},
                ),
                title: GestureDetector(
                  onTap: () {
                    GoRouter.of(
                      context,
                    ).goNamed(RouteNames.productSearch); // 검색 화면으로 이동
                  },
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Row(
                      children: [
                        SizedBox(width: 8),
                        Expanded(
                          child: AbsorbPointer(
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                        Icon(Icons.search, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: TabBarDelegate(tabController: _tabController),
              ),
              SliverFillRemaining(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    HomeMainScreen(),
                    Product1688Screen(),
                    HomeEventScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;
  const TabBarDelegate({required this.tabController});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: tabController,
        tabs: const [
          Tab(child: Text('홈')),
          Tab(
            child: Text('1688상품관', style: TextStyle(color: Colors.red)),
          ),
          Tab(child: Text('이벤트')),
        ],
        indicatorWeight: 2,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        labelColor: Colors.black,
        indicatorColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }

  @override
  double get maxExtent => 48;
  @override
  double get minExtent => 48;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
