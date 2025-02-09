import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/entity/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repo.dart';

class RemoveArticleUsecase implements Usecase<void, ArticleEntity> {
  final ArticleRepository articleRepository;
  RemoveArticleUsecase(this.articleRepository);
  @override
  Future<void> call({ArticleEntity? params}) {
    return articleRepository.removeArticle(params!);
  }
}
