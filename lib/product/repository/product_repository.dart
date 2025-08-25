import 'package:dio/dio.dart';
import 'package:domeggook/config/dio/dio_provider.dart';
import 'package:domeggook/product/model/category_model.dart';
import 'package:domeggook/product/model/product_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_repository.g.dart';

const limit = 20;

class ProductRepository {
  final Dio dio;

  ProductRepository(this.dio);

  Future<List<Product>> getProductByKeyword(int page, String keyword) async {
    try {
      final Response response = await dio.get(
        '',
        queryParameters: {
          'ver': '4.1',
          'mode': 'getItemList',
          'aid': dotenv.env['API_KEY'], // .env에 API_KEY 설정 필요
          'market': 'dome',
          'om': 'json',
          'kw': keyword,
          // 'sz': 20,
          // sz 미입력시 20이 기본값
          'pg': page, // 페이지 번호
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Request failed\n\nStatus Code: ${response.statusCode}.\nReason: ${response.statusMessage}',
        );
      }

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      final product = ProductModel.fromJson(response.data);

      return product.domeggook.list.item;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> getProductByCategory(
    int page,
    String categoryNumber,
  ) async {
    try {
      final Response response = await dio.get(
        '',
        queryParameters: {
          'ver': '4.1',
          'mode': 'getItemList',
          'aid': dotenv.env['API_KEY'], // .env에 API_KEY 설정 필요
          'market': 'dome',
          'om': 'json',
          'ca': categoryNumber,
          // 'sz': 20,
          // sz 미입력시 20이 기본값
          'pg': page, // 페이지 번호
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Request failed\n\nStatus Code: ${response.statusCode}.\nReason: ${response.statusMessage}',
        );
      }

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      final product = ProductModel.fromJson(response.data);

      return product.domeggook.list.item;
    } catch (e) {
      rethrow;
    }
  }

  Future<CategoryModel> getCategory() async {
    try {
      final Response response = await dio.get(
        '',
        queryParameters: {
          'ver': '1.0',
          'mode': 'getCategoryList',
          'aid': dotenv.env['API_KEY'], // .env에 API_KEY 설정 필요
          'om': 'json',
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Request failed\n\nStatus Code: ${response.statusCode}.\nReason: ${response.statusMessage}',
        );
      }

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      final category = CategoryModel.fromJson(response.data);

      return category;
    } catch (e) {
      rethrow;
    }
  }
}

@riverpod
ProductRepository productRepository(Ref ref) {
  return ProductRepository(ref.watch(dioProvider));
}
