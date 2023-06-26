import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_infinite_list/articles/articles.dart';

part 'article_event.dart';
part 'article_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc({required this.httpClient}) : super(const ArticleState()) {
    // on<ArticleDownloaded>(_onArticleDownloaded);
    on<ArticleFetched>(
      _onArticleFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  FutureOr<void> _onArticleFetched(
      ArticleFetched event, Emitter<ArticleState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ArticleStatus.initial) {
        final articles = await _fetchArticles();
        final downloadedArticle = Downloaded()..articles = articles;
        final box = Hive.box<Downloaded>("create");
        box.put("saved", downloadedArticle);
        return emit(state.copyWith(
            status: ArticleStatus.success,
            hasReachedMax: false,
            articles: articles));
      }
      final articles = await _fetchArticles();
      emit(articles!.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: ArticleStatus.success,
              articles: List.of(state.articles)..addAll(articles),
              hasReachedMax: false,
            ));
    } catch (e) {
      emit(state.copyWith(
          status: ArticleStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<List<Article>?> _fetchArticles() {
    var response = http
        .get(Uri.parse(
            'https://newsapi.org/v2/top-headlines?country=us&apiKey=3a154c098d634c85b6204f438e0bcbdd'))
        .then(
      (value) {
        if (value.statusCode == 200) {
          Map<String, dynamic> result = jsonDecode(value.body);
          // List<Article>? newsContent = [];

          NewsRepo news = NewsRepo.fromJson(result);
          return news.articles;
        }
        throw Exception('error fetching Articles');
      },
    );
    return response;
  }

  // void _onArticleDownloaded(
  //     ArticleDownloaded event, Emitter<ArticleState> emit) {
  //   return emit(state.copyWith(
  //       downloadState: true,
  //       status: ArticleStatus.success,
  //       errorMessage: "WHY IS THIS NOT WORKING"));
  // }
}
