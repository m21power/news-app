import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_saved_articles.dart';
import 'package:news_app/features/daily_news/domain/usecases/remote_article_usecase.dart';
import 'package:news_app/features/daily_news/domain/usecases/save_article_usecase.dart';
import 'package:news_app/features/daily_news/presentation/bloc/articles/local/bloc/local_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/articles/local/bloc/local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticleState> {
  final GetSavedArticlesUsecase getSavedArticlesUsecase;
  final SaveArticleUsecase saveArticleUsecase;
  final RemoveArticleUsecase removeArticleUsecase;
  LocalArticleBloc(this.getSavedArticlesUsecase, this.removeArticleUsecase,
      this.saveArticleUsecase)
      : super(LocalArticlesLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<RemoveArticle>(onRemoveArticles);
    on<SaveArticle>(onSaveArticles);
  }
  void onGetSavedArticles(
      GetSavedArticles event, Emitter<LocalArticleState> emit) async {
    final articles = await getSavedArticlesUsecase();
    emit(LocalArticlesDone(article: articles));
  }

  void onRemoveArticles(
      RemoveArticle article, Emitter<LocalArticleState> emit) async {
    await removeArticleUsecase(params: article.articleEntity);
    final art = await getSavedArticlesUsecase();
    emit(LocalArticlesDone(article: art));
  }

  void onSaveArticles(
      SaveArticle article, Emitter<LocalArticleState> emit) async {
    await saveArticleUsecase(params: article.articleEntity);
    final art = await getSavedArticlesUsecase();
    emit(LocalArticlesDone(article: art));
  }
}
