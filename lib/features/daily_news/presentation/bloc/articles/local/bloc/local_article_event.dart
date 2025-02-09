import 'package:equatable/equatable.dart';
import 'package:news_app/features/daily_news/domain/entity/article.dart';

abstract class LocalArticleEvent extends Equatable {
  final ArticleEntity? articleEntity;
  const LocalArticleEvent({this.articleEntity});
  @override
  List<Object> get props => [articleEntity!];
}

class GetSavedArticles extends LocalArticleEvent {
  const GetSavedArticles();
}

class RemoveArticle extends LocalArticleEvent {
  const RemoveArticle();
}

class SaveArticle extends LocalArticleEvent {
  const SaveArticle();
}
