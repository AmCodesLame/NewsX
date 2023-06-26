import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'single_article_event.dart';
part 'single_article_state.dart';

class SingleArticleBloc extends Bloc<SingleArticleEvent, SingleArticleState> {
  SingleArticleBloc() : super(SingleArticleState()) {
    on<ArticleDownloaded>(_onArticleDownloaded);
  }

  void _onArticleDownloaded(
      ArticleDownloaded event, Emitter<SingleArticleState> emit) {
    return emit(state.copyWith(downloadState: true));
  }
}
