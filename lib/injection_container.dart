import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:news_app/features/daily_news/data/data_source/local/app_database.dart';
import 'package:news_app/features/daily_news/data/data_source/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/repository/repository_impl.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repo.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_article_usecase.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_saved_articles.dart';
import 'package:news_app/features/daily_news/domain/usecases/remote_article_usecase.dart';
import 'package:news_app/features/daily_news/domain/usecases/save_article_usecase.dart';
import 'package:news_app/features/daily_news/presentation/bloc/articles/remote/bloc/remote_article_bloc.dart';

final sl = GetIt.instance;

Future<void> initialDependencies() async {
  //local database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);
  //dio
  sl.registerSingleton<Dio>(Dio());

  // dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService());

  //repository
  sl.registerSingleton<ArticleRepository>(
    ArticleRepositoryImpl(sl(), sl()),
  );

  //usecases
  sl.registerSingleton<GetArticleUsecase>(
    GetArticleUsecase(sl()),
  );

  sl.registerSingleton<GetSavedArticlesUsecase>(
    GetSavedArticlesUsecase(sl()),
  );

  sl.registerSingleton<RemoveArticleUsecase>(
    RemoveArticleUsecase(sl()),
  );

  sl.registerSingleton<SaveArticleUsecase>(
    SaveArticleUsecase(sl()),
  );
  //bloc shouldn't instantiated using singleton cuz singleton gives us one instance perlife time of the app
  sl.registerFactory<RemoteArticleBloc>(
    () => RemoteArticleBloc(sl()),
  );
}
