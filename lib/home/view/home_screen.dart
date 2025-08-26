import 'package:domeggook/config/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) =>
                    //         const RootTab(initialIndex: 2), // 2번 탭 = 검색
                    //   ),
                    // );

                    GoRouter.of(context).pushNamed(RouteNames.productSearch);
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
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        Expanded(
                          child: AbsorbPointer(
                            // TextField 클릭 방지
                            child: TextField(
                              readOnly: true,
                              decoration: const InputDecoration(
                                // hintText: "검색어를 입력하세요",
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                        const Icon(Icons.search, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                // actions: [
                //   IconButton(
                //     icon: const Icon(Icons.shopping_cart_outlined),
                //     onPressed: () {
                //       // 장바구니 아이콘 클릭 시 동작
                //     },
                //   ),
                // ],
              ),
              SliverPersistentHeader(pinned: true, delegate: TabBarDelegate()),
              SliverFillRemaining(
                child: TabBarView(
                  children: [
                    Center(child: Text('홈 화면')),
                    Center(child: Text('1688상품권 화면')),
                    Center(child: Text('이벤트 화면')),
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
  const TabBarDelegate();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      child: TabBar(
        tabs: [
          Tab(child: const Text('홈')),
          Tab(child: const Text('1688상품권')),
          Tab(child: const Text('이벤트')),
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
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
