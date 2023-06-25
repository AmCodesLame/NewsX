import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
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
        // final articles = await _fetchArticles();
        var response = await http.get(Uri.parse(
            'https://newsapi.org/v2/top-headlines?country=us&apiKey=ba130b65aeb5412f8ae7c0714a498535'));
        List<Article>? newsContent = [];
        if (response.statusCode == 200) {
          Map<String, dynamic> result = jsonDecode(response.body);
          // List<Article>? newsContent = [];

          Newsdata news = Newsdata.fromJson(result);
          newsContent = news.articles;
        }
        final articles = newsContent;
        return emit(state.copyWith(
            status: ArticleStatus.success,
            hasReachedMax: false,
            articles: articles));
      }

      var response = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=us&apiKey=ba130b65aeb5412f8ae7c0714a498535'));
      List<Article>? newsContent = [];
      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);
        // List<Article>? newsContent = [];

        Newsdata news = Newsdata.fromJson(result);
        newsContent = news.articles;
      }
      final articles = newsContent;
      // final articles = await _fetchArticles();
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

  Future<List<Article>> _fetchArticles([int startIndex = 0]) async {
    var response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=ba130b65aeb5412f8ae7c0714a498535'));
    // final response = await httpClient.get(
    //   Uri.https(
    //     'newsapi.org',
    //     '/v2/top-headlines',
    //     <String, String>{
    //       'country': 'us',
    //       'apiKey': '23653c70e09445809ab7f7b8c78f4d25'
    //     },
    //   ),
    // );
    if (response.statusCode == 200) {
      // Map<String, dynamic> result = jsonDecode(response.body);
      // List<Article>? newsContent = [];

      // Newsdata news = Newsdata.fromJson(result);
      // List<Article>? newsContent = news.articles;
      // return newsContent;
      // final body = json.decode(response.body) as Map<String, dynamic>;
      // final data = body["articles"] as List;
      // return data.map((dynamic json) {
      //   final map = json as Map<String, dynamic>;
      //   return Article(
      //       author: map['id'],
      //       title: map['id'],
      //       description: map['id'],
      //       url: map['id'],
      //       urlToImage: map['id'],
      //       publishedAt: map['id'],
      //       content: map['id']);
      // }).toList();
    }
    throw Exception('error fetching Articles');
  }
}
