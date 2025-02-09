import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/data/models/ArticleModel.dart';
import 'package:news_app/features/daily_news/domain/entity/article.dart';

class ArticleDetail extends StatelessWidget {
  final ArticleEntity? article;
  const ArticleDetail({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleAndDate(
                article!,
              ),
              SizedBox(height: 20),
              Image.network(
                article!.urlToImage.toString(),
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                article!.description.toString(),
                style: TextStyle(fontSize: 16),
              ),
              Text(
                article!.content.toString(),
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {},
        child: Icon(
          Icons.bookmark,
          color: Colors.blue,
          size: 50,
        ),
      ),
    );
  }

  Widget titleAndDate(ArticleEntity article) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title.toString(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            article.publishedAt.toString(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
