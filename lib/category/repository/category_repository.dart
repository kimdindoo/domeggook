import 'package:dio/dio.dart';
import 'package:domeggook/config/dio/dio_provider.dart';
import 'package:domeggook/category/model/category_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_repository.g.dart';

class CategoryRepository {
  final Dio dio;
  CategoryRepository(this.dio);

  Future<CategoryModel> getCategory() async {
    final response = await dio.get(
      '',
      queryParameters: {
        'ver': '1.0',
        'mode': 'getCategoryList',
        'aid': dotenv.env['API_KEY'],
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

    return CategoryModel.fromJson(response.data);
  }
}

@riverpod
CategoryRepository categoryRepository(Ref ref) {
  final dio = ref.read(dioProvider);
  return CategoryRepository(dio);
}
