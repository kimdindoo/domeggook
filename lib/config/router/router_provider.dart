import 'package:domeggook/common/view/page_not_found.dart';

import 'package:domeggook/common/view/scaffold_with_nav_bar.dart';
import 'package:domeggook/config/router/route_names.dart';
import 'package:domeggook/product/view/category_product_screen.dart';
import 'package:domeggook/product/view/category_screen.dart';
import 'package:domeggook/product/view/keyword_product_screen.dart';
import 'package:domeggook/product/view/product_detail_screen.dart';
import 'package:domeggook/product/view/product_screen.dart';
import 'package:domeggook/product/view/product_search_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter route(Ref ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/product',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/product',
                name: RouteNames.product,
                builder: (context, state) {
                  return ProductScreen();
                },
                routes: [
                  GoRoute(
                    path: 'productDetail',
                    name: RouteNames.productDetail,
                    builder: (context, state) {
                      return const ProductDetailScreen();
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/category',
                name: RouteNames.category,
                builder: (context, state) {
                  return const CategoryScreen();
                },
                routes: [
                  GoRoute(
                    path: 'categoryProduct',
                    name: RouteNames.categoryProduct,
                    builder: (context, state) {
                      final name =
                          state.uri.queryParameters['name'] ?? 'unknown';
                      final code =
                          state.uri.queryParameters['code'] ?? 'unknown';

                      return CategoryProductScreen(
                        categoryName: name,
                        categoryCode: code,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/productSearch',
                name: RouteNames.productSearch,
                builder: (context, state) {
                  return const ProductSearchScreen();
                },
                routes: [
                  GoRoute(
                    path: 'keywordProduct',
                    name: RouteNames.keywordProduct,
                    builder: (context, state) {
                      final keyword =
                          state.uri.queryParameters['keyword'] ?? 'unknown';

                      return KeywordProductScreen(keyword: keyword);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) =>
        PageNotFound(errMsg: state.error.toString()),
  );
}
