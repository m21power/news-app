import 'dart:io';

import 'package:news_app/core/constant/constants.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/data/data_source/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/models/ArticleModel.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repo.dart';
import 'package:dio/dio.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService newsApiService;
  const ArticleRepositoryImpl(this.newsApiService);
  @override
  Future<DataState<List<ArticleModel>>> getNewsArticle() async {
    try {
      final httpResponse =
          await newsApiService.getNewsArticle(newsApikey, newsCountry);
      if (httpResponse.statusCode == HttpStatus.ok) {
        // Convert JSON response to List<ArticleModel>
        List<ArticleModel> articles = [];
        var article = httpResponse.data['articles'] as List;
        for (var artic in article) {
          articles.add(ArticleModel.fromJson(artic));
        }
        return DataSuccess(articles);
      } else {
        return DataFailed(DioException(
            error: httpResponse.statusMessage,
            response: httpResponse,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
