// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:news_app/features/daily_news/domain/entity/article.dart';

abstract class RemoteArticleState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioException? error;
  const RemoteArticleState({
    this.articles,
    this.error,
  });

  @override
  List<Object> get props => [articles!, error!];
}

class RemoteArticleLoading extends RemoteArticleState {
  const RemoteArticleLoading();
}

class RemoteArticlesDone extends RemoteArticleState {
  const RemoteArticlesDone(List<ArticleEntity> article)
      : super(articles: article);
}

class RemoteArticlesError extends RemoteArticleState {
  const RemoteArticlesError(DioException error) : super(error: error);
}
