import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/entity/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repo.dart';

class SaveArticleUsecase implements Usecase<void, ArticleEntity> {
  final ArticleRepository articleRepository;
  SaveArticleUsecase(this.articleRepository);
  @override
  Future<void> call({ArticleEntity? params}) {
    return articleRepository.saveArticle(params!);
  }
}
