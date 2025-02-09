import 'package:floor/floor.dart';
import 'package:news_app/features/daily_news/data/models/ArticleModel.dart';

@dao
abstract class ArticleDao {
  //on local database
  @delete
  Future<void> deleteArticle(ArticleModel article);

  @Query("SELECT * FROM articles")
  Future<List<ArticleModel>> getArticles();

  @Insert()
  Future<void> insertArticle(ArticleModel article);
}
