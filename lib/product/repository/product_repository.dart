import 'package:dio/dio.dart';
import 'package:domeggook/product/model/category_model.dart';
import 'package:domeggook/product/model/product_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final dio = Dio();

Future<ProductModel> getProductByKeyword(String keyword) async {
  try {
    final Response response = await dio.get(
      'https://domeggook.com/ssl/api',
      queryParameters: {
        'ver': '4.1',
        'mode': 'getItemList',
        'aid': dotenv.env['API_KEY'], // .env에 API_KEY 설정 필요
        'market': 'dome',
        'om': 'json',
        'kw': keyword,
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

    print(product.domeggook);

    return product;
  } catch (e) {
    rethrow;
  }
}

Future<ProductModel> getProductByCategory(String categoryNumber) async {
  try {
    final Response response = await dio.get(
      'https://domeggook.com/ssl/api',
      queryParameters: {
        'ver': '4.1',
        'mode': 'getItemList',
        'aid': dotenv.env['API_KEY'], // .env에 API_KEY 설정 필요
        'market': 'dome',
        'om': 'json',
        'ca': categoryNumber,
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

    print(product.domeggook);

    return product;
  } catch (e) {
    rethrow;
  }
}

Future<CategoryModel> getCategory() async {
  try {
    final Response response = await dio.get(
      'https://domeggook.com/ssl/api',
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

    print(category);

    return category;
  } catch (e) {
    rethrow;
  }
}
