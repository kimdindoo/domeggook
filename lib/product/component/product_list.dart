import 'package:domeggook/common/skeleton/product_skeleton.dart';
import 'package:domeggook/common/utils/number_utils.dart';
import 'package:domeggook/common/utils/pagination_helper.dart';
import 'package:domeggook/config/router/route_names.dart';
import 'package:domeggook/product/model/product_model.dart';
import 'package:domeggook/product/model/recent_product_model.dart';
import 'package:domeggook/product/provider/recent_product_provider.dart';
import 'package:domeggook/product/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// fetchPage 콜백 타입 정의
typedef ProductFetcher = Future<List<Product>> Function(int pageKey);

class ProductList extends ConsumerStatefulWidget {
  const ProductList({super.key, required this.fetchPage});

  final ProductFetcher fetchPage; // 상품 데이터를 가져오는 함수

  @override
  ConsumerState<ProductList> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {
  // pageSize는 product_repository에서 정의된 limit 사용
  final _paginationHelper = PaginationHelper(pageSize: limit);

  // PagingController 초기화
  late final PagingController<int, Product> _pagingController =
      PagingController(
        getNextPageKey: (state) {
          // 지금까지 가져온 아이템 리스트
          final items = state.items;

          // 마지막 페이지인지 확인
          if (_paginationHelper.isLastPage(items)) {
            return null; // 마지막 페이지면 다음 페이지 없음
          }

          // 다음 페이지 키 계산 (기본 1부터 시작)
          return (state.keys?.last ?? 0) + 1;
        },
        fetchPage: (pageKey) => widget.fetchPage(pageKey),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        // 당겨서 새로고침 기능
        onRefresh: () async {
          _paginationHelper.reset(); // PaginationHelper 초기화
          _pagingController.refresh(); // PagingController 새로고침
        },
        child: PagingListener(
          controller: _pagingController,
          builder: (context, state, fetchNextPage) => Container(
            color: Colors.white,
            child: PagedListView<int, Product>.separated(
              state: state,
              fetchNextPage: fetchNextPage,
              builderDelegate: PagedChildBuilderDelegate<Product>(
                // 각 아이템 빌드
                itemBuilder: (context, product, index) {
                  return GestureDetector(
                    onTap: () {
                      // 최근 본 상품에 추가
                      ref
                          .read(recentProductsProvider.notifier)
                          .addProduct(
                            RecentProduct(
                              no: product.no,
                              title: product.title,
                              thumbnailUrl: product.thumb,
                              price: product.price,
                              minNumber: product.unitQty,
                            ),
                          );

                      // 상품 상세 페이지로 이동
                      GoRouter.of(context).pushNamed(
                        RouteNames.productDetail,
                        pathParameters: {'productNo': product.no},
                      );
                    },
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        // 원형 이미지 + 크기 지정
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            product.thumb,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // 이미지 로드 실패 시 대체 위젯
                              return Container(
                                width: 100,
                                height: 100,
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.broken_image),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.title), // 상품 제목
                                Text(
                                  // 가격 포맷팅
                                  '${NumberUtils.formatPrice(int.parse(product.price))}원',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                // 첫 페이지 로딩 커스텀 위젯
                firstPageProgressIndicatorBuilder: (context) {
                  return ProductSkeleton();
                },
                // 다음 페이지 로딩 중 커스텀 위젯
                newPageProgressIndicatorBuilder: (context) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                // 아이템이 하나도 없을 때 표시
                noItemsFoundIndicatorBuilder: (context) => const Center(
                  child: Text('No products found'), // 아이템 없음 표시
                ),
                // 마지막 아이템 표시
                noMoreItemsIndicatorBuilder: (context) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'No more products!', // 더 이상 상품 없음
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                },
                // 첫 페이지 로딩 중 에러 발생 시 표시
                firstPageErrorIndicatorBuilder: (context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 50,
                      horizontal: 30,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Something went wrong', // 에러 메시지
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${_pagingController.error}', // 에러 상세
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        OutlinedButton(
                          onPressed: () =>
                              _pagingController.refresh(), // 재시도 버튼
                          child: const Text(
                            'Try Again!',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              // 각 아이템 사이 구분선
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
        ),
      ),
    );
  }
}
