import 'package:domeggook/common/layout/default_layout.dart';
import 'package:domeggook/common/skeleton/product_detail_skeleton.dart';
import 'package:domeggook/common/utils/number_utils.dart';
import 'package:domeggook/common/view/error_screen.dart';
import 'package:domeggook/product/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key, required this.productNo});

  final String productNo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productDetail = ref.watch(productDetailProvider(productNo));

    return DefaultLayout(
      title: '',
      child: productDetail.when(
        data: (data) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: Image.network(
                    data.domeggook.thumb.large!,
                    fit: BoxFit.cover, // 화면 꽉 채우기
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Icon(Icons.broken_image));
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 상품명
                      Text(
                        data.domeggook.basis.title!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // 가격
                      Text(
                        formatPriceRange(data.domeggook.price.dome!),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // 최소 구매 수량
                      Row(
                        children: [
                          Text(
                            '최소구매수량 ${data.domeggook.qty.domeMoq}개',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(width: 8),
                          if (data.domeggook.qty.domeLoq != null)
                            Text('최대구매수량 ${data.domeggook.qty.domeLoq}개)'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // 배송 정보
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('배송정보', style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 8),
                          Expanded(
                            //  텍스트가 길어질 수 있으므로 Expanded로 감싸줌
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  parseDeliveryFee(
                                    type: data.domeggook.deli.dome?.type ?? '',
                                    tbl: data.domeggook.deli.dome?.tbl ?? '',
                                    pay: data.domeggook.deli.pay!,
                                    fee: data.domeggook.deli.dome?.fee,
                                  ),
                                ),
                                Text(
                                  '${data.domeggook.deli.wating} (평균 출고일 약 ${data.domeggook.deli.sendAvg}일)',
                                ),
                                if (data.domeggook.deli.merge?.enable != null &&
                                    getMergeText(
                                      data.domeggook.deli.merge!.enable,
                                    ).isNotEmpty)
                                  Text(
                                    getMergeText(
                                      data.domeggook.deli.merge!.enable,
                                    ),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      buildInfoRow(
                        '재고수량',
                        '${NumberUtils.formatPrice(int.tryParse(data.domeggook.qty.inventory ?? '0') ?? 0)}개',
                      ),
                      buildInfoRow(
                        '원산지',
                        (data.domeggook.detail.country ?? '').replaceAll(
                          '_',
                          ' / ',
                        ),
                      ),
                      buildInfoRow('공급사', data.domeggook.seller.nick!),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => ProductDetailSkeleton(),
        error: (err, _) => ErrorScreen(),
      ),
    );
  }
}

Widget buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 8),
        Expanded(child: Text(value)),
      ],
    ),
  );
}

// 가격 범위 포맷팅
String formatPriceRange(String rawPrice) {
  if (rawPrice.contains('|')) {
    // 여러 구간 가격
    final parts = rawPrice.split('|');
    final prices = parts
        .map((p) {
          final pair = p.split('+');
          return pair.length == 2 ? int.tryParse(pair[1]) : null;
        })
        .whereType<int>()
        .toList();

    if (prices.isEmpty) return rawPrice;

    final minPrice = prices.reduce((a, b) => a < b ? a : b);
    final maxPrice = prices.reduce((a, b) => a > b ? a : b);

    return '${NumberUtils.formatPrice(minPrice)}원 ~ ${NumberUtils.formatPrice(maxPrice)}원';
  } else {
    // 단일 가격
    final price = int.tryParse(rawPrice);
    return price != null ? '${NumberUtils.formatPrice(price)}원' : rawPrice;
  }
}

/// 배송비 파싱
String parseDeliveryFee({
  required String type,
  required String tbl,
  required String pay,
  String? fee,
}) {
  if (pay == "무료배송") return "무료배송";
  if (type == "금액비노출") return "배송비 정보 없음";

  if (type == "고정배송비") {
    if (fee == null) return "배송비 정보 없음";
    final price = int.tryParse(fee) ?? 0;
    return "${NumberUtils.formatPrice(price)}원 (고정)";
  }

  if (type == "수량별차등") {
    final parts = tbl.split("|");
    final ranges = <String>[];

    for (var i = 0; i < parts.length; i++) {
      final split = parts[i].split("+");
      if (split.length != 2) continue;

      final minQty = int.tryParse(split[0]) ?? 0;
      final price = int.tryParse(split[1]) ?? 0;

      String range;
      if (i + 1 < parts.length) {
        final nextMinQty =
            int.tryParse(parts[i + 1].split("+")[0]) ?? (minQty + 1);
        range =
            "$minQty ~ ${nextMinQty - 1}개: ${NumberUtils.formatPrice(price)}원";
      } else {
        range = "$minQty개 이상: ${NumberUtils.formatPrice(price)}원";
      }

      ranges.add(range);
    }

    return ranges.join(" / ");
  }

  if (type == "수량별비례") {
    final parts = tbl.split("|");
    final details = <String>[];

    for (var i = 0; i < parts.length; i++) {
      final split = parts[i].split("+");
      if (split.length != 2) continue;

      final baseQty = int.tryParse(split[0]) ?? 0;
      final price = int.tryParse(split[1]) ?? 0;

      if (i == 0) {
        details.add("$baseQty개까지 ${NumberUtils.formatPrice(price)}원");
      } else {
        details.add("이후 $baseQty개마다 ${NumberUtils.formatPrice(price)}원 추가");
      }
    }

    return details.join(" / ");
  }

  return "배송비 정보 없음";
}

// 묶음 배송
String getMergeText(String? enable) {
  switch (enable) {
    case "y":
      return '묶음배송 가능 (동일 출고지 상품만 가능)';
    case "n":
      return '묶음배송 불가능';
    case "c":
      return '묶음배송 조건부 가능';
    default:
      return '';
  }
}
