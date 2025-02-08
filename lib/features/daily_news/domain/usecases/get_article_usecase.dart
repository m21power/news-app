import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/entity/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repo.dart';

class GetArticleUsecase
    implements Usecase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository articleRepository;
  GetArticleUsecase(this.articleRepository);
  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return articleRepository.getNewsArticle();
  }
}
