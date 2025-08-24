import 'package:intl/intl.dart';

class NumberUtils {
  /// int 또는 double 가격을 3자리 콤마로 변환
  static String formatPrice(num? price) {
    if (price == null) return '0';
    final formatter = NumberFormat('#,###'); // 기본 3자리 콤마
    return formatter.format(price);
  }
}
