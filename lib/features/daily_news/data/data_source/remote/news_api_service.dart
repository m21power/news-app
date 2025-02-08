import 'package:dio/dio.dart';
import 'package:news_app/core/constant/constants.dart';

class NewsApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: newsApiBaseUrl));

  Future<Response> getNewsArticle(String apiKey, String country) async {
    try {
      Response response = await _dio.get(
        '/top-headlines',
        queryParameters: {
          'apiKey': apiKey,
          'country': country,
        },
      );
      return response;
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }
}
