import 'package:domeggook/common/skeleton/product_skeleton.dart';
import 'package:domeggook/common/utils/number_utils.dart';
import 'package:domeggook/common/utils/pagination_helper.dart';
import 'package:domeggook/product/model/product_model.dart';
import 'package:domeggook/product/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class KeywordProductScreen extends ConsumerStatefulWidget {
  const KeywordProductScreen({super.key, required this.keyword});

  final String keyword;

  @override
  ConsumerState<KeywordProductScreen> createState() =>
      _KeywordProductScreenState();
}

class _KeywordProductScreenState extends ConsumerState<KeywordProductScreen> {
  // pageSize는 product_repository에서 정의된 limit 사용
  final _paginationHelper = PaginationHelper(pageSize: limit);

  // getNextPageKey: 다음 페이지 키를 결정
  // fetchPage: 실제 데이터를 가져오는 함수
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
        fetchPage: (pageKey) => fetchPage(pageKey, widget.keyword),
      );

  // 실제 데이터 가져오는 함수
  Future<List<Product>> fetchPage(int pageKey, String categoryNumber) async {
    final newProducts = await ref
        .read(productRepositoryProvider) // Riverpod을 통해 Repository 가져오기
        .getProductByKeyword(pageKey, categoryNumber); // 카테고리별 제품 요청

    return newProducts;
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: RefreshIndicator(
        // 당겨서 새로고침 기능
        onRefresh: () async {
          _paginationHelper.reset(); // PaginationHelper 초기화
          _pagingController.refresh(); // PagingController 새로고침
        },
        child: PagingListener(
          controller: _pagingController,
          builder: (context, state, fetchNextPage) =>
              PagedListView<int, Product>.separated(
                state: state,
                fetchNextPage: fetchNextPage,
                builderDelegate: PagedChildBuilderDelegate(
                  // 각 아이템 빌드
                  itemBuilder: (context, product, index) {
                    return GestureDetector(
                      onTap: () {},
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
                  noItemsFoundIndicatorBuilder: (context) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          'No products found',
                          style: TextStyle(fontSize: 20),
                        ),
                      ), // 아이템 없음 표시
                    );
                  },
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
    );
  }
}
