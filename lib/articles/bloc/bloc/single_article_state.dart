part of 'single_article_bloc.dart';

final class SingleArticleState extends Equatable {
  const SingleArticleState({this.downloadState = false});

  final bool downloadState;

  SingleArticleState copyWith({bool? downloadState}) {
    return SingleArticleState(
        downloadState: downloadState ?? this.downloadState);
  }

  @override
  String toString() {
    return '''SingleArticleState { downloadState: $downloadState }''';
  }

  @override
  List<Object> get props => [downloadState];
}
