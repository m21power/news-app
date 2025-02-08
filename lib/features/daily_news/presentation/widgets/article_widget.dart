import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/domain/entity/article.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity? article;

  const ArticleWidget({Key? key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 2.2,
      padding: const EdgeInsetsDirectional.only(
          start: 14, end: 14, top: 10, bottom: 5),
      child: Row(
        children: [buildImage(context), buildTitleAndDescription()],
      ),
    );
  }

  ///image section
  Widget buildImage(BuildContext context) {
    String imageUrl = article?.urlToImage ?? "";

    return CachedNetworkImage(
      imageUrl: imageUrl.isNotEmpty
          ? imageUrl
          : "https://via.placeholder.com/150", // Default image
      imageBuilder: (context, imageProvider) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.08),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, progress) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.infinity,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.08)),
            child: const Center(child: CupertinoActivityIndicator()),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.08)),
            child: const Icon(Icons.error, color: Colors.black, size: 40),
          ),
        ),
      ),
    );
  }

  /// Builds the title and description
  Widget buildTitleAndDescription() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              article?.title ?? "No title available",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontFamily: "Butler",
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: Colors.black87),
            ),
            // Description
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  article?.description ?? "No description available",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // Published Date
            Row(
              children: [
                const Icon(
                  Icons.timeline_outlined,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  article?.publishedAt ?? "Unknown date",
                  style: const TextStyle(fontSize: 12),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
