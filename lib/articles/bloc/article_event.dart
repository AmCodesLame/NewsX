part of 'article_bloc.dart';

abstract class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

final class ArticleFetched extends ArticleEvent {}

// final class ArticleDownloaded extends ArticleEvent {}
