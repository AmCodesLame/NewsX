import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/articles/articles.dart';

class ArticleListItem extends StatelessWidget {
  const ArticleListItem({required this.article, super.key});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${article.publishedAt}', style: textTheme.bodySmall),
        title: Text(article.title ?? "loading"),
        isThreeLine: true,
        subtitle: Text(article.description ?? "loading subs"),
        dense: true,
      ),
    );
  }
}
