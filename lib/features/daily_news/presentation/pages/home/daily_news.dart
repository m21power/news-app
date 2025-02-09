import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/features/daily_news/presentation/bloc/articles/remote/bloc/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/pages/saved_articles/saved_articles.dart';
import 'package:news_app/features/daily_news/presentation/widgets/article_widget.dart';

import '../../bloc/articles/remote/bloc/remote_article_state.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: buildBody(),
    );
  }

  appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Daily News",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SavedArticles(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.bookmark,
              color: Colors.black,
              size: 40,
            ),
          ),
        )
      ],
    );
  }

  buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (_, state) {
        if (state is RemoteArticleLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }

        if (state is RemoteArticlesDone) {
          return ListView.builder(
            itemCount: state.articles!.length,
            itemBuilder: (context, index) =>
                ArticleWidget(article: state.articles![index]),
          );
        } else {
          return const Center(
            child: Icon(Icons.refresh),
          );
        }
      },
    );
  }
}
