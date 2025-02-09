import 'package:floor/floor.dart';
import 'package:news_app/features/daily_news/domain/entity/article.dart';

@Entity(tableName: "articles", primaryKeys: ['id'])
class ArticleModel extends ArticleEntity {
  const ArticleModel(
      {int? id,
      String? author,
      String? title,
      String? description,
      String? url,
      String? urlToImage,
      String? publishedAt,
      String? content})
      : super(
          id: id,
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
        );
  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
        author: map["author"] ?? "",
        title: map["title"] ?? "",
        description: map["description"] ?? "",
        url: map["url"] ?? "",
        urlToImage: map["urlToImage"] ?? "",
        publishedAt: map["publishedAt"] ?? "",
        content: map["content"] ?? "");
  }
  factory ArticleModel.fromEntity(ArticleEntity article) {
    return ArticleModel(
        id: article.id,
        author: article.author,
        title: article.title,
        description: article.description,
        url: article.url,
        urlToImage: article.urlToImage,
        publishedAt: article.publishedAt,
        content: article.content);
  }

  ArticleEntity toEntity() {
    return ArticleEntity(
        id: id,
        author: author,
        title: title,
        description: description,
        url: url,
        urlToImage: urlToImage,
        publishedAt: publishedAt,
        content: content);
  }
}
