import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_article_usecase.dart';
import 'package:news_app/features/daily_news/presentation/bloc/articles/remote/bloc/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/articles/remote/bloc/remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUsecase getArticleUsecase;
  RemoteArticleBloc(this.getArticleUsecase) : super(RemoteArticleLoading()) {
    on<GetArticles>(onGetArticles);
  }
  void onGetArticles(
      GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await getArticleUsecase.call();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(
        RemoteArticlesDone(dataState.data!),
      );
    }
    if (dataState is DataFailed) {
      emit(
        RemoteArticlesError(dataState.error!),
      );
    }
  }
}
