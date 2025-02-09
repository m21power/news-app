import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/entity/article.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticle();

  //on local database
  Future<void> removeArticle(ArticleEntity article);
  Future<List<ArticleEntity>> getSavedArticles();
  Future<void> saveArticle(ArticleEntity article);
}
