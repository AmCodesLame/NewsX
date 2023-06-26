part of 'single_article_bloc.dart';

abstract class SingleArticleEvent extends Equatable {
  const SingleArticleEvent();

  @override
  List<Object> get props => [];
}

final class ArticleDownloaded extends SingleArticleEvent {}
