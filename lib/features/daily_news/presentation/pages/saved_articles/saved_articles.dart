import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/domain/entity/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/articles/local/bloc/local_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/articles/local/bloc/local_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/articles/local/bloc/local_article_state.dart';
import 'package:news_app/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:news_app/injection_container.dart';

class SavedArticles extends StatelessWidget {
  const SavedArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalArticleBloc>(
      create: (context) => sl<LocalArticleBloc>()..add(GetSavedArticles()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Saved Articles",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: BlocBuilder<LocalArticleBloc, LocalArticleState>(
          builder: (context, state) {
            if (state is LocalArticlesLoading) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            if (state is LocalArticlesDone) {
              return ListView.builder(
                itemCount: state.article!.length,
                itemBuilder: (context, index) {
                  final article = state.article![index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ArticleDetail(article: article)),
                      );
                    },
                    child: savedCard(context, article),
                  );
                },
              );
            } else {
              return const Center(
                child: Icon(Icons.refresh),
              );
            }
          },
        ),
      ),
    );
  }

  Card savedCard(BuildContext context, ArticleEntity article) {
    return Card(
      color: Colors.white,
      elevation: 0.1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        trailing: GestureDetector(
          onTap: () {
            BlocProvider.of<LocalArticleBloc>(context)
                .add(RemoveArticle(article));
          },
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.08),
            child: Icon(
              Icons.remove,
              color: Colors.red,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.all(12),
        leading: article.urlToImage != null && article.urlToImage!.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  article.urlToImage!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 50),
                ),
              )
            : const Icon(Icons.image_not_supported, size: 50),
        title: Text(
          article.title ?? 'No Title',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          article.publishedAt ?? 'Unknown Date',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
    );
  }
}
