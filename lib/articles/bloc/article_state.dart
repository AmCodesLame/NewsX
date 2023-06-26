part of 'article_bloc.dart';

enum ArticleStatus { initial, success, failure }

final class ArticleState extends Equatable {
  const ArticleState(
      {this.status = ArticleStatus.initial,
      this.articles = const <Article>[],
      this.hasReachedMax = false,
      this.errorMessage = 'null',
      this.downloadState = false});

  final ArticleStatus status;
  final List<Article> articles;
  final bool hasReachedMax;
  final String errorMessage;
  final bool downloadState;

  ArticleState copyWith(
      {ArticleStatus? status,
      List<Article>? articles,
      bool? hasReachedMax,
      String? errorMessage,
      bool? downloadState}) {
    return ArticleState(
        status: status ?? this.status,
        articles: articles ?? this.articles,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        errorMessage: errorMessage ?? this.errorMessage,
        downloadState: downloadState ?? this.downloadState);
  }

  @override
  String toString() {
    return '''ArticleState { status: $status, hasReachedMax: $hasReachedMax, articles: ${articles.length}, errorMessage: $errorMessage, downloadState: $downloadState }''';
  }

  @override
  List<Object> get props => [status, articles, hasReachedMax, errorMessage];
}

// class ArticleInitial extends ArticleState {}
