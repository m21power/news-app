import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/entity/article.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticle();
}
