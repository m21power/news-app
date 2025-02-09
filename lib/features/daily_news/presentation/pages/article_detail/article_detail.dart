import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/domain/entity/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/articles/local/bloc/local_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/articles/local/bloc/local_article_event.dart';
import 'package:news_app/injection_container.dart';

class ArticleDetail extends StatelessWidget {
  final ArticleEntity article; //

  const ArticleDetail({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LocalArticleBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Article Detail',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleAndDate(article),
                const SizedBox(height: 20),
                if (article.urlToImage != null &&
                    article.urlToImage!.isNotEmpty)
                  Image.network(
                    article.urlToImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 100),
                  ),
                const SizedBox(height: 20),
                if (article.description != null)
                  Text(
                    article.description!,
                    style: const TextStyle(fontSize: 16),
                  ),
                if (article.content != null)
                  Text(
                    article.content!,
                    style: const TextStyle(fontSize: 16),
                  ),
              ],
            ),
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            elevation: 4,
            onPressed: () {
              context.read<LocalArticleBloc>().add(SaveArticle(article));

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Article saved successfully!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Icon(
              Icons.bookmark,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget titleAndDate(ArticleEntity article) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          article.title ?? 'No Title',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          article.publishedAt ?? 'Unknown Date',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
